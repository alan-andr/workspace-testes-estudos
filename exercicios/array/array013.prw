#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY013()
    Local aProdutos := {}
    Local nI := 0
    Local cCod := ''
    LocaL cDesc := ''
    Local cTipo := ''

    aAdd(aProdutos, {'A001R', 'Servico de Consultoria Fiscal', '001'})
    aAdd(aProdutos, {'M015B', 'Componente Eletronico Placa', '002'})
    aAdd(aProdutos, {'A002S', 'Assessoria Juridica Mensal', '001'})
    aAdd(aProdutos, {'M020X', 'Parafuso Aço Inoxidavel', '002'})
    aAdd(aProdutos, {'A003T', 'Servico de Manutencao Cloud', '001'})
    aAdd(aProdutos, {'M035C', 'Kit Teclado e Mouse Sem Fio', '002'})

    aProdutos := processaDados( aProdutos )

    For nI := 1 To Len( aProdutos )
        cCod := aProdutos[nI, 1]
        cDesc := aProdutos[nI, 2]
        cTipo := aProdutos[nI, 3]

        ConOut('Código do Produto: ' + cCod + ' | Descrição: ' + cDesc + ' | Tipo: ' + cTipo)
    Next nI

Return

Static Function processaDados(aDados)
    Local cTipoProd := ''
    Local cDescProd := ''
    Local nX := 0

    For nX := 1 To Len( aDados )

        cTipoProd := aDados[nX, 3]
        cDescProd := aDados[nX, 2]

        If cTipoProd == '001'

            cDescProd := 'SRV - ' + cDescProd

        ElseIf cTipoProd == '002'

            cDescProd := 'MER - ' + cDescProd
 
        Else

            cDescProd := 'UNK - ' + cDescProd

        EndIf

        aDados[nX, 2] := cDescProd // Vai salvando no array de acordo as expressões que forem verdadeiras

    Next nX

Return aDados
