#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK016()
    Local cAliasSC5 := "SC5"
    Local cAliasSC6 := "SC6"

    Local cFilialSC5 := ""
    Local cNumPed := ""

    RpcSetEnv("99", "01")

    DbSelectArea(cAliasSC6)
    DbSetOrder(1)

    DbSelectArea(cAliasSC5)
    DbSetOrder(1)
    DbGoTop()

    If (cAliasSC5)->( EoF() )

        Alert("A tabela SC5 não possui registros de pedidos de venda!")

    Else

        While ! (cAliasSC5)->( EoF() )

            cFilialSC5 := xFilial("SC5")
            cNumPed := SC5->C5_NUM

            DbSelectArea(cAliasSC6)

            If (cAliasSC6)->( DbSeek( xFilial("SC6") + cNumPed ) )

                While ! (cAliasSC6)->( EoF() ) .AND. cNumPed == SC6->C6_NUM

                    ConOut("Item: " + SC6->C6_ITEM + " | Produto: " + SC6->C6_PRODUTO + " | Quantidade: " + cValToChar(SC6->C6_QTDVEN))

                    (cAliasSC6)->( DbSkip() )

                EndDo

            Else

                Alert("Nenhum item foi encontrado com esse numero de pedido.")

            EndIf

            DbSelectArea(cAliasSC5)
            (cAliasSC5)->( DbSkip() )

        EndDo

    EndIf

    (cAliasSC5)->( DbCloseArea() )
    (cAliasSC6)->( DbCloseArea() )

    RpcClearEnv()
Return
