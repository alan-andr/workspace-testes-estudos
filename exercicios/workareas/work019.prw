#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK019()
    Local aArea := FWGetArea()
    Local cCod := "00002"
    
    RpcSetEnv("99", "01")

    DbSelectArea("SB1")
    DbSetOrder(1)

    If ( DbSeek( xFilial("SB1") + PadR(cCod, TamSX3("B1_COD")[1]) ))

        RecLock("SB1", .F.)
            SB1->B1_DESC := "AGUA MINERAL PREMIUM"
            SB1->B1_PRV1 := 8.50
        SB1->( MsUnlock() )

        FWAlertSuccess("Registro alterado com sucesso")

    Else

        MsgAlert("Nenhum registro foi encontrado com esse código.")

        Return .F.

    EndIf

    SB1->(  DbCloseArea() )

    RpcClearEnv()

    FWRestArea(aArea)
Return
