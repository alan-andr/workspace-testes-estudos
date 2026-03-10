#Include "protheus.ch"
#Include "totvs.ch"

// ! https://tdn.totvs.com/display/tec/PutGlbValue
// ! https://tdn.totvs.com/display/tec/GetGlbValue
// ! https://tdn.totvs.com/display/tec/TimeGlbValue

User Function zMulti03()
    Local aArea := FWGetArea()

    // * Cria uma variável pública na memória
    PutGlbValue("cXNomSobr", "Alan Andrade")

    FWRestArea(aArea)
Return

User Function zMulti3G()
    Local aArea := FWGetArea()
    Local cNome := ""

    cNome := GetGlbValue("cXNomSobr")

    FWAlertInfo("O nome é " + cNome, "Teste GetGlbValue")

    FWRestArea(aArea)
Return

User Function zMulti3T()
    Local aArea := FWGetArea()
    Local nSegundos := 0

    nSegundos := TimeGlbValue("cXNomSobr")

    FWAlertInfo("A quantidade de segundos é " + cValToChar(nSegundos), "Teste TimeGlbValue")

    FWRestArea(aArea)
Return
