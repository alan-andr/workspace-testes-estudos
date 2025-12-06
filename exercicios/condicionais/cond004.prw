#Include 'totvs.ch'
#Include 'protheus.ch'

User Function COND004()
    Local aPacotes := {}
    Local nTotFrete := 0
    Local nX := 0

    aAdd(aPacotes, {"PC01", 12, "SUL"}) // 50
    aAdd(aPacotes, {"PC02", 5, "SUL"}) // 30
    aAdd(aPacotes, {"PC03", 20, "NORTE"}) // 80
    aAdd(aPacotes, {"PC04", 8, "SUL"}) // 30

    For nX := 1 To Len( aPacotes )

        If aPacotes[nX, 3] == "SUL" .AND. aPacotes[nX, 2] <= 10
            nTotFrete += 30
        ElseIf aPacotes[nX, 3] == "SUL"
            nTotFrete += 50
        Else
            nTotFrete += 80
        EndIf

    Next nX

    FWAlertInfo("O valor total de frete: R$" + cValToChar(nTotFrete), "Frete")
Return
