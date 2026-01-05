#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSPAIS()
    Local aArea       := FWGetArea()
    Local oRestClient := FWRest():New("https://restcountries.com")
    Local cPais       := FWInputBox("Informe o nome do país: ")
    Local cPath       := "/v3.1/name/"
    Local aHeader     := {}
    Local oJson       := Nil
    Local cResult     := ""
    Local cLastError  := ""
    Local cErroDetail := ""
    Local aDadosPais  := {}
    Local cNome       := ""
    Local cCapital    := ""
    Local nPopulac    := 0

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestClient:SetPath(cPath + Lower(cPais))
    If oRestClient:Get(aHeader)

        cResult := oRestClient:GetResult()
        oJson   := jsonObject():New()
        oJson:fromJson(cResult)

        aDadosPais := oJson[1]

        cNome    := aDadosPais[ 'name' ][ 'common' ]
        cCapital := aDadosPais[ 'capital' ][1]
        nPopulac := aDadosPais[ 'population' ]

        MsgInfo("Nome: " + cNome + CRLF + "Capital: " + FWNoAccent(cCapital) + CRLF + "População: " + cValToChar(nPopulac), "Resultado: " + cPais)

    Else

        cLastError  := oRestClient:GetLastError()
        cErroDetail := oRestClient:GetResult()
        Alert("Erro: " + cLastError + " - Detalhes: " + cErroDetail)

    EndIf

    FWRestArea(aArea)
Return
