#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY003()
    Local aTitulos := {}
    Local nPos := 0
    Local nTotalAberto := 0

    AAdd(aTitulos, {"Companhia de Energia", 450.00, "EM ABERTO"})
    AAdd(aTitulos, {"Internet Provider", 120.00, "PAGO"})
    AAdd(aTitulos, {"Aluguel do Galpão", 2500.00, "EM ABERTO"})
    AAdd(aTitulos, {"Manutenção Predial", 300.00, "PAGO"})

    For nPos := 1 To Len(aTitulos)
        If aTitulos[nPos, 3] == "EM ABERTO"
            nTotalAberto += aTitulos[nPos, 2]
        EndIf
    Next nPos

    fwAlertInfo("Total a pagar (Em aberto): R$" + AllTrim(Str(nTotalAberto)))

Return
