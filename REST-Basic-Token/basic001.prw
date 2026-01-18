#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSBASIC()
    Local aArea := FWGetArea()
    Local oRestClient := FWRest():New("https://postman-echo.com")
    Local cPath := "/basic-auth"
    Local aHeader := {}
    Local cUser := "postman"
    Local cSenh := "password"
    Local cToken := Encode64(cUser + ":" + cSenh)
    Local cResult := ""
    Local cLastError := ""
    Local cErroDetail := ""

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Basic ' + cToken)

    oRestClient:SetPath(cPath)

    If oRestClient:Get(aHeader)

        cResult := oRestClient:GetResult()

        MsgInfo('Autenticado com sucesso!' + CRLF + 'Resposta: ' + cResult, 'API Postman Echo')

    Else

        cLastError := oRestClient:GetLastError()
        cErroDetail := oRestClient:GetResult()
        Alert('Erro: ' + cLastError + ' - Detalhes: ' + cErroDetail)

    EndIf

    FWRestArea(aArea)
Return
