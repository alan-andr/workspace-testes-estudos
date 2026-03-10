#Include "totvs.ch"
#Include "protheus.ch"
#Include "topconn.ch"

User Function zMulti04()
    Local aArea := {}
    Local lContinua := .F.
    Private lJobPvt := .F.

    // * Se o ambiente não estiver em pé, sobe para usar de maneira automática
    If Select("SX2") == 0
        lJobPvt := .T.
        lContinua := .T.
        RpcSetEnv("99", "01", "", "", "", "")

    // * Senão, mostra uma pergunta para realmente conformar se deseja executar
    Else
        lContinua := FWAlertYesNo("Deseja executar o processo MultiThreading?", "Continua?")
    EndIf

    aArea := FWGetArea()

    // * Se tiver ok, vai acionar o processamento
    If lContinua 
        Processa({|| fProcDad()}, "Processando...")
    EndIf

    FWRestArea(aArea)
Return

Static Function fProcDad()
    Local aArea      := FWGetArea()
    Local cQueryFila := ""
    Local cFilaAtual := "001"
    Local cArqLog    := "\x_logs\" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + "_forn_principal.log"
    Local cMensagem  := ""
    Local aArquivos  := {}
    Local nTotal     := 0
    Local nAtual     := 0

    // * Atualiza as expressões públicas em memória
    PutGlbValue("cXLogsPeds", cArqLog + ";")

    // * Será buscado todos os fornecedores, que não tiveram compras no último ano e que o campo de fila esteja
    cQueryFila := " SELECT " + CRLF
    cQueryFila += "     SA2.R_E_C_N_O_ AS SA2REC " + CRLF
    cQueryFila += " FROM " + CRLF
    cQueryFila += "     " + RetSqlName("SA2") + " SA2 " + CRLF
    cQueryFila += " WHERE " + CRLF
    cQueryFila += "     A2_FILIAL = '" + FWxFilial("SA2") + "' " + CRLF
    cQueryFila += "     AND (A2_ULTCOM = '' OR A2_ULTCOM <= '" + dToS(YearSub(Date(), 1)) + "') " + CRLF
    cQueryFila += "     AND A2_MSBLQ != '1' AND A2_X_FILA = '' " + CRLF
    cQueryFila += "     AND SA2.D_E_L_E_T_ = ' ' " + CRLF

    TCQuery cQueryFila New Alias "QRY_FILA"

    // * Define o tamanho da régua
    Count To nTotal
    ProcRegua(nTotal)
    QRY_FILA->(DbGoTop())
    fAtuLog(cArqLog, "[Principal][" + Time() + "] Exise(m) " + cValToChar(nTotal) + " registro(s)")

    // * Percorre os dados da query
    While ! QRY_FILA->(EoF())
        // * Incrementa a régua
        nAtual++
        IncProc("Analisando fornecedor " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        // * Posiciona no fornecedor atual
        DbSelectArea("SA2")
        SA2->(DbGoTo(QRY_FILA->SA2REC))
        fAtuLog(cArqLog, "[Principal][" + Time() + "] Definindo fornecedor '" + SA2->A2_COD + "' para a fila '" + cFilAtual + "'")

        // * Atualiza o cmapo de fila
        If RecLock("SA2", .F.)
            SA2->A2_X_FILA := cFilaAtual
            SA2->(MsUnlock())
        EndIf

        // * Incrementa a fila atual
        cFilaAtual := Soma1(cFilaAtual)

        // * Se a fila atingiu 4, volta para 1
        If cFilaAtual == "004"
            cFilaAtual := "001"
        EndIf

        QRY_FILA->(DbSkip())
    EndDo
    QRY_FILA->(DbCloseArea())

    // * Mostra a mensagem e zera a expressão pública em memória
    aArquivos := Separa(GetGlbValue("cXLogsPeds"), ";")
    For nAtual := 1 To Len(aArquivos)
        cArqLog := aArquivos[nAtual]
        If !Empty(cArqLog) .AND. File(cArqLog)
            cMensagem += cArqLog + ": " + CRLF + CRLF
            cMensagem += MemoRead(aArquivos[nAtual]) + CRLF
            cMensagem += "--" + CRLF
        EndIf
    Next nAtual
    ShowLog(cMensagem)
    PutGlbValue("cXLogsFods", "")

    // * Volta a variável
    cFilaAtual := "001"

    // * Aciona o processamento da fila
    While .T.
        // * Busca fornecedores que ainda não foram bloquedos e tem o campo de fila preenchido
        cQueryFila := " SELECT " + CRLF
        cQueryFila += "     COUNT(A2_COD) AS TOT_REGS " + CRLF
        cQueryFila += " FROM " + CRLF
        cQueryFila += "     " + RetSqlName("SA2") + " SA2 " + CRLF
        cQueryFila += " WHERE " + CRLF
        cQueryFila += "     A2_FILIAL = '" + FWxFilial("SA2") + "' " + CRLF
        cQueryFila += "     AND (A2_ULTCOM = '' OR A2_ULTCOM <= '" + dToS(YearSub(Date(), 1)) + "') " + CRLF
        cQueryFila += "     AND A2_MSBLQ != '1' AND A2_X_FILA != '' " + CRLF
        cQueryFila += "     AND SA2.D_E_L_E_T_ = ' ' " + CRLF

        If ! QRY_FILA->(EoF()) .AND. QRY_FILA->TOT_REGS == 0
            lEncerra := .T.
        EndIf
        QRY_FILA->(DbCloseArea())

        // * Se for encerrar , finaliza o laço
        If lEncerra
            Exit
        EndIf

        // * Se conseguir travar, quer dizer que algum usuário já está executando
        If ! LockByName("zMulti06_lock_fila_" + cFilaAtual, .T., .F.) 

            // * Aciona a função que vai bloquear os fornecedores
            StartJob("u_zFila05", GetEnvServer(), .F., cEmpAnt, cFilAnt, cFilaAtual)

        EndIf

        // * Espera 8 segundos
        Sleep(8000)

        // * Se a fila atingiu 4, reseta
        If cFilaAtual == "004"
            cFilAtual := "000"
        EndIf

        cFilaAtual := Soma1(cFilaAtual)
    EndDo

    FWAlertSuccess("Processo finalizado", "Sucesso")

    FWRestArea(aArea)
Return 

User Function zFila05(cParEmp, cParFil, cParFila)
    Local aArea
    Local cQueryFila := ""

    // * Abaixo o usuário e senha que serão usados para realizar a alteração
    // * O ideal aqui é encapsular essa senha em um parâmetro ou txt, para não deixar chumbado no fonte
    // * Deixar chumbado é uma péssima prática
    // * Aqui poderia ser algo como MemoRead(), GetMV() não daria pois precisa carregar o dicionário primeiro, a não ser que você passe 
    // * o parâmetro direto na chamada da user function, por exemplo, cParPass ali após dParvencto
    Local cArqConf := MemoRead("c:\temp\x_config\autoarmazem")
    Local cTxt     := Decode64(cArqConf)
    Local aUsuario := StrTokArr(cTxt, "|")
    Local cUsuario := aUsuario[1]
    Local cPass    := aUsuario[2]
    Local cArqLog  := "\x_logs\" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + "_fila_" + cParFila + ".log"

    If Select("Sx2") == 0
        RpcSetEnv(cParEmp, cParFil, cUsuario, cPass, "FAT")
    EndIf

    aArea := FWGetArea()

    // * Atualiza as expressões públicas em memória
    PutGlbValue("cXLogsPeds", GetGlbValue("cXLogsPeds") + cArqLog + ";")

    // * Busca todos os fornecedores da fila atual
    cQueryFila := " SELECT " + CRLF
    cQueryFila += "     SA2.R_E_C_N_O_ AS SA2REC " + CRLF
    cQueryFila += " FROM " + CRLF
    cQueryFila += "     " + RetSqlName("SA2") + " SA2 " + CRLF
    cQueryFila += " WHERE " + CRLF
    cQueryFila += "     A2_FILIAL = '" + FWxFilial("SA2") + "' " + CRLF
    cQueryFila += "     AND (A2_ULTCOM = '' OR A2_ULTCOM <= '" + dToS(YearSub(Date(), 1)) + "') " + CRLF
    cQueryFila += "     AND A2_MSBLQ != '1' AND A2_X_FILA = '' " + CRLF
    cQueryFila += "     AND SA2.D_E_L_E_T_ = ' ' " + CRLF
    TCQuery cQueryFila New Alias "QRY_FILA"

    // * Enquanto houver dados
    While ! QRY_FILA->(EoF())
         // * Posiciona no registro
        DbSelectArea("SA2")
        SA2->(DbGoTo(QRY_FILA->SA2REC))

        // * Limpa a flag
        RecLock("SA2", .F.)
            SA2->A2_X_FILA := ""
        SA2->(MsUnlock())

        QRY_FILA->(DbSkip())
    EndDo
    QRY_FILA->(DbCloseArea())

    // * Aciona o destravamento do lock
    UnlockByName("zMulti06_lock_fila_" + cParFila, .T., .F.)

    FWRestArea(aArea)
Return aRet

Static Function fAtuLog(cArquiLog, cMensagem)
    Local cConteudo := ""

    // * Recupera a mensagem original, incrementa  e grava novamente
    If File(cArquiLog)
        cConteudo := MemoRead(cArquiLog)
        cConteudo += CRLF
    EndIf

    cConteudo += cMensagem
    MemoWrite(cArquiLog, cConteudo)
Return
