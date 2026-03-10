#Include 'protheus.ch'
#Include 'totvs.ch'

User Function VERIFPROD()
    Local aArea := FWGetArea()
    Local cNomeProd := ''
    Local cCodProd := ''

    BeginSQL Alias 'TEMPSB1'

        SELECT 
            sb1.B1_DESC,
            sb1.B1_COD
        FROM 
            %Table:SB1% AS sb1
        WHERE
            sb1.B1_UM = ' '
        AND
            sb1.D_E_L_E_T_ = ' '

    EndSQL

    // Mostrará no console somente produtos que estão sem Unidade de Medidas cadastradas
    While ! TEMPSB1->( EoF() )
        cNomeProd := AllTrim( TEMPSB1->B1_DESC )
        cCodProd := AllTrim( TEMPSB1->B1_COD )

        ConOut('<<<<<<<<<<< Codigo do produto: ' + cCodProd + '>>>>>>>>>>>')
        ConOut('==========================================================')
        ConOut('<<<<<<<<<<< Nome do produto: ' + cNomeProd + '>>>>>>>>>>>')

        TEMPSB1->( DbSkip() )
    EndDo

    TEMPSB1->( DbCloseArea() )

    FWRestArea(aArea)

Return
