#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK018()
    Local cCodProd := ""

    RpcSetEnv("99", "01")

    DbSelectArea("SB1")
    DbSetOrder(1)

    cCodProd := "PROD-NET-001"

    If ! DbSeek( xFilial("SB1") + PadR(cCodProd, TamSX3("B1_COD")[1]) )
        RecLock("SB1", .T.)
            SB1->B1_FILIAL := xFilial("SB1")
            SB1->B1_COD := "PROD-NET-001"
            SB1->B1_DESC := "Switch Gigabit 24 Ports Manageable"
        SB1->( MsUnlock() )

        FWAlertInfo("Produto incluido com sucesso.")
    Else 
        RecLock("SB1", .F.)
            SB1->B1_DESC := "Switch Gigabit 24 Ports Manageable"
        SB1->( MsUnlock() )

        FWAlertInfo("Descrição do produto alterada com sucesso")
    EndiF

    SB1->( DbCloseArea() )

    RpcClearEnv()
Return
