#Include 'protheus.ch'
#Include 'totvs.ch'

User Function WORK009()
    Local cAliasSC6 := "SC6"
    Local cAliasSB1 := "SB1"
    Local cAliasSBM := "SBM"

    Local cCprodSC6 := ""
    Local cGrupSB1 := ""
    Local cDescSBM := ""

    RpcSetEnv("99", "01")

    DbSelectArea( cAliasSBM )
    DbSetOrder(1)

    DbSelectArea( cAliasSB1 )
    DbSetOrder(1)

    DbSelectArea( cAliasSC6 )
    DbSetOrder(1)
    DbGoTop()

    While !( cAliasSC6 )->( EoF() )

        cGrupSB1 := ""
        cDescSBM := "SEM GRUPO"

        cCprodSC6 := ( cAliasSC6 )->( C6_PRODUTO )

        DbSelectArea( cAliasSB1 )

        If ( cAliasSB1 )->( DbSeek( xFilial( cAliasSB1 ) + cCprodSC6 ) )

            cGrupSB1 := ( cAliasSB1 )->( B1_GRUPO )

            DbSelectArea( cAliasSBM )

                If ( cAliasSBM )->( DbSeek( xFilial( cAliasSBM ) + cGrupSB1 ) )

                    cDescSBM := ( cAliasSBM )->( BM_DESC )

                EndIf

        EndIf

        FWAlertInfo("Produto: " + cCprodSC6 + " | Grupo: " + cGrupSB1 + " - " + cDescSBM)

        ( cAliasSC6 )->( DbSkip() )
    EndDo

    ( cAliasSBM )->( DbCloseArea() )
    ( cAliasSB1 )->( DbCloseArea() )
    ( cAliasSC6 )->( DbCloseArea() )

    RpcClearEnv()
Return
