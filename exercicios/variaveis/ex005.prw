#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EX005()
    Local aProdutos := {{"Cadeira Gamer azul promoção", 1200}, {"Mesa de escritório", 850.50}, {"Teclado Mecânico PROMOÇÃO rgb", 350.00}}
    Local nX := 0

    For nX := 1 To Len(aProdutos)
        aProdutos[nX, 1] := Upper(aProdutos[nX, 1]) // Transforma todas as palavras em maiúsculas

        aProdutos[nX, 1] := StrTran(aProdutos[nX, 1], "PROMOÇÃO", "") // Remove a palavra se encontrar e substitui por vazio ""
        
        aProdutos[nX, 1] := AllTrim(aProdutos[nX, 1]) // Remove todos os espaços


        ConOut("Produto: " + aProdutos[nX, 1] + " | Valor: R$ " + Str(aProdutos[nX, 2]))
    Next nX

Return
