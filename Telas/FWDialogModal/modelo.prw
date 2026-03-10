#Include 'totvs.ch'
#Include 'protheus.ch'

User Function MODEL001()
    Local cTitulo := '<b>HISTÓRICO DE IMPORTAÇÕES COM DIVERGÊNCIAS</b>'
    Local aButtons := {}

    Local nAltura := 320
    Local nLargura := 745

    Local oModal
    Local oPanel
    Local oLayer
    Local oPanelDados

    Local cTipoBusca := '000001223'
    Local aOpc := {'0 - Todos', '1 - Doc. Fiscal', '2 - Nome Fornecedor', '3 - Cód. Fornecedor'}
    Local cFiltro := Space(120)

    Local cFonte := 'Arial'
    Private oFont1 := TFont():New(cFonte, , -12, , .T.)
    Private oFont2 := TFont():New(cFonte, , -10, , .F.)

    AAdd(aButtons, { .F., "Remover", {|| FWAlertInfo("Corrigindo...", "Remoção")}, "", 0, .T., .F. })
    AAdd(aButtons, { .F., "Corrigir", {|| FWAlertInfo("Corrigindo...", "Correção")}, "", 0, .T., .F. })
    AAdd(aButtons, { .F., "Reprocessar", {|| FWAlertInfo("Reprocessando...", "Reprocesso")}, "", 0, .T., .F. })

    oModal := FWDialogModal():New()
    oLayer := FWLayer():New()

    oModal:SetTitle(cTitulo)
    oModal:SetSize(nAltura, nLargura )
    oModal:EnableFormBar(.T.)
    oModal:CreateDialog()
    oModal:CreateFormBar()
    oModal:AddButtons(aButtons)
    oPanel := oModal:GetPanelMain()

    oLayer:Init(oModal:GetPanelMain())

    oLayer:AddLine('ROW_MAIN', 100, .F.)
    oLayer:AddCollumn('COL_MAIN', 100, .F., 'ROW_MAIN')

    oPanelDados := oLayer:GetColPanel('COL_MAIN', 'ROW_MAIN')

    oSayTpBusc := TSay():New(10, 15, {|| "Tipo de Busca"}, oPanelDados, , oFont1, .F., .F., .F., .T., CLR_BLACK,  ,120, 10)
    oCombo := TComboBox():New(6, 60, {|u| if(PCount() > 0, cTipoBusca := u, cTipoBusca)}, aOpc, 80, 40, oPanelDados, , , , , , .T., , , , , .T.)

    oSayFiltr := TSay():New(10, 160, {|| "Filtrar"}, oPanelDados, , oFont1, .F., .F., .F., .T., CLR_BLACK,  ,120, 10)
    oGet := TGet():New(6, 183, {|u| If(PCount() > 0, cFiltro := u, cFiltro)}, oPanelDados, 200, 13, "@!", , , , , .F., , .T.)

    oSayDesErr := TSay():New(10, 400, {|| "Desc. Erro"}, oPanelDados, , oFont1, .F., .F., .F., .T., CLR_BLACK,  ,120, 10)
    oMulti := TMultiGet():New(6, 435, {|u| If(PCount() > 0, cFiltro := u, cFiltro)}, oPanelDados, 290, 15, oFont2, , , , , .T.,)

    oModal:Activate()
Return

