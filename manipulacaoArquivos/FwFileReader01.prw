#Include 'protheus.ch'
#Include 'totvs.ch'

User Function MANII002()
    Local aArea      := FWGetArea()
    Local cArquivo   := "C:\Projetos\local\workspace-testes-estudos\arquivos\arquivoteste.txt"
    Local oFile      := Nil
    Local aLinhas    := {}
    Local nTotLinhas := 0
    Local nLinAtual  := 0
    Local cLinAtual  := ""

    If File(cArquivo)

        oFile := FWFileReader():New(cArquivo)

        If oFile:Open()

            aLinhas    := oFile:GetAllLines()
            nTotLinhas := Len(aLinhas)
            nLinAtual  := 0

            // * 1 - Método de ler linhas
            For nLinAtual := 1 To nTotLinhas
                cLinAtual := oFile:GetLine()

                ConOut("Linha: " + cValToChar(nLinAtual) + ": " + cLinAtual)
            Next

            oFile:Close()
            oFile := FWFileReader():New(cArquivo)
            oFIle:Open()


            // * 2 - Método de ler linhas
            While ( oFile:HasLine() )
                nLinAtual++

                cLinAtual := oFile:GetLine()
                ConOut("Linha: " + cValToChar(nLinAtual) + ": " + cLinAtual)
            EndDo
            
        EndIf

        oFile:Close()

    EndIf

    FWRestArea(aArea)

Return
