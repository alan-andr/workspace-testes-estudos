#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY005() 
    Local cCliente := "CLI003"
    Local dHoje := cToD("06/12/2025")
    Local lBloqueia := .F.
    Local nPos := 0

    Local aTitulos := {;
    {"CLI001", 500.00, cToD("10/11/2025"), cToD("")},;
    {"CLI002", 1200.00, cToD("01/10/2025"), cToD("")},;
    {"CLI003", 300.00, cToD("15/09/2025"), cToD("20/09/2025")};
    }

    nPos := aScan( aTitulos, {|x| AllTrim(x[1]) == cCliente .AND. Empty(x[4]) .AND. x[3] == dHoje - 30} )

    If nPos > 0
        lBloqueia := .T.

        Alert("Bloqueio")
    EndIf

    fwAlertSucess("Venda liberada!")

Return
