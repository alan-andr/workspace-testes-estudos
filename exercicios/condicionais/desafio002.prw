#Include 'totvs.ch'
#Include 'protheus.ch'

User Function DESAF002()
    Local aFolha := {}
    Local nValTot := 0
    Local nX := 0

    aAdd(aFolha, {"Func 01", 10, "TI",  "A"})
    aAdd(aFolha, {"Func 02", 5, "RH",   "A"})
    aAdd(aFolha, {"Func 03", 20, "TI",  "D"})
    aAdd(aFolha, {"Func 04", 8, "FIN",  "A"})
    aAdd(aFolha, {"Func 05", 10, "TI",  "A"})

    For nX := 1 To Len( aFolha )

        If aFolha[nX, 4] != "D"
        
            If aFolha[nX, 3] == "TI"

                nValTot += ( 50 * aFolha[nX, 2] ) 

            ElseIf aFolha[nX, 3] == "RH"

                nValTot += ( 40 * aFolha[nX, 2] )

            Else

                nValTot += ( 30 * aFolha[nX, 2] )

            EndIf

        EndIf

    Next nX

    FWAlertInfo("Total a pagar de horas extras: R$" + cValToChar(nValTot))
Return
