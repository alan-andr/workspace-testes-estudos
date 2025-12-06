#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY003()
    Local aLiNegra := {"LOJA DO NORTE", "COMERCIO EIRELI", "CLIENTE BLOQUEADO LTDA", "SUPERMERCADO ABC"}
    Local cCliente := "CLIENTE BLOQUEADO LTDA"
    Local lBloq := .F.
    Local nX := 0

    For nX := 1 To Len(aLiNegra)

        If aLiNegra[nX] == cCliente
            lBloq := .T.
            Exit
        EndIf
        
    Next nX

    If lBloq
        Alert("Pedido liberado!")
    Else 
        Alert("Pedido bloqueado.")
    EndIf
