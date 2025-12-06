#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EX004()
    Local nVenda := 10000
    Local nComiss := 0

    If nVenda <= 5000
        nComiss += nVenda * 0.02
    ElseIf nVenda <= 15000
        nComiss += nVenda * 0.05
    Else
        nComiss += ( nVenda * 0.08 ) + 500
    EndIf

    Alert("Você vendeu R$" + Str(nVenda) + " sua comissão será de R$" + Str(nComiss))

Return
