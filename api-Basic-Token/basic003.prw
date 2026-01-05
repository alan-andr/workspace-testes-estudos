#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSBASICP() 
    Local aArea       := FWGetArea()
    Local cUser       := "user"
    Local cPass       := "passwd"
    Local cToken      := Encode64(cUser + ":" + cPass)
    Local oRestCLient := FWRest():New("https://httpbin.org")
    Local cPath       := "/post
    Local aHeader     := {}
    Local cResult     := ""
    Local cCodeHTTP   := ""
    Local cLastError  := ""
    Local cErroDetail := ""
    Local oJson       := Nil
    Local cJsonBody   := ""

    oJson := jsonObject():New()

    oJson[ 'codigo' ]         := 'CLI001'
    oJson[ 'razao_social' ]   := 'Tech Solutions Brasil Ltda'
    oJson[ 'fantasia' ]       := 'Tech Solutions'
    oJson[ 'ativo' ]          := .T.
    oJson[ 'limite_credito' ] := 15000.00

    cJsonBody := oJson:ToJson()

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aadd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Basic ' + cToken)

    oRestCLient:SetPath(cPath)

    oRestCLient:SetPostParams(cJsonBody)

    If oRestClient:Post(aHeader)

        cResult := oRestClient:GetResult()
        cCodeHTTP := oRestCLient:GetHTTPCode()

        FWAlertSuccess('Dados enviados com sucesso' + CRLF + 'Resultado: ' + cResult + CRLF + 'Código HTTP: ' + cCodeHTTP, 'Retorno API')

    Else

        cLastError := oRestCLient:GetLastError()
        cErroDetail := oRestCLient:GetResult()
        cCodeHTTP := oRestClient:GetHTTPCode()

        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErroDetail + CRLF + 'Código HTTP: ' + cCodeHTTP, 'Erro na Requisição')

    EndIf

    FreeObj(oJson)
    FreeObj(oRestCLient)
    FWRestArea(aArea)
Return
