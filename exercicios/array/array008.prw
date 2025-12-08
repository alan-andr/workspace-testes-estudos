#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY008()
    Local aProd := {"PROD001", "PROD002", "PROD003", "PROD004", "PROD005"}
    Local nX := 0

    For nX := 1 To Len(aProd)
        ConOut(aProd[nX])
    Next nX

Return
