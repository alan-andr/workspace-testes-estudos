#include 'totvs.ch'

User Function zTeste()
    Private cTitulo := 'Nome'
    Private cNome := 'Alan'

    MsgInfo(cNome)
    zTeste1()
Return

Static Function zTeste1
    Local fMensagem 
    
    fMensagem := MsgInfo(cNome, cTitulo)
Return fMensagem

