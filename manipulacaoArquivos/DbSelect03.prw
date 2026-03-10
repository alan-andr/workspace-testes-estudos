#Include 'totvs.ch'

User Function DBSEL03()
    Local aArea    := FWGetArea()
    Local aClientes := {}
    Local nX       := 0
    
    // Organizando os dados de forma mais fácil para percorrer (Matriz)
    // Estrutura: {Código, Loja, Nome, Estado, Limite}
    AAdd(aClientes, {"000001", "01", "Comercio Global", "SP", 5000})
    AAdd(aClientes, {"000002", "01", "Aguia Express", "RJ", 7500})
    AAdd(aClientes, {"000003", "01", "Importacoes Pacifico", "MG", 12000})

    // RpcSetEnv ja abre as tabelas, mas vamos garantir o contexto
    DbSelectArea("SA1")
    DbSetOrder(1) // Indice 1 geralmente é FILIAL + COD + LOJA

    For nX := 1 To Len(aClientes)
        
        // Pesquisa pelo Código + Loja para ver se ja existe
        If DbSeek(xFilial("SA1") + aClientes[nX][1] + aClientes[nX][2])
            
            // Se for de SP, atualiza (Conforme o enunciado)
            If SA1->A1_EST == "SP"
                RecLock("SA1", .F.)
                    SA1->A1_LC := aClientes[nX][5] * 1.15
                MsUnlock()
                ConOut("Cliente " + aClientes[nX][3] + " atualizado com sucesso!")
            EndIf
            
        Else
            // Se nao existir, inclui com os campos obrigatorios
            RecLock("SA1", .T.)
                SA1->A1_FILIAL := xFilial("SA1")
                SA1->A1_COD    := aClientes[nX][1]
                SA1->A1_LOJA   := aClientes[nX][2]
                SA1->A1_NOME   := aClientes[nX][3]
                SA1->A1_EST    := aClientes[nX][4]
                SA1->A1_LC     := aClientes[nX][5]
            MsUnlock()
            ConOut("Cliente " + aClientes[nX][3] + " incluido com sucesso!")
        EndIf
        
    Next nX

    FWRestArea(aArea)
Return
