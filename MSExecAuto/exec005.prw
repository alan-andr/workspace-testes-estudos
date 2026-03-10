#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EXEC005()
    Local aArea 
    Local lDeuCerto 
    Local oModel 
    Local oSA2Mod
    Local aErro 

    RpcSetEnv('99', '01')

    aArea := FWGetArea()
    lDeuCerto := .F.
    aErro :={}

    // * Pegando o modelo e definindo operação de inclusão
    oModel := FWLoadModel( 'MATA020' )
    oModel:SetOperation(3)
    oModel:Activate()

    // * Pegando o modelo dos campos da SA2
    oSA2mod := oModel:GetModel('SA2MASTER')
    oSA2Mod:SetValue( 'A2_COD' , 'F00005' )
    oSA2Mod:SetValue( 'A2_LOJA' , '01' )
    oSA2Mod:SetValue( 'A2_NOME' , 'FORNECEDOR MVC' )
    oSA2Mod:SetValue( 'A2_NREDUZ' , 'MVC' )
    oSA2Mod:SetValue( 'A2_END' , 'RUA DOS TESTES' )
    oSA2Mod:SetValue( 'A2_BAIRRO' , 'TESTE' )
    oSA2Mod:SetValue( 'A2_TIPO' , 'J' )
    oSA2Mod:SetValue( 'A2_EST' , 'SP' )
    oSA2Mod:SetValue( 'A2_COD_MUN' , '06003' )
    oSA2Mod:SetValue( 'A2_MUN' , 'BAURU' )
    oSA2Mod:SetValue( 'A2_CGC' , '00000000000000' )

    // * Se conseguir validar as informações e realizar a gravação
    If oModel:VldData() .AND. oModel:CommitData()
        lDeuCerto := .T.
    Else
        lDeuCerto := .F.
    EndIf

    If lDeuCerto
        FWAlertSuccess('Registro Incluído', 'Atenção')
    Else
        // * Busca o erro do modelo de dados
        aErro := oModel:GetErrorMessage()

        // * Monta o erro que será mostrado na tela 
        AutoGrLog( 'ID do formulário de origim: ' + '[' + AllToChar(aErro[01]) + ']' )
        AutoGrLog( 'ID do campo de origim: ' + '[' + AllToChar(aErro[02]) + ']' )
        AutoGrLog( 'ID do formulário do erro: ' + '[' + AllToChar(aErro[03]) + ']' )
        AutoGrLog( 'ID do campo do erro: ' + '[' + AllToChar(aErro[04]) + ']' )
        AutoGrLog( 'ID do erro: ' + '[' + AllToChar(aErro[05]) + ']' )
        AutoGrLog( 'Mensagem do erro: ' + '[' + AllToChar(aErro[06]) + ']' )
        AutoGrLog( 'Mensagem da solução:' + '[' + AllToChar(aErro[07]) + ']' )
        AutoGrLog( 'Valor atribuído: ' + '[' + AllToChar(aErro[08]) + ']' )
        AutoGrLog( 'Valor anterior: ' + '[' + AllToChar(aErro[09]) + ']' )
    EndIf

    oModel:DeActivate()
    RpcClearEnv()
    FWRestArea(aArea)
Return
