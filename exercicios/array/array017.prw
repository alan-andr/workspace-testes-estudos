#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY017()
    Local aItens    := {}
    Local bDesconto :={|x| x[2] := (x[2] * 0.80)}
    Local nX        := 0

    aAdd(aItens, {"Caderno", 20.00})
    aAdd(aItens, {"Caneta", 5.00})
    aAdd(aItens, {"Mochila", 150.00})

    ConOut("Antes: Produtos | Precos ")
    For nX := 1 To Len(aItens)
        ConOut("Produto: " + aItens[nX, 1] + "| Preco: R$" + cValToChar(aItens[nX, 2]))
    Next

    ConOut("============================================================")

    aEval(aItens, bDesconto)

    ConOut("Depois: Produtos | Precos ")
    For nX := 1 To Len(aItens)
        ConOut("Produto: " + aItens[nX, 1] + "| Preco: R$" + cValToChar(aItens[nX, 2]))
    Next
Return
