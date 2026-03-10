#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EXEC006()
    Local aArea 
    Private lMsErroAuto
    Private aRotina
    Private xAuto 
    Private cCadastro 

    RpcSetEnv('99', '01')

    aArea := FWGetArea()
    lMsErroAuto  := .F.
    aRotina := FWLoadMenuDef('MATA040')
    xAuto := {}
    cCadastro := 'Vendedores'

    // * Adicionando os dados do ExecAuto
    aAdd(xAuto, {'A3_COD', 'V00001', Nil})
    aAdd(xAuto, {'A3_NOME', 'Vendedor Teste', Nil})

    // * Aciona a execução automática com inclusão
    MBrowseAuto(3, xAuto, 'SA3')

    If lMsErroAuto
        MostraErro()
    Else
        FWAlertSuccess('Vendedor incluído com sucesso', 'Atenção')
    EndIf

    RpcClearEnv()
    FWRestArea(aArea)
Return
