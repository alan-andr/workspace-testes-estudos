#Include 'protheus.ch'
#Include 'totvs.ch'

User Function JSONDEL() 
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest()    :New('https://jsonplaceholder.typicode.com' )
    Local cPath        := '/posts/1'
    Local cResult      := ''
    Local cLastError   := ''
    Local cErrorDetail := ''
    Local jJson        := jsonObject():New()
    Local cJsonBody    := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    jJson['userId'] := 1
    jJson['id'] := 1
    jJson['title'] := 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit'
    jJson['body'] := 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'

    cJsonBody := jJson:toJson()

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Delete(aHeader)
        cResult := oRest:GetResult()

        FWAlertInfo('O <b>DELETE</b> foi efetivado com sucesso.' + CRLF + cResult, '')
    Else
        cLastError   := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()

        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail)
    EndIf

    FWRestArea(aArea)
Return
