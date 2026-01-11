#Include 'protheus.ch'
#Include 'totvs.ch'

User Function APIPRODS()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest():New('https://dummyjson.com' )
    Local cPath        := '/products'
    Local jJson        := jsonObject():New()
    Local nHTTPCode    := 0
    Local cResult      := ''
    Local cErrorDetail := ''
    Local cLastError   := ''

    Local nX           := 0
    Local cCodProd     := ''
    Local cDescProd    := ''
    Local cTipo        := 'GN'
    Local cArmazem     := '01'
    Local nInserted    := 0
    Local nUpdated     := 0
    Local lEncontrou   := Nil

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRest:SetPath(cPath)

    If oRest:Get(aHeader)
        nHTTPCode := Val(oRest:GetHTTPCode())
        cResult := oRest:GetResult()
        jJson:fromJson(cResult)

        RpcSetEnv('99', '01')
        DbSelectArea('SB1')
        DbSetOrder(1)

        For nX := 1 To Len(jJson['products'])

            cCodProd  := '000000' + cValToChar(jJson[ 'products' , nX, 'id' ])
            cDescProd := jJson[ 'products' , nX, 'title' ]

            If ! DbSeek( xFilial( 'SB1' ) + cCodProd )
                RecLock( 'SB1' , .T.)
                    SB1->B1_FILIAL := xFilial( 'SB1' )
                    SB1->B1_COD    := cCodProd
                    SB1->B1_DESC   := cDescProd
                    SB1->B1_TIPO   := cTipo
                    SB1->B1_LOCPAD := cArmazem
                SB1->( MsUnlock() )

                nInserted++
                lEncontrou := .T.
            Else
                RecLock( 'SB1' , .F.)
                    SB1->B1_DESC   := cDescProd
                SB1->( MsUnlock() )

                nUpdated++
                lEncontrou := .F.
            EndIf

        Next nX

        SB1->( DbCloseArea() )
        RpcClearEnv()

        If ! lEncontrou 
            FWAlertInfo('Descrição de produto(s) alterada(s).' + CRLF + 'Quantidade: ' + cValToChar(nUpdated) + ' registros', 'Registro(s) alterado(s)')
        Else
            FWAlertSuccess('Cadastro de produto(s) efetivado(s) com sucesso!' + CRLF + 'Quantidade: ' + cValToChar(nInserted) + ' registros','Registro(s) incluído(s)')
        EndIf

    Else
        nHTTPCode := Val(oRest:GetHTTPCode())
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()

        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail + ' - Codigo: ' + cValToChar(nHTTPCode), 'Erro')
    EndIf

    FWRestArea(aArea)
Return
