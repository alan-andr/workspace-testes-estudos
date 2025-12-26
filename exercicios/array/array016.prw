#Include 'protheus.ch'
#Include 'totvs.ch'

User Function ARRAY016()
    Local aFuncio :={{"João Silva", 2500.00, "Produção"},;
                    {"Ana Costa"                       , 7000.00, "Diretoria"},;
                    {"Carlos Souza"                    , 1500.00, "Produção"},;
                    {"Maria Oliveira"                  , 4800.00, "TI"}}
    Local bFiltrar :={|x| Iif( x[2] > 3000.00, ConOut("Nome: " + x[1]), Nil )}

    ConOut("Lista de funcionarios que ganham mais de R$ 3000.00")
    aEval(aFuncio, bFiltrar)
Return
