#Include 'totvs.ch'
#Include 'protheus.ch'

User Function CSCEP02()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRestClient  := FWRest():New("https://viacep.com.br/ws")
    Local oJson        := Nil
    Local cCEP         := FWInputBox("Informe um <b>CEP</b> para consultar: ", "")
    Local cPath        := "/" + cCEP + "/json/"
    Local cResult      := ""
    Local cLastError   := ""
    Local cErrorDetail := ""
    Local cResCEP := ""
    Local cResEnd := ""
    Local cResBair := ""
    Local cResLocal := ""
    Local cResEst := ""
    Local cResReg := ""

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    oRestClient:SetPath(cPath)

    If oRestClient:Get(aHeader)

        cResult   := oRestClient:GetResult()
        oJson     := jsonObject():New()
        oJson:fromJson(cResult)

        cResCEP   := oJson[ 'cep' ]
        cResEnd   := oJson[ 'logradouro' ]
        cResBair  := oJson[ 'bairro' ]
        cResLocal := oJson[ 'localidade' ]
        cResEst   := oJson[ 'estado' ]
        cResReg   := oJson[ 'regiao' ]

        FWAlertSuccess('CEP: ' + cResCEP + CRLF + 'Endereço: ' + cResEnd + CRLF + 'Bairro: ' + FWNoAccent(cResBair) + CRLF + 'Município: ' + cResLocal + CRLF + 'Estado: ' + cResEst + CRLF + 'Região: ' + cResReg, 'Resultado CEP')

    Else

        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - detalhes: ' + cErrorDetail, 'Erro')

    EndIf

    FWRestArea(aArea)
Return
