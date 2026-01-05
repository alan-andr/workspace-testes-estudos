#Include 'protheus.ch'
#Include 'totvs.ch'

User Function MTDPOST02()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestClient  := FWRest()    :New("https://httpbin.org")
    Local cPath        := "/post"
    Local oJson        := jsonObject():New()
    Local cJsonBody    := ""
    Local nPesoTot     := 102
    Local nHTTPcod     := 0
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""

    oJson[ 'produto' ]    := 'Cadeira Gamer Engonomica'
    oJson[ 'quantidade' ] := 5
    oJson[ 'pesototal' ]  := nPesoTot
    oJson[ 'destino' ]    := 'Rua das Flores, 123 - Sao Paulo'
    oJson[ 'prioridade' ] := 'Alta'

    If nPesoTot > 100 
        MsgStop("O limite de peso desta API foi excedido, peso: " + cValToChar(nPesoTot) + "Kg", "Limite de Peso")
        Return .F.
    EndIf

    cJsonBody := oJson:toJson(oJson)

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestClient:SetPath(cPath)
    oRestClient:SetPostParams(cJsonBody)

    If oRestClient:Post(aHeader)
        nHTTPcod := oRestClient:GetHTTPCode()
        cResult  := oRestClient:GetResult()

        If Val(nHTTPcod) == 200
            FWAlertSuccess("Resposta: " + cResult + "Codigo: " + nHTTPcod, "Sucesso")
        Else
            FWAlertInfo("Resposta inesperada, codigo: " + nHTTPcod, "Alerta")
        EndIf

    Else
        cLastError   := oRestClient:GetLastError()
        cErrorDetail := oRestCLient:GetResult()
        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cErrorDetail, "Erro")
    EndIf

    FreeObj(oRestClient)
    FreeObj(oJson)
    FWRestArea(aArea)

Return
