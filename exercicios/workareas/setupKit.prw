#Include 'totvs.ch'
#Include 'protheus.ch'

User Function SetupKit()
    RpcSetEnv("99", "01")

    ChkFile("SB2", .F.) // Cria arquivo físico no disco rígido do PC, .F. modo compartilhado

    DbSelectArea("SB2")
    DbSetOrder(1)

    If Len( TamSX3("B2_COD") ) > 0 // Retorna o array da estrutura do campo B2_COD, Ex: { 15, 0, "C", "@!" }
        fCriaSaldo("MOUSE", 10) 
        fCriaSaldo("TECLADO", 10) // Chama função passando Código do produto e quantidade de saldo
        fCriaSaldo("KITGAMER", 0)

        Alert("SUCESSO: Tabela SB2 criada e Saldos gerados!")
    Else
        Alert("ERRO: Problema no dicionário SX3.")
    EndIf

    FWAlertSuccess("Estoque de Componentes criado!") // Se a condição for verdadeira

    SB2->( DbCloseArea() )

    RpcClearEnv()
Return

Static Function fCriaSaldo(cCod, nQtd)
    Local cChave := xFilial("SB2") + PadR(cCod, TamSX3("B2_COD")[1]) + "01"

    If !DbSeek( cChave ) // Se não encontrar o código do produto, cria o com filial, codigo, local e quantidade de saldo
        RecLock("SB2", .T.)
            SB2->B2_FILIAL := xFilial("SB2")
            SB2->B2_COD := cCod
            SB2->B2_LOCAL := "01"
            SB2->B2_QATU := nQtd
        SB2->( MsUnlock() )
    Else // Se encontrar só adiciona a quantidade ao saldo 
        RecLock("SB2", .F.)
            SB2->B2_QATU := nQtd
        SB2->( MsUnlock() )
    EndIf
Return
