#Include 'protheus.ch'
#Include 'totvs.ch'

User Function MANI003()
    Local cArquivo := "C:\Projetos\local\workspace-testes-estudos\arquivos\arquivoteste.txt"
    Local cNovoArq := "C:\Projetos\local\workspace-testes-estudos\arquivos\arquivoteste_finalizado.bak"

    If FRename(cArquivo, cNovoArq) == -1
        MsgStop("Não foi possível renomear/mover arquivo.")
    Else
        FWAlertSuccess("O arquivo foi renomeado/movido com sucesso!")
    EndIf
Return
