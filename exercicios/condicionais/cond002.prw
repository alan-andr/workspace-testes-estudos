#Include 'totvs.ch'
#Include 'protheus.ch'

User Function COND002()
    Local aCarteira := {}
    Local aCliVip := {}
    Local nX := 0    

    aAdd(aCarteira, {"Supermercado Preço Bom", 12500.00})
    aAdd(aCarteira, {"Padaria da Esquina", 1200.00})
    aAdd(aCarteira, {"Indústria Metalúrgica", 45000.00})
    aAdd(aCarteira, {"Escola Aprender", 3200.00})
    aAdd(aCarteira, {"Tech Solutions", 8900.00})

    For nX := 1 To Len( aCarteira )

        If aCarteira[nX, 2] >= 5000

            aAdd( aCliVip, aCarteira[nX, 1] )
            
        EndIf

    Next nX

    Alert( "Total de Clientes VIP encontrados: " + cValToChar( Len( aCliVip ) ) )
Return
