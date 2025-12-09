#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK001()
    Local cAlias := "SA1"

    RpcSetEnv("99", "01")

    DbSelectArea( cAlias )
    DbSetOrder(1)
    DbGoTop()

    While !EoF()

        ConOut("Cliente: " + cValToChar( (cAlias)->(A1_COD) ) + " - Nome: " + (cAlias)->(A1_NOME) )

        DbSkip()
    EndDo

    DbCloseArea()

    RpcClearEnv()
Return
