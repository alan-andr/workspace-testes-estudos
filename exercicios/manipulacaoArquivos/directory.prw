#Include 'totvs.ch'
#Include 'protheus.ch'

User Function MANI004()
    Local cArquivo := "C:\Projetos\local\workspace-testes-estudos\arquivos\arquivoteste_finalizado.bak"
    Local cNovoArq := "C:\Projetos\local\workspace-testes-estudos\arquivos\arquivoteste.txt"
    Local aInfoFile := {}

    If File( cArquivo )

        aInfoFile := Directory(cArquivo)

        If Len(aInfoFile) > 0 
            ConOut("=== Informações do arquivo ===")
            ConOut("Nome: " + aInfoFile[1, 1])
            ConOut("Tamanho: " + cValToChar(aInfoFile[1, 2]) + " bytes")
            ConOut("Data: " + DToC(aInfoFile[1, 3]))
        EndIf

        If FRename(cArquivo, cNovoArq) == -1

            MsgStop("ERRO: Não foi possível renomear/mover o arquivo.")

        Else 

            FWAlertSuccess("O arquivo foi renomeado/movido com sucesso", "Sucesso")

        EndIf

    Else
        Alert("O arquivo não existe.")
    EndIf
Return
