#Include 'protheus.ch'
#Include 'totvs.ch'

User Function EX003()
    Local cProduto := 'Amortecedor Dianteiro'
    Local nQtdAtual := 45
    Local nQtMin := 50

    If nQtdAtual <= nQtMin
        Alert("Comprar " + cProduto)
    Else
        fwAlertInfo("A quantidade em estoque do " + cProduto + "está acima da quantidade mínima", "Alerta")
    EndIf

Return
