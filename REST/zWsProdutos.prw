#Include 'protheus.ch'
#Include 'TOPCONN.ch'
#Include 'totvs.ch'
#Include 'RESTFul.ch'

// * Cria atributos = query_parameters e métodos

WSRESTFUL zWSProdutos DESCRIPTION 'WebService Cadastro de Produtos'

    // * Atributos
    WSDATA id         as STRING
    WSDATA updated_at as STRING
    WSDATA limit      as INTEGER
    WSDATA page       as INTEGER

    // * Métodos
    WSMETHOD GET ID DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/zWSProdutos/get_id?{id}' PATH 'get_id' PRODUCES APPLICATION_JSON
    WSMETHOD GET ALL DESCRIPTION 'Retorna todos os registros' WSSYNTAX '/zWSProdutos/get_all?{updated_at, limit, page}' PATH 'get_all' PRODUCES APPLICATION_JSON
    WSMETHOD POST NEW DESCRIPTION 'Inclusão de registro' WSSYNTAX '/zWSProdutos/new' PATH 'new' PRODUCES APPLICATION_JSON

END WSRESTFUL

WSMETHOD GET ID WSRECEIVE id WSSERVICE zWSProdutos
    Local lRet                  := .T.
    Local jResponse             := jsonObject():New()
    Local cAliasWs              := 'SB1'

    // * Se o id estiver vazio
    If Empty(::id)
        Self:SetStatus(500)
        jResponse[ 'errorId' ]      := 'ID001'
        jResponse[ 'error' ]        := 'ID vazio'
        jResponse[ 'solution' ]     := 'informe o ID'
    Else
        DbSelectArea(cAliasWs)
        ( cAliasWs )->( DbSetOrder(1) )

        // * Se não encontrar o registro
        If ! ( cAliasWs )->( MsSeek( FwxFilial(cAliasWs) + ::id ) )
            Self:SetStatus(500)
            jResponse[ 'errorId' ]      := 'ID002'
            jResponse[ 'error' ]        := 'ID não encontrado'
            jResponse[ 'solution' ]     := 'Código ID não encontrado na tabela ' + cAliasWs
        Else
            // * Define retorno
            jResponse[ 'cod' ]          := ( cAliasWs )->B1_COD
            jResponse[ 'desc' ]         := ( cAliasWs )->B1_DESC
            jResponse[ 'tipo' ]         := ( cAliasWs )->B1_TIPO
            jResponse[ 'um' ]           := ( cAliasWs )->B1_UM
            jResponse[ 'locpad' ]       := ( cAliasWs )->B1_LOCPAD
            jResponse[ 'grupo' ]        := ( cAliasWs )->B1_GRUPO
        EndIf
    EndIf

    Self:SetContentType( 'application/json' )
    Self:SetResponse(jResponse:toJSON())
Return lRet

WSMETHOD GET ALL WSRECEIVE updated_at, limit, page, WSSERVICE zWSProdutos
    Local lRet                  := .T.
    Local jResponse             := jsonObject():New()
    Local cQueryTab             := ''
    Local nTamanho              := 10
    Local nTotal                := 0
    Local nPags                 := 0
    Local nPagina               := 0
    Local nAtual                := 0
    Local cAliasWs              := 'SB1'
    Local oRegistro

    // * Efetua busca dos registros
    cQueryTab                   := " SELECT " + CRLF
    cQueryTab                   := " TAB.R_E_C_N_O AS TABREC " + CRLF
    cQueryTab                   := " FROM " + CRLF
    cQueryTab                   := " " + RetSqlName(cAliasWs) + " TAB " + CRLF
    cQueryTab                   := " WHERE " + CRLF
    cQueryTab                   := " TAB.D_E_L_E_T_ = '' " + CRLF

    If ! Empty(::updated_at)
        cQueryTab += " AND ((CASE WHEN SUBSTRING(B1_USERLGA, 03, 01) != ' ' THEN "
        cQueryTab += " CONVERT(VARCHAR, DATEADD(DAY, ((ASCII(SUBSTRING(B1_USERLGA, 12, 1)) - 50) * 100 + (ASCII(SUBSTRING(B1_USERLGA, 16, 1)) - 50)), '19960101' ), 122) " + CRLF
        cQueryTab += " END) >= '" + StrTran(::updated_at, ' - ', ' ') + "' ) " + CRLF
    EndIf

    cQueryTab += " ORDER BY " + CRLF
    cQueryTab += " TABREC " + CRLF

    TCQuery cQueryTab New Alias 'QRY_TAB'

    // * Se não encontrar registros
    If QRY_TAB->( EoF() )
        Self:SetStatus(500)
        jResponse[ 'errorId' ]      := 'ALL003'
        jResponse[ 'error' ]        := 'Registro(s) não encontrado(s)'
        jResponse[ 'solution' ]     := 'A consulta de registros não retornou nenhuma informação'
    Else
        jResponse[ 'objects' ]      := {}

        // * Conta o total de registros
        Count To nTotal
        QRY_TAB->( DbGoTop() )

        // * O tamanho do retorno, será o limit, se ele estiver definido 
        If ! Empty(::limit)
            nTamanho := ::limit
        EndIf

        // * Pegando total de páginas
        nPags := NoRound(nTotal / nTamanho, 0)
        nPags := Iif(nTotal % nTamanho != 0, 1, 0)

        // * Se vier página
        If ! Empty(::page)
            nPagina := ::page
        EndIf

        // * Se a página vier zerada ou negativa ou for maior que o máximo, será 1
        If nPagina <= 0 .OR. nPagina > nPags
            nPagina := 1
        EndIf

        // * Se a página for diferente de 1, pula os registros
        If nPagina != 1
            QRY_TAB->( DbSkip( (nPagina-1) * nTamanho ) )
        EndIf

        // * Adiciona os dados para a meta
        jJsonMeta                   := jsonObject():New()
        jJsonMeta[ 'total' ]        := nTotal
        jJsonMeta[ 'current_page' ] := nPagina
        jJsonMeta[ 'total_page' ]   := nPags
        jJsonMeta[ 'total_items' ]  := nTamanho
        jResponse[ 'meta' ]         := jJsonMeta

        // * Percorre os registros
        While ! QRY_TAB->( EoF() )
            nAtual++

            // * Se ultrapassar o limite, encerra o looping
            If nAtual > nTamanho
                Exit
            EndIf

            // * Posiciona o registro e adiciona o retorno
            DbSelectArea(cAliasWs)
            ( cAliasWs )->( DbGoTo( QRY_TAB->TABREC ) )

            oRegistro                   := jsonObject():New()
            oRegistro[ 'cod' ]          := ( cAliasWs )->B1_COD
            oRegistro[ 'desc' ]         := ( cAliasWs )->B1_DESC
            oRegistro[ 'tipo' ]         := ( cAliasWs )->B1_TIPO
            oRegistro[ 'um' ]           := ( cAliasWs )->B1_UM
            oRegistro[ 'locpad' ]       := ( cAliasWs )->B1_LOCPAD
            oRegistro[ 'grupo' ]        := ( cAliasWs )->B1_GRUPO

            aadd(jResponse[ 'objects' ], oRegistro)

            QRY_TAB->( DbSkip() )
        EndDo
    EndIf

    QRY_TAB->( DbCloseArea() )

    // * Define o retorno
    Self:SetContentType( 'application/json' )
    Self:SetResponse(jResponse:toJSON())
    
