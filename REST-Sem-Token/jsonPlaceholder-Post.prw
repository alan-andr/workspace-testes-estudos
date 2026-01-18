#Include 'protheus.ch'
#Include 'totvs.ch'

User Function JSONPOST() 
    Local aArea := FWGetArea()
    Local aHeader := {}
    Local oRest := FWRest():New('https://jsonplaceholder.typicode.com')
    Local cPath := '/posts'
    Local jJson := jsonObject():New()
    Local cJsonBody := ''
    Local cLastError := ''
    Local cErrorDetail := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    jJson['userId'] := 1
    jJson['id'] := 190
    jJson['title'] := 'Título'
    jJson['body'] := 'Corpo'

    cJsonBody := jJson:toJson()

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Post()
        FWAlertInfo('O <b>POST</b> foi efetuado com sucesso.' + CRLF + cJsonBody, '')
    Else
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail, '')
    EndIf

    FWRestArea(aArea)
Return
