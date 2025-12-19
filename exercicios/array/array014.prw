#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY014()
    Local aPrecos := {120.50, 450.00, 89.90, 1200.00}
    Local nLmtDesc := 1500
    Local nTxDesc := 0.1
    Local nTotBrut := 0
    Local nTotLiq := 0
    Local nX := 0

    For nX := 1 To Len( aPrecos )

        nTotBrut += aPrecos[nX]

    Next

    If nTotBrut > nLmtDesc

        nTotLiq := nTotBrut - (nTotBrut * nTxDesc)
    Else 

        nTotLiq := nTotBrut

    EndIf

    FWAlertInfo("Valor bruto: R$" + cValToChar(nTotBrut) + CRLF + "Valor líquido: R$" + cValToChar(nTotLiq))

Return
