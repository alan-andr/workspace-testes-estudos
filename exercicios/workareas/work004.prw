#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK004()
    Local cAlias := "SB1"
    Local cCodProd := "00003"

    RpcSetEnv("99", "01")

    DbSelectArea( cAlias )
    DbSetOrder(1)

    If DbSeek( xFilial( cAlias ) + cCodProd )

        RecLock( cAlias, .F. )
            (cAlias)->(B1_DESC) := "ÁGUA MINERAL COM GAS"
        MsUnlock()

        ConOut("Descrição alterada com sucesso!")

    Else 

        FWAlertError("Item não encontrado")

    EndIf

    DbCloseArea()

    RpcClearEnv()
Return
