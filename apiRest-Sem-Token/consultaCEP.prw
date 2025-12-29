#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSCEP() 
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestClient  := FWRest():New("https://viacep.com.br/ws")
    Local cCep         := FWInputBox("Informe um CEP: ")
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local oJson        := Nil

    // * Adiciona os headers que serão enviados via WS
    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')

    // * Define a URL conforme o CEP e aciona o método GET
    oRestClient:SetPath("/" + cCep + "/json/")
    If oRestClient:Get(aHeader)

        cResult := oRestClient:GetResult()

        oJson := jsonObject():New()
        oJson:fromJson(cResult)

        If ValType(oJson['erro']) == "C" .AND. oJson['erro'] == "true"

            FWAlertInfo("Não foi encontrado nenhum registro com o CEP: " + cCep)

        EndIf

        // * Exibe o resultado que veio do WS
        MsgInfo(cResult, "Resultado do CEP: " + cCep)

    // * Se não, pega os erros e exibe alerta 
    Else

        cLastError   := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()

        Alert("Erro:" + cLastError + " - Detalhes: " + cErrorDetail)

    EndIf

    FWRestArea(aArea)
Return
