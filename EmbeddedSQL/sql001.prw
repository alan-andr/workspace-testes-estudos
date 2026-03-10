#Include 'protheus.ch'
#Include 'totvs.ch'

User Function SQL001()
    Local aProdutos := {}

    RpcSetEnv("99", "01")

    BeginSQL Alias "TMP_SB1"
        SELECT B1_COD, B1_DESC
        FROM %Table:SB1% 
        WHERE %NotDel%
    EndSQL

    While !TMP_SB1->( EoF() )
        ConOut("Codigo: " + TMP_SB1->B1_COD + " | Descricao: " + TMP_SB1->B1_DESC)

        aAdd(aProdutos, {AllTrim(TMP_SB1->B1_COD), AllTrim(TMP_SB1->B1_DESC)})

        TMP_SB1->( DbSkip() )
    EndDo

    TMP_SB1->( DbCloseArea() )

    aEval(aProdutos, {|x| ConOut("Código: " + x[1] + " | Descricao: " + x[2])})

    RpcClearEnv()
Return
