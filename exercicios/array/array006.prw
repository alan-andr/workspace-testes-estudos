#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY006()
    Local aEstoque := {}
    Local nTotalEst := 0
    Local nX := 0

    aAdd(aEstoque, {"Teclado Mecânico", 10, 250.00})
    aAdd(aEstoque, {"Mouse Gamer", 30, 120.50})
    aAdd(aEstoque, {"Monitor 24pol", 5, 899.90})
    aAdd(aEstoque, {"Headset USB", 15, 180.00})

    For nX := 1 To Len(aEstoque)
        nTotalEst += ( aEstoque[nX, 2] * aEstoque[nX, 3] )
    Next nX

    Alert("O valor total do estoque é: R$ " + cValToChar(nTotalEst))
Return
