#Include "Protheus.ch"
#Include "Totvs.ch"
#Include "Topconn.ch"

Static aSalConsPC := {} // Pedidos de compras que já foram consumidos
Static nUltExec   := 0 // Tempo em segundos da última execução 

User Function A140IVPED()
  Local aArea      := FWGetArea()
  Local cCodFornec := ParamIxb[1] //Código do fornecedor
  local cLoja      := ParamIxb[2] //Loja do fornecedor
  Local cCodProd   := ParamIxb[3] //Código do produto
  Local nQtdProd   := ParamIxb[4] //Quantidade do produto
  Local lValida    := .T. //.T. para validar a quantidade do pedido de compra superior ao XML ou .F. para nao validar a quantidade do pedido de compra superior ao XML
  Local aRet       := {}
  Local nSaldoXML  := nQtdProd
  Local nPosPC     := 0
  Local nSaldoPC   := 0
  Local nSaldoVinc := 0
  Local nPrecoXML  := SDT->DT_VUNIT
  Local nPrecoPC   := 0
  Local nTempLimit := SuperGetMv("MV_TLMT", .F., 30) // Segundos
  Local cNumPC     := ""
  Local cItemPC    := ""
  Local cFilEntPC  := ""
  Local cQRYVINCPC := ""
  Local lPcExato   := .F.

  If Seconds() < nUltExec .OR. (Seconds() - nUltExec) > nTempLimit
    aSalConsPC := {}
  EndIf
  nUltExec := Seconds()

  cQRYVINCPC := fBuscaPCs(cCodFornec, cLoja, cCodProd)
  While ! (cQRYVINCPC)->(Eof())
    nPosPC   := aScan(aSalConsPC, {|x| x[1] == AllTrim((cQRYVINCPC)->NUMPED) .AND. x[2] == AllTrim((cQRYVINCPC)->ITEMPED)}) // Busca se este pedido já foi consumido em memória nas linhas anteriores
    nSaldoPC := (cQRYVINCPC)->QUANTPED
    nPrecoItem := (cQRYVINCPC)->PRECOPED
    
    If nPosPC > 0
      nSaldoPC -= aSalConsPC[nPosPC, 3]
    EndIf

    // Saldo Exato
    If nSaldoPC == nSaldoXML .AND. nPrecoPC == nPrecoXML
      cNumPC     := (cQRYVINCPC)->NUMPED
      cItemPC    := (cQRYVINCPC)->ITEMPED
      cFilEntPC  := (cQRYVINCPC)->FILENTPED
      nSaldoVinc := nSaldoXML
      lPcExato   := .T.
      Exit
    EndIf

    // Caso não tenha item do pedido com saldo exato, consome outro qualquer
    // If ! lPcExato .AND. nSaldoPC > 0 .AND. Empty(cNumPC)
    //   cNumPC     := (cQRYVINCPC)->NUMPED
    //   cItemPC    := (cQRYVINCPC)->ITEMPED
    //   cFilEntPC  := (cQRYVINCPC)->FILENTPED
    //   nSaldoVinc := nSaldoXML
    // EndIf

    (cQRYVINCPC)->(DbSkip())
  EndDo
  (cQRYVINCPC)->(DbCloseArea())

  // Se encontrou um pedido válido exato ou maior que zero, faz a amarração
  If ! Empty(cNumPC)
    nPosPC := aScan(aSalConsPC, {|x| x[1] == AllTrim(cNumPC) .AND. x[2] == AllTrim(cItemPC)})
    
    // Alimenta a memória para o próximo item do XML pular ou abater esse saldo
    If nPosPC > 0
      aSalConsPC[nPosPC, 3] += nSaldoVinc
    Else 
      aAdd(aSalConsPC, {AllTrim(cNumPC), AllTrim(cItemPC), nSaldoVinc})
    EndIf

    Aadd(aRet, {cNumPC, cItemPC, nSaldoVinc, lValida, cFilEntPC})
  EndIf

  FWRestArea(aArea)
Return aRet

Static Function fBuscaPCs(cCodFornec, cLoja, cCodProd)
  Local aArea    := FWGetArea()
  Local cAliasPC := GetNextAlias()

  BEGINSQL ALIAS cAliasPC
  SELECT
    SC7.C7_NUM    AS NUMPED,
    SC7.C7_ITEM   AS ITEMPED,
    SC7.C7_PRECO  AS PRECOPED,
    (SC7.C7_QUANT - SC7.C7_QUJE) AS QUANTPED,
    SC7.C7_FILENT AS FILENTPED
  FROM
    %Table:SC7% SC7
  WHERE
    SC7.%NotDel%
    AND SC7.C7_FORNECE = %Exp:cCodFornec%
    AND SC7.C7_LOJA    = %Exp:cLoja%
    AND SC7.C7_PRODUTO = %Exp:cCodProd%
    AND SC7.C7_QUANT > SC7.C7_QUJE
    AND SC7.C7_ENCER != 'E'
    AND SC7.C7_FILIAL =  %xFilial:SC7%
  ORDER BY
    SC7.C7_DATPRF, SC7.C7_NUM, SC7.C7_ITEM ASC
ENDSQL

  FWRestArea(aArea)
Return cAliasPC
