#Include 'protheus.ch'
#Include 'totvs.ch'

User Function COND005()
    Local nEstItem := 50
    Local nQtdPed := 65
    Local cNomeProd := "Fone de Ouvido Sem Fio"

    If nEstItem >= nQtdPed
        FWAlertInfo("Ainda há estoque suficiente do produto: " + cNomeProd + " | Quantidade: " + cValToChar(nEstItem))
    Else
        FWAlertError("Falta: " + cValToChar(nQtdPed - nEstItem) + " itens para o estoque completar o pedido.")
    EndIf
Return
