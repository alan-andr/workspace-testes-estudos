#Include "protheus.ch"
#Include "totvs.ch"
#Include "fwmvcdef.ch"

// TODO MVC - Modelo 3

Static cTabPai := "ZD2"
Static cTabFilho := "ZD3"
Static cTitulo := "Artistas e Músicas"

User Function zMVC02()
  Local aArea     := FwGetArea()
  Local oBrowse   := Nil
  Private aRotina := {}

  aRotina := MenuDef()

  oBrowse := FwmBrowse():New()
  oBrowse:SetAlias(cTabPai)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  oBrowse:Activate()

  FwRestArea(aArea)
Return Nil

Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Pesquisar" ACTION "VIEWDEF.zMVC02" OPERATION 2 ACCESS 0
  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC02" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC02" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC02" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC02" OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()
  // * Cria o modelo de dados para cadastro
  Local oStruPai   := FWFormStruct(1, cTabPai)
  Local oStruFilho := FWFormStruct(1, cTabFilho)
  Local aRelation  := {}
  Local oModel     := Nil
  Local bPre       := Nil
  Local bPos       := Nil
  Local bCommit    := Nil
  Local bCancel    := Nil

  oModel := MPFormModel():New("zMVC02M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("ZD2MASTER", /* cOwner*/, oStruPai)
  oModel:AddGrid("ZD3DETAIL", "ZD2MASTER", oStruFilho, /* bLinePre*/, /* bLinePost*/, /*bPre - Grid Inteiro*/, /* bPos - Grid Inteiro*/ )
  oModel:SetDescription("Modelo de Dados - " + cTitulo)
  oModel:GetModel("ZD2MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:GetModel("ZD3DETAIL"):SetDescription("Grid de - " + cTitulo)
  oModel:SetPrimaryKey({})

  // * Fazendo o relacionamento Filho | Pai
  aAdd(aRelation, {"ZD3_FILIAL", "xFilial('ZD3')"})
  aAdd(aRelation, {"ZD3_CD", "ZD2_CD"})
  oModel:SetRelation("ZD3DETAIL", aRelation, ZD3->(IndexKey(1)))

  // * Definindo campos únicos da linha
  oModel:GetModel("ZD3DETAIL"):SetUniqueLine({"ZD3_MUSICA"})
Return oModel

Static Function ViewDef()
  Local oModel     := FWLoadModel("zMVC02")
  LocaL oStruPai   := FWFormStruct(2, cTabPai)
  Local oStruFilho := FWFormStruct(2, cTabFilho)
  Local oView      := Nil

  // * Cria a visualização do cadastro
  oView := FWFormView():New()
  oView:SetModel(oModel)
  oView:AddField("VIEW_ZD2", oStruPai, "ZD2MASTER")
  oView:AddGrid("VIEW_ZD3", oStruFilho, "ZD3DETAIL")

  // * Partes da tela
  oView:CreateHorizontalBox("CABEC", 30) // * 30% da tela
  oView:CreateHorizontalBox("GRID", 70) // * 70% da tela
  oView:SetOwnerView("VIEW_ZD2", "CABEC") // * Cria o vínculo
  oView:SetOwnerView("VIEW_ZD3", "GRID") // * Cria o vínculo

  // * Títulos
  oView:EnableTitleView("VIEW_ZD2", "Cabeçalho - ZD2 (CDs)")
  oView:EnableTitleView("VIEW_ZD3", "Grid - ZD3 (Músicas dos CDs)")

  // * Removendo campos
  oStruFilho:RemoveField("ZD3_CD")

  // * Adicionando campo incremental na grid
  oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")
Return oView
 