#Include "protheus.ch"
#Include "totvs.ch"
#Include "fwmvcdef.ch"

// TODO https://terminaldeinformacao.com/2021/01/06/o-que-pode-ser-quando-botoes-nao-funcionam-em-mvc/
// TODO Modelos de telas MVC: https://terminaldeinformacao.com/2021/04/14/quais-sao-os-modelos-de-cadastro-em-advpl/

// variáveis estáticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"

User Function zMVC01()
  Local aArea     := FwGetArea()
  Local oBrowse   := Nil
  Private aRotina := {}

  // * Definifição do meni
  aRotina := MenuDef()
    
  // * Instanciando o browse
  oBrowse := FWMBrowse():New()    
  oBrowse:SetAlias(cAliasMVC)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  // * Ativa o browse
  oBrowse:Activate()

  FWRestArea(aArea) 
Return Nil

Static Function MenuDef() // * Cria o menu de opções da tela, sempre que for dar um ADD OPTION, aponte no VIEWDEF para a sua User Function
  Local aRotina := {}

  // * Adicionando opções do menu
  ADD OPTION aRotina TITLE "Pesquisar" ACTION "VIEWDEF.zMVC01" OPERATION 2 ACCESS 0 // * Em MVC é o inverso
  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC01" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC01" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC01" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC01" OPERATION 5 ACCESS 0
Return aRotina 

Static Function ModelDef() // * Define a modelagem de dados - Tabelas, campos e relacionamentos
  Local oStruct := FwFormStruct(1, cAliasMVC) 
  Local oModel  := Nil
  Local bPre    := Nil
  Local bPos    := Nil
  Local bCommit := Nil
  Local bCancel := Nil

  // * Cria o modelo de dados para cadastro
  oModel := MpFormModel():New("zMVC01M", bPre, bPos, bCommit, bCancel) // * O nome aqui deve ser diferente da User Function porque ele reserva como ponto de entrada
  oModel:AddFields("ZD1MASTER", /* cOwner */, oStruct)
  oModel:SetDescription("Modelo de Dados - " + cTitulo)
  oModel:GetModel("ZD1MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})
Return oModel

Static Function ViewDef() // * Pega a modelagem de dados e montar na tela
  Local oModel  := FwLoadModel("zMVC01") // * Carrega o modelo de dados
  LOcal oStruct := FwFormStruct(2, cAliasMVC) 
  Local oView   := Nil

  // * Cria a visualização do cadastro
  oView := FwFormView():New()
  oView:SetModel(oModel)
  oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
  oView:CreateHorizontalBox("TELA", 100)
  oView:SetOwnerView("VIEW_ZD1", "TELA")
Return oView
