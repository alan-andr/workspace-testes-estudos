#Include 'protheus.ch'
#Include 'totvs.ch'

User Function MOD003()
    Local aArea := FWGetArea()
    Local cNomProd := 'Cadeira de Escritório Ergonômica'
    Local nPrecTot := 2500.00
    Local nTaxImp := 0.12
    Local nValTot := 0

    nValTot := CalcTax(nPrecTot, nTaxImp)

    FWAlertInfo("Produto: " + cNomProd + CRLF + "Valor sem imposto: R$" + cValToChar(nPrecTot) + CRLF + 'Valor com imposto: R$' + cValToChar(nValTot))

    FWRestArea(aArea)
Return

Static Function CalcTax(nVal, nTax)
    Default nVal := 1000
    Default nTax := 0.12
    Local CalcImp := 0

    CalcImp := nVal + (nVal * nTax)

Return CalcImp
