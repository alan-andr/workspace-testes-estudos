#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK014()
    Local nArm01 := 0
    Local nArm02 := 0

    RpcSetEnv("99", "01")

    DbSelectArea("SB2")
    DbSetOrder(1)

    Begin Transaction

    If SB2->( DbSeek( xFilial("SB2") + PadR("TV001", TamSX3("B2_COD")[1]) + "01" ) )

        RecLock("SB2", .F.)
            SB2->B2_QATU := B2_QATU - 10
        SB2->( MsUnlock() )

        nArm01 := SB2->B2_QATU

    Else 

        FWAlertError("Produto não cadastrado no Armazém 01. Desfazendo retirada...")
        DisarmTransaction()
        Break

    EndIf

    If SB2->( DbSeek( xFilial("SB2") + PadR("TV001", TamSX3("B2_COD")[1]) + "02" ))

        RecLock("SB2", .F.)
            SB2->B2_QATU := B2_QATU + 10
        SB2->( MsUnlock() )

        nArm02 := SB2->B2_QATU

    Else

        FWAlertError("Produto não cadastrado no Armazém 02. Desfazendo retirada...")
        DisarmTransaction()
        Break

    EndIf

    End Transaction

    FWAlertInfo("Saldo armazem 01: " + cValToChar(nArm01) + CRLF + "Saldo armazem 02: " + cValToChar(nArm02) )

    SB2->( DbCloseArea() )

    RpcClearEnv()
Return
