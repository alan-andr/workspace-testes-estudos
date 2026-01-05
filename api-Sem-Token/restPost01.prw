#Include 'totvs.ch'
#Include 'protheus.ch'

User Function MTDPOST()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestClient  := FWRest():New("https://jsonplaceholder.typicode.com")
    Local cPath        := "/posts"
    Local oJson        := Nil
    Local cJsonPost    := ""
    Local nHTTPstat    := 0
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oJson := jsonObject():New()
    oJson['userId'] := 25
    oJson['id'] := 120
    oJson['title'] := 'Teste de requisicao com metodo Post'
    oJson['body'] := 'consumindo api utilizando metodo de requisicao post para praticar conhecimento e aprender mais sobre o metodo post'

    cJsonPost := oJson:ToJson(oJson)

    oRestClient:SetPath(cPath)
    oRestClient:SetPostParams(cJsonPost)

    If oRestClient:Post(aHeader)

        nHTTPstat := oRestClient:GetHTTPCode()
        cResult := oRestClient:GetResult()

        If nHTTPstat == 201
            FWAlertSuccess("Resultado: " + cResult, "Sucesso")
        Else
            FWAlertInfo("Recebeu status inesperado: " + cValToChar(nHTTPstat))
        EndIf

    Else

        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cErrorDetail, "Erro")

    EndIf

    FWRestArea(aArea)
Return
