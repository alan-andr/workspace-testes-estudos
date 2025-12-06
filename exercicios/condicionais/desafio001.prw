#Include 'totvs.ch'
#Include 'protheus.ch'

User Function DESAF01()
    Local aNotas := {}
    Local nTotICMS := 0
    Local nCalc := 0
    Local nX := 0
    Local cLog := ""

    aAdd(aNotas, {"000101", 1000.00, "SP"})
    aAdd(aNotas, {"000102", 2500.00, "RJ"})
    aAdd(aNotas, {"000103", -50.00, "MG"}) // Nota com erro
    aAdd(aNotas, {"000104", 5000.00, "SP"})
    aAdd(aNotas, {"000105", 1500.00, "PE"})

    For nX := 1 To Len( aNotas )

        If aNotas[nX, 2] > 0

            If aNotas[nX, 3] == "SP"
                nCalc := aNotas[nX, 2] * 0.18
            Else
                nCalc := aNotas[nX, 2] * 0.12
            EndIf

            nTotICMS += nCalc

            cLog += aNotas[nX, 1] + " ICMS: " + cValToChar( nCalc ) + CRLF
 
        EndIf

    Next nX

    FWAlertInfo("Total de ICMS a recolher: R$ " + cValToChar(nTotICMS) + CRLF + CRLF + "Detalhamento:" + CRLF + cLog)
Return
