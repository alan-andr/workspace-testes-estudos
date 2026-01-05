#Include 'protheus.ch'
#Include 'totvs.ch'

User Function BEARER01()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestClient  := FWRest():New("https://httpbin.org")
    Local cPath        := "/bearer"
    Local cBearer      := "f-??*v(4JCCt(JttUQ.Z3mcv4:LMsT-t/=K?/6G5Mq11e@fc+kuZB'US9.6'9C0U"
    Local cResult      := ''
    Local cLastError   := ''
    Local cErrorDetail := ''
    Local nHTTPcod     := ''

    aadd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aadd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aadd(aHeader, 'Accept: application/json')
    aadd(aHeader, 'Authorization: Bearer ' + cBearer)

    oRestClient:SetPath(cPath)

    If oRestClient:Get(aHeader)
        cResult            := oRestClient:GetResult()
        nHTTPcod           := oRestClient:GetHTTPCode()

        If Val(nHTTPcod) == 200
            FWAlertSuccess("Resultado: " + cResult,"Acesso autorizado")
        Else
            FWAlertInfo("Resultado inesperado: codigo: " + nHTTPcod, "Alerta")
        EndIf

    Else
        cLastError         := oRestCLient:GetLastError()
        cErrorDetail       := oRestCLient:GetResult()
        nHTTPcod           := oRestClient:GetHTTPCode()

        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cErrorDetail + CRLF + "Codigo: " + nHTTPcod, "Erro")
    EndIf

    FreeObj(oRestClient)
    FWRestArea(aArea)

Return
