#Include 'protheus.ch'
#Include 'totvs.ch'
#Include 'TOPCONN.ch'

User Function TCQRY01()
    Local aArea := FWGetArea()

    RpcSetEnv('99', '01')

    cQrySB1 := " SELECT * " + CRLF
    cQrySB1 += " FROM " + RetSqlName('SB1') + " SB1" + CRLF
    cQrySB1 += " WHERE SB1.B1_COD != ' ' "

    TCQuery cQrySB1 New Alias QRY_SB1

    While ! QRY_SB1->( EoF() )
        ConOut("Codigo: " + AllTrim(QRY_SB1->B1_COD) + " Descricao: " + AllTrim(QRY_SB1->B1_DESC))

        QRY_SB1->( DbSkip() )
    EndDo

    QRY_SB1->( DbCloseArea() )

    RpcClearEnv()

    FWRestArea(aArea)
Return
