#Include 'totvs.ch'
#Include 'protheus.ch'

User Function MOD001()
    Local aFuncs := {}
    Local nINSS := 0
    Local nX := 0
    Local cLog := ""

    aAdd(aFuncs, {"Pedro Silva", 2500.00})
    aAdd(aFuncs, {"Carla Dias", 5000.00})
    aAdd(aFuncs, {"Marcos Souza", 3000.00})
    aAdd(aFuncs, {"Ana Pereira", 10000.00})

    For nX := 1 To Len( aFuncs )

        nINSS := ( CalcINSS( aFuncs[nX, 2] ) )

        cLog += aFuncs[nX, 1] + " - INSS: R$ " + cValToChar( nINSS ) + CRLF

    Next nX

    FWAlertInfo("Relatório de INSS: " + CRLF + CRLF + cLog)
Return

Static Function CalcINSS( nSal )
    Local nValImp := 0

    If nSal <= 3000
        nValImp := ( 0.09 * nSal )
    Else
        nValImp := ( 0.11 * nSal )
    EndIf

Return nValImp
