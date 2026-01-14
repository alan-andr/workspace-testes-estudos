#Include 'totvs.ch'
#Include 'protheus.ch'

User Function POSTPROD()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest()    :New('localhost:8400/rest' )
    Local cPath        := '/zWSProdutos/new'
    Local cUser        := 'admin'
    Local cPass        := '123'
    Local cToken       := Encode64(cUser + ':' + cPass)
    Local jJson        := jsonObject():New()
    Local cJsonBody    := ''
    Local cLastError   := ''
    Local cErrorDetail := ''
    Local nHTTPCode    := 0

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')
    aAdd(aHeader, 'Authorization: Basic ' + cToken)

    jJson[ 'cod' ]    := "00000036"
    jJson[ 'desc' ]   := "Produto teste Postman"
    jJson[ 'tipo' ]   := "PA"
    jJson[ 'um' ]     := "KG"
    jJson[ 'locpad' ] := "01"
    jJson[ 'grupo' ]  := "0001"

    cJsonBody := jJson:toJson()

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Post(aHeader)
        FWAlertSuccess('Produto cadastrado com sucesso na tabela SB1 - Produtos', "POST")
    Else 
        cLastError   := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        nHTTPCode    := Val( oRest:GetHTTPCode() )
        
        FWAlertError('Erro: ' + cLastError + ' - Detalhes: ' + cErrorDetail + 'Codigo: ' + cValToChar( nHTTPCode ), 'Erro')
    EndIf

    FWRestArea(aArea)
Return
