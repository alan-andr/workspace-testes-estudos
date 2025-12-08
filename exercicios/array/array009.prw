#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY009()
    Local aFuncion := {{"João", "Analista", 3500.00}, {"Maria", "Gerente", 8500.00}, {"Pedro", "Estagiário", 1500.00}}
    Local nTotal := 0
    Local nX := 0

    For nX := 1 To Len(aFuncion)
        nTotal += aFuncion[nX, 3]
    Next nX

    ConOut("Total da Folha: R$" + cValToChar(nTotal))

Return
