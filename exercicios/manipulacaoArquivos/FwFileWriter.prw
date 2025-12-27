#Include 'protheus.ch'
#Include 'totvs.ch'

User Function MANI001()
    Local cPath     := "C:\Projetos\local\workspace-testes-estudos\arquivos\"
    Local cNome     := ""
    Local cTipo     := ""
    Local cArquivo  := ""
    Local aProdutos := {}
    Local nX        := 0
    Local oFWriter  := Nil

    cNome := FWInputBox("Digite o nome do arquivo: ")
    cTipo := "." + FWInputBox("Digite o tipo do arquivo (ex: txt, csv): ")

    If Lower(cTipo) != ".csv" .AND. Lower(cTipo) != ".txt"
        MsgStop("Tipo de arquivo inválido.")
        Return .F.
    EndIf

    cArquivo := cNome + cTipo

    RpcSetEnv("99", "01")

    BeginSQL Alias "SB1"
        SELECT B1_COD, B1_DESC
        FROM %Table:SB1%
        WHERE %NotDel%
    EndSQL

    While ! SB1->( EoF() )
        aAdd(aProdutos, {AllTrim(SB1->B1_COD), AllTrim(SB1->B1_DESC)})

        SB1->( DbSkip() )
    EndDo

    If File(cArquivo)
        FErase(cArquivo)
    EndIf

    oFWriter := FWFileWriter():New(cPath + cArquivo, .T.)

    If ! oFWriter:Create()
        MsgStop("Houve um erro ao criar o arquivo - " + oFWriter:Error():GetMessage())
        RpcClearEnv()
        Return .F.
    EndIf

    For nX := 1 To Len( aProdutos )
        oFwriter:Write("Código: " + aProdutos[nX, 1] + " | Nome: " + aProdutos[nX, 2] + CRLF)
    Next

    oFWriter:Write("Total de itens exportados: " + cValToChar( Len( aProdutos ) ))
    oFWriter:Close()

    SB1->( DbCloseArea())

    RpcClearEnv()

    FWAlertSuccess("O arquivo <b>" + cArquivo + "</b> foi criado com sucesso!", "Sucesso")
Return
