#Include 'totvs.ch'
#Include 'protheus.ch'

User Function SYSPAR()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest()    :New("http://localhost:8400/rest")
    Local cPath        := "/api/framework/v1/systemParameters"
    Local jJson        := jsonObject():New()
    Local cJsonBody    := ""
    Local cUser        := "admin"
    Local cPass        := "123"
    Local cBasicTkn    := Encode64(cUser + ':' + cPass)
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local cParam       := ""
    Local cDescri      := ""
    Local aDados       := {}
    Local nX           := 0

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus + ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Basic ' + cBasicTkn)

    oRest:SetPath(cPath)

    If oRest:Get(aHeader)
    
        cJsonBody := oRest:GetResult()

        jJson:fromJson(cJsonBody)

        aDados := jJson["items"]
        aLista := aDados["aDados"]

        For nX := 1 To Len( aLista )

            cParam  := aLista[nX]['code']
            cDescri := aLista[nX]['description'][1]['descriptionText']

            FWAlertSuccess("<b>Parâmetro: </b>" + cParam + CRLF + "<b>Descrição: </b>" + cDescri, "Sucesso")

        Next nX

    Else
        cLastError := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError("Erro: " + cLastError + " - Detalhes: " + cErrorDetail, "Erro")
    EndIf

    FWRestArea(aArea)
Return
