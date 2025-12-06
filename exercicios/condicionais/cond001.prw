#Include 'totvs.ch'
#Include 'protheus.ch'

User Function COND001()
    Local cFuncion := "Roberto Almeida"
    Local nSal := 4500.00
    Local nTempoCasa := 6
    Local nBonus := 0
    Local nTotal := 0

    If nTempoCasa > 5
        nBonus := nSal * 0.10
    Else
        nBonus := nSal * 0.05
    EndIf

    nTotal := nSal + nBonus

    FWAlertInfo("Funcionário: " + cFuncion + CRLF + "Tempo de Casa: " + cValToChar(nTempoCasa) + " anos" + CRLF + "Bônus a receber: R$ " + cValToChar(nBonus) + CRLF + "Salário Final: R$ " + cValToChar(nTotal), "Cálculo de Bônus")
Return
