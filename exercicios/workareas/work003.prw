#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK003()
    Local cAlias := "SB1"
    //Local cIndex := "B1_FILIAL+B1_COD"
    Local cCodProd := "00003"

    RpcSetEnv("99", "01")

    DbSelectArea( cAlias )
    DbSetOrder(1)

    If DbSeek( xFilial( cAlias ) + cCodProd )
        ConOut("Item encontrado: " + (cAlias)->(B1_DESC))
    Else
        FWAlertError("Item NÃO encontrado.")
    EndIf

    DbCloseArea()

    RpcClearEnv()
Return
