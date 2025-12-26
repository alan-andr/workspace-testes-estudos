#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY018()
    Local aTempos := {15, 12, 18, 9, 22, 11}
    Local nMenor := aTempos[1]
    Local bFiltra := {|x| Iif( x < nMenor, nMenor := x, Nil)}

    aSort(aTempos)

    aEval(aTempos, bFiltra)

    MsgInfo("O menor tempo é: " + cValToChar(nMenor))
Return
