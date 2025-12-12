#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK013()
    Local lErro := .T.

    RpcSetEnv("99", "01")

    DbSelectArea("SC5")
    DbSetOrder(1)

    Begin Transaction

        ConOut("--- Inicio da transacao ---")

        If ! SC5->( DbSeek( xFilial("SC5") + "TR001" ) )

            RecLock( "SC5", .T. )
                SC5->C5_FILIAL := xFilial("SC5")
                SC5->C5_NUM := "TR001"
                SC5->C5_TIPO := "N"
                SC5->C5_CLIENTE := "C001  "
                SC5->C5_LOJACLI := "01"
            SC5->( MsUnlock() )

            ConOut("1. Pedido TR001 incluido (ainda rascunho).")

        EndIf

        If lErro

            ConOut("2. OPA! Ocorreu um erro simulado!")

            DisarmTransaction()
            Break

        EndIf

        ConOut("Sucesso! Gravou tudo.")

    End Transaction

    DbSelectArea("SC5")
    DbSetOrder(1)

    If SC5->( DbSeek( xFilial("SC5") + "TR001" ) )
        FWAlertError("FALHA! O pedido TR001 existe. O  Rollback nao funcionou")
    Else
        FWAlertSuccess("SUCESSO! O pedido TR001 sumiu. O Rollback funcionou.")
    EndIf

    SC5->( DbCloseArea() )

    RpcSetEnv()

Return
