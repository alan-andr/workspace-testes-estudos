#Include 'protheus.ch'
#Include 'totvs.ch'

User Function BEARER03()
    Local aArea := FWGetArea()
    Local aHeader := {}
    Local oRestClient := FWRest():New('https://httpbin.org')
    Local cToken := 'Hd0wDOyYlbFxs1Za84oucVzCQ5V4h9kfhJjEKzum3pCwg93x2qjXiP2Zz0uhHC4S'
    Local oJson := jsonObject():New()
    Local cJsonBody := ''
    Local cResult := ''
    Local cHTTPCode := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Bearer ' + cToken)

    oJson['id'] := 101
    oJson['item'] := 'Notebook Gamer'
    oJson['setor'] := 'Desenvolvimento'

    cJsonBody := oJson:ToJson(oJson)

    oRestClient:SetPath('/get?id=101')

    If oRestCLient:Get(aHeader)
        cHTTPCode := oRestCLient:GetHTTPCode()

        If Val(cHTTPCode) == 200

            oJson['item'] := 'Desktop Office Dell'
            cJsonBody := oJson:toJson(oJson)
            
            oRestCLient:SetPath('/put')
            oRestCLient:SetPostParams(cJsonBody)

            If oRestClient:Put(aHeader)
                FWAlertSuccess('Equipamento atualizado! Resposta: ' + cResult, 'Sucesso')
            EndIf

        EndIf

    Else

        oRestCLient:SetPath('/post')
        oRestCLient:SetPostParams(cJsonBody)

        If oRestClient:Post(aHeader)
            FWAlertSuccess('Novo equipamento criado! Resultado: ' + cResult, 'Sucesso')
        EndIf

    EndIf

    FreeObj(oRestClient)
    FreeObj(oJson)
    FWRestArea(aArea)
Return
