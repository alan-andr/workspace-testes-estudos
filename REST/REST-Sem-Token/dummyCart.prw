#Include 'protheus.ch'
#Include 'totvs.ch'

User Function DUMPUT()
    Local aArea := FWGetArea()
    Local aHeader := {}
    Local aProdutos := {}
    Local oRest := FWRest():New('https://dummyjson.com')
    Local cPath := '/carts/1'
    Local cJsonBody := ''
    Local jRoot := jsonObject():New()
    Local jJson := jsonObject():New()
    Local cResult := ''
    Local cLastError := ''
    Local cErrorDetail := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    jJson['id'] := 2
    jJson['quantity'] := 5

    aAdd(aProdutos, jJson)

    jRoot['merge'] := .T.
    jRoot['products'] := aProdutos

    cJsonBody := jRoot:toJson()

    ConOut('Corpo da requisição: ' + cJsonBody)

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Put(aHeader)
        cResult := oRest:GetResult()

        FWAlertInfo('Resultado: ' + cResult, '')
    Else
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertInfo('Erro: ' + cLastError + ' - detalhes: ' + cErrorDetail, '')
    EndIf

    FreeObj(jRoot)
    FreeObj(jJson)
    FWRestArea(aArea)
Return
