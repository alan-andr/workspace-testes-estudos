#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK011()

    RpcSetEnv("99", "01")

    DbSelectArea("SBM")
    DbSetOrder(1)

    If SBM->( DbSeek( xFilial("SBM")+"99") )
    
        RecLock( "SBM", .F. )
            SBM->BM_DESC := "LINHA GAMER PRO" 
        MsUnlock()

        FWAlertInfo("Grupo atualizado com sucesso.")

    Else 

        Alert("Grupo 99 não encontrado.")

    EndIf

    DbCloseArea()

    RpcClearEnv()

Return
