#Include 'protheus.ch'
#Include 'totvs.ch'

User Function CSCNPJ()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestCLient  := FWRest():New("https://brasilapi.com.br")
    Local oJson        := Nil
    Local cCNPJ        := FWInputBox("Informe um CNPJ: ")
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local cNomFant     := ""
    Local cMunicip     := ""

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestCLient:SetPath('/api/cnpj/v1/' + cCNPJ)
    If oRestCLient:Get(aHeader)

        cResult := oRestCLient:GetResult()
        oJson := jsonObject():New()
        oJson:fromJson(cResult)

        If ValType(oJson['name']) == "C" .AND. oJson['name'] == "NotFoundError"

            MsgInfo("O CNPJ: " + cCNPJ + "não foi encontrado na base dados.")

            Return .F.

        EndIf

        cNomFant := oJson['nome_fantasia']
        cMunicip := oJson['municipio']

        MsgInfo("Nome fantasia: " + cNomFant + CRLF + "Município: " + cMunicip, "Resultado CNPJ: " + cCNPJ)

    Else

        cLastError := oRestCLient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        MsgAlert("Erro: " + cErrorDetail)

    EndIf

    FWRestArea(aArea)
Return
