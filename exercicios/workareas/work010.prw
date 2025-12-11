#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK010()
    Local cAliasSBM := "SBM"

    RpcSetEnv("99", "01")

    DbSelectArea( cAliasSBM )
    DbSetOrder(1)

    If .NOT. ( cAliasSBM )->( DbSeek( xFilial( cAliasSBM ) + "99" ) )

        RecLock( cAliasSBM, .T. )
            ( cAliasSBM )->BM_FILIAL := xFilial( cAliasSBM ) 
            ( cAliasSBM )->BM_GRUPO := "99"
            ( cAliasSBM )->BM_DESC := "LINHA GAMER"
        ( cAliasSBM )->(MsUnlock())

        FWAlertInfo("Grupo Criado", "Alerta")

    Else

        FWAlertError("Grupo 99 já existe")

    EndIf

    ( cAliasSBM )->( DbCloseArea() )

    RpcClearEnv()
Return
