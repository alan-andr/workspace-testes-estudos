#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY011()
    Local cNumPed := "P00001"
    Local cNomCli := "Indústria ABC Ltda"
    Local dDtEmiss := Date()
    Local aItens := {}
    Local nTotPed := 0
    Local nTotLin := 0
    Local nX := 0

    // 1 - Código, 2 - Descrição, 3 - Quantidade, 4 - Preço Unitário
    aAdd( aItens, {"A001", "Parafuso Sextavado", 100, 0.50} )
    aAdd( aItens, {"B002", "Porca Travante", 100, 0.20} )
    aAdd( aItens, {"C003", "Arruela Lisa", 200, 0.10} )

    For nX := 1 To Len( aItens )
        nTotPed += ( aItens[nX, 3] * aItens[nX, 4] )
        nTotLin++
    Next nX

    ConOut("Pedido: " + cNumPed + " - Cliente: " + cNomCli + " - Data: " + dToC(dDtEmiss) + CRLF + "Total de Itens: " + cValToChar(nTotLin) + CRLF + "Valor total do pedido: R$" + cValToChar(nTotPed))

Return
