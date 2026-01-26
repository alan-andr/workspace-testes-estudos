#Include 'protheus.ch'
#Include 'totvs.ch'

User Function JSONPUT()
    Local aArea := FWGetArea()
    Local aHeader := {}
    Local oRest := FWRest():New('https://jsonplaceholder.typicode.com')
    Local cPath := '/posts/1'
    Local jJson := jsonObject():New()
    Local cJsonBody := ''
    Local cLastError := ''
    Local cErrorDetail := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    jJson['currentLocation'] := 'Miami, FL'
    jJson['status'] := 'In transit'
    jJson['estimatedDelivery'] := Date()

    cJsonBody := jJson:toJson()

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Put(aHeader)
        FWAlertInfo('O PUT foi efetuado com sucesso.' + CRLF + cJsonBody, '')
    Else
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail, '')
    EndIf

    FWRestArea(aArea)
Return
