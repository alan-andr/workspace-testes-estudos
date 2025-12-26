#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY015()
    Local aInventario := {{"Sensor de Presença", 45.50, "Em Estoque"}, {"Roteador Pro", 120.00, "Fora de Estoque"}, {"Microcontrolador", 15.00, "Em Estoque"}, {"Adaptador de Energia", 25.00, "Em Estoque"}}
    Local nPrecoFim := 0
    Local nMaior := 0
    Local bCalcImp := {|x| nPrecoFim := ( x[2] + (x[2] * 0.15) ) ,Iif(nPrecoFim > nMaior, nMaior := nPrecoFim, Nil) ,ConOut("Nome: " + x[1] + " | Preco: R$" + cValToChar(nPrecoFim))}
    Local nPos := 0

    aAdd(aInventario, {"Tela LCD", 30.00, "Em Estoque"})

    aEval(aInventario, bCalcImp)

    ConOut("O valor mais caro encontrado é: R$" + cValToChar(nMaior))

    nPos := aScan(aInventario, {|x| x[1] == "Roteador Pro"})

    If nPos > 0
        aDel(aInventario, nPos)
        aSize(aInventario, Len(aInventario) - 1)
    EndIf

Return