Return lRet

WSMETHOD POST NEW WSRECEIVE WSSERVICE zWSProdutos
    Local lRet             := .T.
    Local aDados           := {}
    Local jJson            := Nil
    Local cJson            := Self:GetContent()
    Local cError           := ''
    Local nLinha           := 0
    Local cDirLog          := '\x_logs\'
    Local cArqLog          := ''
    Local cErrorLog        := ''
    Local aLogAuto         := {}
    Local nCampo           := 0
    Local jResponse        := jsonObject():New()
    Local cAliasWS         := 'SB1'
    Private lMsErroAuto    := .F.
    Private lMsHelpAuto    := .T.
    Private lAutoErrNoFile := .T.

    // * Se não existir a pasta de logs, cria
    If ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIf

    // * Definindo o conteúdo como JSON e pegando o content e dando um parse para ver se a estrutura está ok
    Self:SetContentType( 'application/json' )
    jJson  := jsonObject():New()
    cError := jJson:fromJSON(cJson)

    // * Se tiver alguem erro no Parse, encerra a execução
    If ! Empty(cError)
        Self:SetStatus(500)
        jResponse[ 'erroId' ]   := 'NEW004'
        jResponse[ 'error' ]    := 'Parse do JSON'
        jResponse[ 'solution' ] := 'Erro ao fazer o Parse do JSON'

    Else
        DbSelectArea( cAliasWS )

        // * Adiciona os dados do ExecAuto
        aadd(aDados, {'B1_COD'   , jJson:GetJsonObject( 'cod' )   , Nil})
        aadd(aDados, {'B1_DESC'  , jJson:GetJsonObject( 'desc' )  , Nil})
        aadd(aDados, {'B1_TIPO'  , jJson:GetJsonObject( 'tipo' )  , Nil})
        aadd(aDados, {'B1_UM'    , jJson:GetJsonObject( 'um' )    , Nil})
        aadd(aDados, {'B1_LOCPAD', jJson:GetJsonObject( 'locpad' ), Nil})
        aadd(aDados, {'B1_GRUPO' , jJson:GetJsonObject( 'grupo' ) , Nil})

        // * Percorre os dados do ExecAuto
        For nCampo := 1 To Len(aDados)
            // * Se o campo for data, retira os hífens e faz a conversão
            If GetSX3Cache(aDados[nCampo, 1], 'X3_TIPO') == 'D'
                aDados[nCampo, 2] := StrTran( aDados[nCampo, 2], '-' , '' )
                aDados[nCampo, 2] := sToD( aDados[nCampo, 2] )
            EndIf
        Next nCampo

        // * Chama a inclusão automática
        MSExecAuto( {|x, y| MATA010(x, y) }, aDados, 3)

        // * Se houve erro, gera um arquivo de log dentro do diretorio do protheus_data

        If lMsErroAuto
            // * Monta o texto do error log que será salvo
            cErrorLog := ''
            aLogAuto := GetAutoGrLog()

            For nLinha := 1 to Len( aLogAuto )
                cErrorLog += aLogAuto[nLinha] + CRLF
            Next nLinha

            // * Grava o arquivo de log
            cArqLog := 'zWSProdutos_New_' + dToS( Date() ) + '_' + StrTran( Time(), ':', '-' ) + '.log'
            MemoWrite(cDirLog + cArqLog, cErrorLog)

            // * Define o retorno para o WebService
            Self:SetStatus(500)
                jResponse[ 'errorId' ]  := 'NEW005'
                jResponse[ 'error' ]    := 'Erro na inclusão do registro'
                jResponse[ 'solution' ] := 'Não foi possível incluir registro! foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '
                lRet                    := .F.

        // * Senão, define o retorno
        Else
            jResponse[ 'note' ] := 'Registro incluído com sucesso!'
        EndIf

    EndIf

    // * Define o retorno
    Self:SetResponse(jResponse:toJSON())
Return lRet
