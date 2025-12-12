#Include 'protheus.ch'
#Include 'totvs.ch'

User Function WORK012()
    RpcSetEnv("99", "01")

    DbSelectArea("SBM")
    DbSetOrder(1)

    If SBM->( DbSeek( xFilial("SBM")+"99" ) )

        RecLock("SBM", .F.)
            SBM->( DbDelete() )
        MsUnlock()

        FWAlertSuccess("Grupo 99 excluído com sucesso!")

    Else

        Alert("O grupo 99 já foi excluído ou não existe.")

    EndIf

    DbCloseArea()

    RpcClearEnv()
Return
