#Include 'Protheus.ch'
#Include 'TopConn.ch'

User Function SetupDados()
    Local aTables := {"SE4", "SBM", "SB1", "SC5", "SC6"}
    Local nX

    RpcSetEnv("99", "01")

    // --- ETAPA 1: Garantir que as tabelas existam e abrir ---
    For nX := 1 To Len(aTables)
        // ChkFile verifica se a tabela existe. Se não, cria. Se sim, abre.
        // O segundo parametro .F. indica que nao queremos abrir em modo exclusivo (travar tudo)
        ChkFile(aTables[nX], .F.)
    Next nX

    // --- ETAPA 2: Gravar os Dados ---

    // 1. Condições de Pagamento
    CreateSE4("001", "A VISTA")
    CreateSE4("030", "30 DIAS")

    // 2. Grupos de Produto
    CreateSBM("01", "ELETRONICOS")
    CreateSBM("02", "MOVEIS")
    
    // 3. Produtos
    CreateSB1("TV001  ", "SMART TV 50", "01") 
    CreateSB1("CADEIRA", "CADEIRA GAMER", "02") 
    
    // 4. Pedidos
    CreatePed("P00001", "001", "TV001  ")
    CreatePed("P00002", "030", "CADEIRA")

    Alert("SUCESSO: Tabelas criadas e dados inseridos!")
    
    RpcClearEnv()
Return

// --- Sub-funções de Gravacao ---

Static Function CreateSE4(cCod, cDesc)
    DbSelectArea("SE4")
    DbSetOrder(1)
    If !DbSeek(xFilial("SE4")+cCod)
        RecLock("SE4", .T.)
        SE4->E4_FILIAL := xFilial("SE4")
        SE4->E4_CODIGO := cCod
        SE4->E4_DESCRI := cDesc
        SE4->E4_COND   := "000" // Campo obrigatorio em algumas versoes
        SE4->(MsUnlock())
    EndIf
Return

Static Function CreateSBM(cGrupo, cDesc)
    DbSelectArea("SBM")
    DbSetOrder(1)
    If !DbSeek(xFilial("SBM")+cGrupo)
        RecLock("SBM", .T.)
        SBM->BM_FILIAL := xFilial("SBM")
        SBM->BM_GRUPO  := cGrupo
        SBM->BM_DESC   := cDesc
        SBM->(MsUnlock())
    EndIf
Return

Static Function CreateSB1(cCod, cDesc, cGrupo)
    DbSelectArea("SB1")
    DbSetOrder(1)
    If !DbSeek(xFilial("SB1")+cCod)
        RecLock("SB1", .T.)
        SB1->B1_FILIAL := xFilial("SB1")
        SB1->B1_COD    := cCod
        SB1->B1_DESC   := cDesc
        SB1->B1_GRUPO  := cGrupo
        SB1->B1_TIPO   := "PA" // Tipo Produto Acabado
        SB1->B1_UM     := "UN" // Unidade de Medida
        SB1->(MsUnlock())
    EndIf
Return

Static Function CreatePed(cNum, cCond, cProd)
    DbSelectArea("SC5")
    DbSetOrder(1)
    If !DbSeek(xFilial("SC5")+cNum)
        // Cabecalho SC5
        RecLock("SC5", .T.)
        SC5->C5_FILIAL  := xFilial("SC5")
        SC5->C5_NUM     := cNum
        SC5->C5_TIPO    := "N"
        SC5->C5_CONDPAG := cCond
        SC5->C5_CLIENTE := "C001  " // Assumindo cliente padrao
        SC5->C5_LOJACLI := "01"
        SC5->C5_EMISSAO := Date()
        SC5->(MsUnlock())

        // Item SC6
        DbSelectArea("SC6")
        RecLock("SC6", .T.)
        SC6->C6_FILIAL := xFilial("SC6")
        SC6->C6_NUM    := cNum
        SC6->C6_ITEM   := "01"
        SC6->C6_PRODUTO:= cProd
        SC6->C6_QTDVEN := 1
        SC6->C6_PRCVEN := 100
        SC6->C6_VALOR  := 100
        SC6->C6_TES    := "501"
        SC6->(MsUnlock())
    EndIf
Return
