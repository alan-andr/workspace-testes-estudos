#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EXEC007()
    Local aArea              := FWGetArea()
    Local aDados             := {}
    Local nLinha             := 0
    Local cDir               := ''
    Local cArquivo           := ''
    Local aLogErro           := {}
    Local cTextoErro         := ''
    Private lMsAutoErrNoFile := .T.
    Private lMsHelpAuto      := .T.
    Private lMsErroAuto      := .F.

    RpcSetEnv('99', '01')

    aadd(aDados, {'B1_COD'   , 'E0002'          , Nil})
    aadd(aDados, {'B1_DESC'  , 'Canela Vermelha', Nil})
    aadd(aDados, {'B1_TIPO'  , 'PA'             , Nil})
    aadd(aDados, {'B1_UM'    , 'UN'             , Nil})
    aadd(aDados, {'B1_LOCPAD', '01'             , Nil})
    aadd(aDados, {'B1_GRUPO' , '01'             , Nil})

    // * Ordena os campos do array de acordo com ordenação dos campos da tabela
    FWVetByDic(aDados, 'SB1')

    MsExecAuto({|a, b| MATA010(a, b)}, aDados, 3)

    If lMsErroAuto
        cDir := '\x_logs\'
        cArquivo := 'erro_SB1_' + DToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.txt'

        If ! ExistDir(cDir)
            MakeDir(cDir)
        EndIf

        aLogErro := GetAutoGrLog()
        cTextoErro := ''

        For nLinha := 1 To Len(aLogErro)
            cTextoErro += aLogErro[nLinha] + CRLF
        Next nLinha

        MemoWrite(cDir + cArquivo, cTextoErro)

        FWAlertInfo('Erro: foi gerado um arquivo de log em: ' + cDir + cArquivo)
    Else 
        FWAlertSuccess('Produto incluído com sucesso', 'Atenção')
    EndIf

    RpcClearEnv()
    FWRestArea(aArea)
Return
