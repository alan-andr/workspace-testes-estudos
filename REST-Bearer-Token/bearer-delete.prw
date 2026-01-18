#Include 'totvs.ch'
#Include 'protheus.ch'

User Function BEARER04()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oJson        := jsonObject():New()
    Local cJsonBody    := ""
    Local oRest        := FWRest()    :New("https://httpbin.org")
    Local cPath        := "/bearer"
    Local cToken       := "teste-token-bearer"
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local nHTTPcod     := 0

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Bearer ' + cToken)

    oJson["user"] := "joao"
    oJson["email"] := "joaodasilva@exemplo.com.br"

    cJsonBody := oJson:toJson(oJson)

    oRest:SetPath(cPath)

    If oRest:Get(aHeader)
        cResult := oRest:GetResult()
        nHTTPcod := Val(oRest:GetHTTPCode())

        If nHTTPcod == 200
            cPath := "/status/200"
            oRest:SetPath(cPath)
            oRest:SetPostParams(cJsonBody)

            If oRest:Delete(aHeader)
                FWAlertSuccess("Registro deletado com sucesso! Itens: " + cValToChar(cJsonBody), "Sucesso")
            EndIf

        EndIf

    Else
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cErrorDetail, "Erro")
    EndIf

    FWRestArea(aArea)

Return
