#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY001()
    Local aDados := {}
    Local nPos := 0

    AAdd(aDados, "Têxtil Santa Catarina")
    AAdd(aDados, "Metais do Sul Ltda")
    AAdd(aDados, "Logística Brasil")
    AAdd(aDados, "Importadora Global")

    For nPos := 1 To Len(aDados)
        ConOut("Fornecedor Homologado: " + aDados[nPos])
    Next nPos
Return
