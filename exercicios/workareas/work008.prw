#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK008()
    Local cAliasSC5 := "SC5"
    Local cAliasSE4 := "SE4"

    Local cNumPedido := ""
    Local cDescPgto := ""
    Local cCodPgto := ""

    RpcSetEnv("99", "01")

    DbSelectArea( cAliasSE4 )
    DbSetOrder(1)

    DbSelectArea( cAliasSC5 )
    DbSetOrder(1)
    DbGoTop()

    While !( cAliasSC5 )->( EoF() ) 

        cNumPedido := ( cAliasSC5 )->( C5_NUM )
        cCodPgto := ( cAliasSC5 )->( C5_CONDPAG )

        DbSelectArea( cAliasSE4 )

        If ( cAliasSE4 )->( DbSeek( xFilial( cAliasSE4 ) + cCodPgto ) )

            cDescPgto := ( cAliasSE4 )->( E4_DESCRI )

        Else 

            cDescPgto := "CONDICAO INVALIDA"

        EndIf

        FWAlertInfo("Pedido: " + cNumPedido + " | Pagto: " + cCodPgto + " - " + cDescPgto)

        ( cAliasSC5 )->( DbSkip() )
    EndDo

    ( cAliasSC5 )->( DbCloseArea() )
    ( cAliasSE4 )->( DbCloseArea() )

    RpcClearEnv()
Return
