#Include 'totvs.ch'
#Include 'protheus.ch'

// ! COMO DESCOBRIR SE UMA ROTINA TEM EXECUÇÃO AUTOMÁTICA

User Function EXEC003()
    Local aArea := FWGetArea()
    Local xParam := 5

    // * Aciona o cadastro de vendedores, passando um parametro qualquer para a rotina 
    MATA040(xParam)

    FWRestArea(aArea)
Return
