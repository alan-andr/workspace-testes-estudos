#Include 'protheus.ch'
#Include 'totvs.ch'

User Function COND006()
    Local cNmFuncio := "Alice Oliveira"
    Local nSalario := 5000.00
    Local nAnosExp := 3
    Local cDepart := "Vendas"
    Local nBonus := 0
    Local nAdicion := 500
    Local nNovoSal := 0

    nNovoSal := nSalario

    If cDepart == "Vendas" .AND. nAnosExp > 2

        nBonus := 0.15

        nNovoSal += ( nSalario * nBonus ) + nAdicion

    ElseIf nAnosExp > 2

        nNovoSal += nAdicion

    EndIf

    FWAlertInfo("Funcionário(a): " + cNmFuncio + CRLF + "Experiência: " + cValToChar(nAnosExp) + " anos " + CRLF + "Departamento: " +cDepart + CRLF + "Salário anterior: R$" + cValToChar(nSalario) + CRLF + "Salário atual: R$" + cValToChar(nNovoSal))
Return
