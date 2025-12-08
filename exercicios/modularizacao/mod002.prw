#Include 'totvs.ch'
#Include 'protheus.ch'

User Function MOD002()
    Local aFuncs := {}
    Local nLiquido := 0
    Local nX := 0

    aAdd(aFuncs, {"João Silva", 2000.00, .T.})
    aAdd(aFuncs, {"Maria Souza", 3000.00, .F.})
    aAdd(aFuncs, {"Pedro Dias", 1500.00, .T.})

    For nX := 1 To Len( aFuncs )

        nLiquido := CalcLiquido( aFuncs[nX, 2], aFuncs[nX, 3] )

        FWAlertInfo("Funcionário: " + aFuncs[nX, 1] + CRLF + "Líquido: R$" + cValToChar( nLiquido ))
        
    Next nX
Return

Static Function CalcLiquido( nSal, lUsaVT )
    Local nResultado := 0

    If lUsaVT
        nResultado := nSal - ( ( nSal * 0.10 ) + ( nSal * 0.06 ) )  
    Else 
        nResultado := nSal - ( nSal * 0.10)
    EndIf

Return nResultado
