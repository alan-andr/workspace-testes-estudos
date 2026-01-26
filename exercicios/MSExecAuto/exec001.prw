#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EXEC001()
    Local aArea := FWGetArea()
    Local aPergs := {}
    Local aDados := {}

    RpcSetEnv('99', '01')

    Local cCodProd  := Space( TamSX3( 'B1_COD' )[1] )
    Local cDescProd := Space( TamSX3( 'B1_DESC' )[1] )
    Local cTipoProd := Space( TamSX3( 'B1_TIPO' )[1] )
    Local cUniProd  := Space( TamSX3( 'B1_UM' )[1] )
    Local cArmProd  := Space( TamSX3( 'B1_LOCPAD' )[1] )
    Local cGrpProd  := Space( TamSX3( 'B1_GRUPO' )[1] )
    Private lMsErroAuto := .F.

    aAdd(aPergs, {1, 'Produto'  , cCodProd , '', '.T.', ''   , '.T.', 070, .T.})
    aAdd(aPergs, {1, 'Descrição', cDescProd, '', '.T.', ''   , '.T.', 100, .T.})
    aAdd(aPergs, {1, 'Tipo'     , cTipoProd, '', '.T.', '02' , '.T.', 040, .T.})
    aAdd(aPergs, {1, 'U.M'      , cUniProd , '', '.T.', 'SAH', '.T.', 040, .T.})
    aAdd(aPergs, {1, 'Armazém'  , cArmProd , '', '.T.', 'NNR', '.T.', 040, .T.})
    aAdd(aPergs, {1, 'Grupo'    , cGrpProd , '', '.T.', 'SBM', '.T.', 060, .T.})

    If ParamBox(aPergs, 'Informe os parâmetros', , , , , , , ,)
        aAdd(aDados, {'B1_COD'   , MV_PAR01, Nil})
        aAdd(aDados, {'B1_DESC'  , MV_PAR02, Nil})
        aAdd(aDados, {'B1_TIPO'  , MV_PAR03, Nil})
        aAdd(aDados, {'B1_UM'    , MV_PAR04, Nil})
        aAdd(aDados, {'B1_LOCPAD', MV_PAR05, Nil})
        aAdd(aDados, {'B1_GRUPO' , MV_PAR06, Nil})

        MsExecAuto( {|x, y| MATA010(x, y)}, aDados, 3 )

        If lMsErroAuto
            MostraErro()
        Else
            FWAlertSuccess('Produto: ' + SB1->B1_COD + ' incluído com sucesso.', 'Atenção')
        EndIf
    EndIf

    RpcClearEnv()
    FWRestArea(aArea)
Return
