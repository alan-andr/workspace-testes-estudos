#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EXEC004()
    Local aArea         
    Local aDados        := {}
    Private aRotina    
    Private oModel      
    Private lMsErroAuto := .F.

    RpcSetEnv('99', '01')

    aArea := FWGetArea()
    aRotina := FWLoadMenuDef('MATA020')
    oModel := FWLoadModel('MATA020')

    aadd(aDados, {'A2_COD'    , 'F00005'        , Nil})
    aadd(aDados, {'A2_LOJA'   , '01'            , Nil})
    aadd(aDados, {'A2_NOME'   , 'Teste'         , Nil})
    aadd(aDados, {'A2_NREDUZ' , 'Tst'           , Nil})
    aadd(aDados, {'A2_TIPO'   , 'F'             , Nil})
    aadd(aDados, {'A2_END'    , 'Rua dos Testes', Nil})
    aadd(aDados, {'A2_EST'    , 'SP'            , Nil})
    aadd(aDados, {'A2_COD_MUN', '06003'         , Nil})
    aadd(aDados, {'A2_HPAGE'  , 'tst.com'       , Nil})
    aadd(aDados, {'A2_EMAIL'  , 'teste@tst.com' , Nil})
    aadd(aDados, {'A2_NATUREZ', 'TESTE'         , Nil})

    lMsErroAuto := .F.

    FWMVCRotAuto(;
        oModel,;                    // * Modelo
        'SA2' ,;                    // * Alias
        3,;    // * Operação
        {{ 'SA2MASTER' , aDados}};  // * Dados
       )

    If lMsErroAuto
        MostraErro()
    Else
        FWAlertSuccess('Registro incluído', 'Atenção')
    EndIf

    RpcClearEnv()
    FWRestArea(aArea)
Return 
