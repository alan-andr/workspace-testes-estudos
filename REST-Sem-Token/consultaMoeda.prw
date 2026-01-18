#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSMOEDA()
    Local aArea        := FWGetArea()
    Local oRestClient  := FWRest():New("https://api.hgbrasil.com")
    Local oJson        := Nil
    Local aHeader      := {}
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local nValor       := 0

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestClient:SetPath('/finance?key=suachave')

    If oRestClient:Get(aHeader)

        cResult := oRestClient:GetResult()
        oJson   := JsonObject():New()
        oJson:fromJson(cResult)

        nValor := oJson['results']['currencies']['USD']['buy']

        If nValor < 0

            Alert('Nenhum valor foi encontrado.')
            Return .F.

        EndIf

        MsgInfo(cResult + CRLF + "Valor: " + cValToChar(nValor), "Resultado")

    Else

        cLastError   := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        MsgAlert("Erro: " + cErrorDetail)

    EndIf

    FWRestArea(aArea)

Return
