#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSBASIC02()
    Local aArea        := FWGetArea()
    Local oRestClient  := FWRest():New("https://httpbin.org")
    Local aHeader      := {}
    Local cUser        := "user"
    Local cSenh        := "passwd"
    Local cPath        := "/basic-auth/" + cUser + "/" + cSenh
    Local cToken       := Encode64(cUser + ":" + cSenh)
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""

    aAdd(aHeader, "User-Agent: Mozilla/4.0 (Compatible; Protheus " + GetBuild() + ")")
    aAdd(aHeader, "Content-Type: application/json; charset=utf-8")
    aAdd(aHeader, "Accept: application/json")
    aAdd(aHeader, "Authorization: Basic " + cToken)

    oRestClient:SetPath(cPath)

    If oRestClient:Get(aHeader)

        cResult := oRestClient:GetResult()

        FWAlertInfo(cResult, "Resultado")

    Else

        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()

        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cValToChar(cErrorDetail))

    EndIf

    FWRestArea(aArea)
Return
