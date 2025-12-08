#Include 'totvs.ch'
#Include 'protheus.ch'

User Function ARRAY010()
    Local aImport := {}
    Local nPos := 0
    Local cValor := "mouse"

    aAdd(aImport, "Teclado")
    aAdd(aImport, "Mouse")
    aAdd(aImport, "Monitor")

    nPos := aScan( aImport, {|x| AllTrim( Upper( x ) ) == Upper( cValor )} )

    FWAlertInfo("O item " + cValor + " está na posição: " + cValToChar(nPos), "Alerta")
Return
