#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY012()
    Local aProducts := {}
    Local nX := 0

    aAdd(aProducts, {"Gaming Keyboard Mechanical", 150.00})
    aAdd(aProducts, {"Monitor 27 inch 4K", 1200.00})
    aAdd(aProducts, {"Mouse Wireless Ergonomic", 85.50})
    aAdd(aProducts, {"Graphics Card RTX 4060", 2500.00})
    aAdd(aProducts, {"USB-C Hub Multiport", 45.00})

    For nX := 1 To Len( aProducts )
        
        If  aProducts[nX, 2] < 500.00

            aProducts[nX, 2] += ( aProducts[nX, 2] * 0.10 )

        EndIf

        ConOut("Produto: " + aProducts[nX, 1] + " | Preco: " + cValToChar(aProducts[nX, 2]))

    Next

Return
