#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY002()
    Local aProdutos := {}
    Local nPos := 0
    Local nTotalItem := 0

    AAdd(aProdutos, {"Teclado Mecânico", 10, 250.00})
    AAdd(aProdutos, {"Mouse Gamer", 20, 120.00})
    AAdd(aProdutos, {"Monitor 24pol", 5, 800.00})

    For nPos := 1 To Len(aProdutos)
        nTotalItem := aProdutos[nPos, 2] * aProdutos[nPos, 3]

        ConOut("Produto: " + aProdutos[nPos, 1] + " | Total R$: " + cValToChar(nTotalItem))
    Next nPos

Return 
