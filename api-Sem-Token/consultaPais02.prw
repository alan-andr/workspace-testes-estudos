#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSPAIS02()
    Local aArea        := FWGetArea()
    Local oRestClient  := FWRest():New("https://restcountries.com")
    Local aHeader      := {}
    Local cPais        := FWInputBox("Informe um país: ")
    Local cPath        := "/v3.1/name/" + cPais
    Local oJson        := Nil
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local cNome := ''
    Local cSubReg := ''
    Local nPopulac := 0
    Local cIdioma := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestClient:SetPath(cPath)

    If oRestClient:Get(aHeader)

    cResult := oRestClient:GetResult()
    oJson := jsonObject():New()
    oJson:FromJson(cResult)

    cNome := oJson[1, 'name', 'common']
    cSubReg := oJson[1, 'subregion']
    nPopulac := oJson[1, 'population']
    cIdioma := oJson[1, 'languages', 'spa']

    FWAlertSuccess('Pais: ' + cNome + CRLF + 'Subregião: ' + cSubReg + CRLF + 'Idioma: ' + cIdioma + CRLF + 'População: ' + cValToChar(nPopulac), 'Resultado')

    Else 

    cLastError := oRestClient:GetLastError()
    cErrorDetail := oRestClient:GetResult()
    FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cResult, 'Erro')

    EndIf

    FWRestArea(aArea)
Return
