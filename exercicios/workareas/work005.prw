#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK005()
    Local cAlias := "SB1"
    Local cCodProd := "00005"
    Local cDesc := "KIT DE TESTE AUTOMATIZADO"
    local cTipo := "PA" 
    Local cUniMed := "UN"

    RpcSetEnv("99", "01")

    DbSelectArea( cAlias )
    DbSetOrder(1)

    If !DbSeek( xFilial( cAlias ) + cCodProd )

        RecLock( cAlias, .T. )
            (cAlias)->(B1_FILIAL) := xFilial( cAlias )
            (cAlias)->(B1_COD) := cCodProd
            (cAlias)->(B1_DESC) := cDesc
            (cAlias)->(B1_TIPO) := cTipo
            (cAlias)->(B1_UM) := cUniMed
        MsUnlock()

        ConOut("Registro incluido com sucesso!")

    Else

        FWAlertError("Registro ja existe na SB1")

    EndIf

    DbCloseArea()

    RpcClearEnv()

Return
