#Include 'totvs.ch'
#Include 'protheus.ch'

User Function BEARER02()
    Local aArea := FWGetArea()
    Local aHeader := {}
    Local aEspecif := {'Processador i9', '32GB RAM', 'SSD 1TB'}
    Local oRestClient := FWRest():New("https://httpbin.org")
    Local cPath := "/post"
    Local cToken := 'Hd0wDOyYlbFxs1Za84oucVzCQ5V4h9kfhJjEKzum3pCwg93x2qjXiP2Zz0uhHC4S'
    Local oJson := jsonObject():New()
    Local cJsonBody := ''
    Local cResult := ''
    Local cLastError := ''
    Local cErrorDetail := ''
    Local cHTTPCod := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Bearer ' + cToken)

    oJson['id'] := 101
    oJson['item'] := 'Notebook Gamer'
    oJson['setor'] := 'Desenvolvimento'
    oJson['especificacoes'] := aEspecif

    cJsonBody := oJson:ToJson(oJson)

    oRestClient:SetPath(cPath)
    oRestClient:SetPostParams(cJsonBody)

    If oRestClient:Post(aHeader)

        cResult := oRestClient:GetResult()
        cHTTPCod := oRestCLient:GetHTTPCode()

        If Val(cHTTPCod) == 200
            FWAlertSuccess('Resposta: ' + cResult, 'Requisição bem-sucedida')
        Else
            FWAlertInfo('Resposta inesperada, codigo: ' + cHTTPCod, 'Alerta')
        EndIf

    Else

        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestCLient:GetResult()
        cHTTPCod := oRestCLient:GetHTTPCode()

        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail + CRLF + 'Codigo: ' + cHTTPCod, 'Erro')

    EndIf

    FreeObj(oRestClient)
    FreeObj(oJson)
    FWRestArea(aArea)
Return
