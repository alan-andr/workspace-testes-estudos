#Include 'protheus.ch'
#Include 'totvs.ch'

User Function WORK006()
    Local cAliasSC7 := "SC7"
    Local cAliasSB1 := "SB1"
    Local cNpedido := ""
    Local cCodProd := ""
    Local cDescric := "" 

    RpcSetEnv("99", "01")

    DbSelectArea( cAliasSB1 )
    DbSetOrder(1)

    DbSelectArea( cAliasSC7 )
    DbSetOrder(1)
    DbGoTop()

    While !(cAliasSC7)->(EoF())

        cNpedido := ( cAliasSC7 )->( C7_NUM )
        cCodProd := ( cAliasSC7 )->( C7_PRODUTO )

        DbSelectArea( cAliasSB1 )

        If DbSeek( xFilial( cAliasSB1 ) + cCodProd )
            cDescric := ( cAliasSB1 )->( B1_DESC )
        Else
            cDescric := "PRODUTO NAO ENCONTRADO"
        EndIf

        DbSelectArea( cAliasSC7 )

        ConOut("Pedido: " + cNpedido + " | Prod: " + cCodProd + " | " + cDescric)

        ( cAliasSC7 )->( DbSkip() )

    EndDo

    DbCloseArea()

    RpcClearEnv()
Return
