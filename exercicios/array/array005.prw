#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY005() 
    Local cCliente  := "CLI001"
    Local dHoje     := CToD("06/12/2025")
    Local lBloqueia := .F.
    Local nPos      := 0

    Local aTitulos := {;
        {"CLI001", 500.00,  CToD("10/11/2025"), CToD("")},; // Vencido (10/11 é menor que 06/11)
        {"CLI002", 1200.00, CToD("06/12/2025"), CToD("")},; // Vence hoje
        {"CLI003", 300.00,  CToD("15/09/2025"), CToD("20/09/2025")}; // Pago
    }

    // AScan procurando "Problemas":
    // Cliente igual .E. Pagamento Vazio .E. Vencimento MENOR que (Hoje - 30)
    nPos := AScan( aTitulos, {|x| AllTrim( x[1] ) == cCliente .AND. Empty( x[4] ) .AND. x[3] < ( dHoje - 30 ) } )

    // Se nPos for MAIOR que 0, significa que ACHOU um problema
    If nPos > 0
        lBloqueia := .T.
        Alert("BLOQUEIO: O Cliente possui titulos vencidos há mais de 30 dias!")
    Else
        // Se nPos for 0, não achou nada, então libera.
        lBloqueia := .F.
        FWAlertSuccess("Venda liberada!", "Sucesso") // Cuidado: FWAlertSuccess tem dois 's'
    EndIf

Return
