<html>
<head>
<title>Testes Clientes</title>
</head>
<body>
	<?php
		//Cria as variaveis usadas em branco
		$vendedor = '';
		$estado   = '';
		$cidade   = '';
		$ok       = false;
		$mensagem = '';
		$clientes = null;
		
		//Pega os dados que foram confirmados
		if (isset($_POST['vendedor'])) {
			$vendedor = $_POST['vendedor'];
			$ok = true;
		}
		if (isset($_POST['estado'])) {
			$estado = $_POST['estado'];
			$ok = true;
		}
		if (isset($_POST['cidade'])) {
			$cidade = $_POST['cidade'];
			$ok = true;
		}
		
		//Se algum parâmetro foi preenchido
		if ($ok) {
			//Tenta conectar com o WebService do Protheus
			try {
				$soapClient = new SoapClient('http://127.0.0.1:8050/ws/zWsCliente.apw?WSDL', ['exceptions' => true]);
			} catch (SoapFault $exception) {
				$mensagem = 'Houve um erro ao buscar os dados, <b>contate o Administrador</b>. Exception: <br>';
				$mensagem .= $exception->getMessage();
			}
			
			//Tenta executar o metodo que retorna a lista de clientes
			try {
				$requestData = array(
					"RETLISTCLI" => array(
						"CFILTRECE" => 
							'{'.
							'	"Dados": {'.
							'		"Vendedor":"' . $vendedor . '", '.
							'		"Estado":"'   . $estado   . '", '.
							'		"Cidade":"'   . $cidade   . '"  '.
							'	},'.
							'	"Token": "terminal@2019!tst123"'.
							'}'
						)
					);
				
				$response = $soapClient->__soapCall("RETLISTCLI", $requestData);
				
				$jsonLogin = json_decode($response->RETLISTCLIRESULT);
				if (json_last_error() == 0) {
					$clientes = $jsonLogin;
				}
				
			} catch (SoapFault $exception) {
				$mensagem = 'Houve um erro ao buscar os dados, <b>contate o Administrador</b>. Exception: <br>';
				$mensagem .= $exception->getMessage();
			}
			
		}
	?>
	
	<form action="clientes.php" method="post">
	Vendedor:<br>
	<input type="text" id="vendedor" name="vendedor" placeholder="Digite o código do Vendedor" maxlength="6" style="width: 200px;" value=<?php echo $vendedor;?>><br>
	
	Estado:<br>
	<select id="estado" name="estado">
		<option <?php if (empty($estado))  echo 'selected="selected"'; ?>></option>
		<option <?php if ($estado == "AC") echo 'selected="selected"'; ?>>AC</option>
		<option <?php if ($estado == "AL") echo 'selected="selected"'; ?>>AL</option>
		<option <?php if ($estado == "AP") echo 'selected="selected"'; ?>>AP</option>
		<option <?php if ($estado == "AM") echo 'selected="selected"'; ?>>AM</option>
		<option <?php if ($estado == "BA") echo 'selected="selected"'; ?>>BA</option>
		<option <?php if ($estado == "CE") echo 'selected="selected"'; ?>>CE</option>
		<option <?php if ($estado == "DF") echo 'selected="selected"'; ?>>DF</option>
		<option <?php if ($estado == "ES") echo 'selected="selected"'; ?>>ES</option>
		<option <?php if ($estado == "GO") echo 'selected="selected"'; ?>>GO</option>
		<option <?php if ($estado == "MA") echo 'selected="selected"'; ?>>MA</option>
		<option <?php if ($estado == "MT") echo 'selected="selected"'; ?>>MT</option>
		<option <?php if ($estado == "MS") echo 'selected="selected"'; ?>>MS</option>
		<option <?php if ($estado == "MG") echo 'selected="selected"'; ?>>MG</option>
		<option <?php if ($estado == "PA") echo 'selected="selected"'; ?>>PA</option>
		<option <?php if ($estado == "PB") echo 'selected="selected"'; ?>>PB</option>
		<option <?php if ($estado == "PR") echo 'selected="selected"'; ?>>PR</option>
		<option <?php if ($estado == "PE") echo 'selected="selected"'; ?>>PE</option>
		<option <?php if ($estado == "PI") echo 'selected="selected"'; ?>>PI</option>
		<option <?php if ($estado == "RJ") echo 'selected="selected"'; ?>>RJ</option>
		<option <?php if ($estado == "RN") echo 'selected="selected"'; ?>>RN</option>
		<option <?php if ($estado == "RS") echo 'selected="selected"'; ?>>RS</option>
		<option <?php if ($estado == "RO") echo 'selected="selected"'; ?>>RO</option>
		<option <?php if ($estado == "RR") echo 'selected="selected"'; ?>>RR</option>
		<option <?php if ($estado == "SC") echo 'selected="selected"'; ?>>SC</option>
		<option <?php if ($estado == "SP") echo 'selected="selected"'; ?>>SP</option>
		<option <?php if ($estado == "SE") echo 'selected="selected"'; ?>>SE</option>
		<option <?php if ($estado == "TO") echo 'selected="selected"'; ?>>TO</option>
	</select><br>
				  
	Cidade:<br>
	<input type="text" id="cidade" name="cidade" placeholder="Digite o nome da Cidade" maxlength="30" style="width: 200px;" value=<?php echo $cidade;?>><br>
	<br><br>
	<button type="submit">Confirmar</button>
	</form>
	<hr>
	Resultado(s):<br>
	<?php
		//Se existe mensagem de erro, mostra ela
		if (! empty($mensagem)) {
			echo '<font color="red">' . $mensagem . '</font><br>';
		}
	?>
	<br>
	<table border="2">
		<thead>
			<tr>
				<th><b>Código</b></th>
				<th><b>Razão Social</b></th>
				<th><b>Nome Fantasia</b></th>
				<th><b>CGC</b></th>
			</tr>
		</thead>
		<tbody>
			<?php
				if ($clientes != null) {
					foreach ($clientes->Clientes as $cli) {
						echo '<tr>';
						echo '	<td>' . $cli->Codigo        . '</td>';
						echo '	<td>' . $cli->RazaoSocial   . '</td>';
						echo '	<td>' . $cli->NomeFantasia  . '</td>';
						echo '	<td>' . $cli->CGC           . '</td>';
						echo '</tr>';
					}
				}
			?>
		</tbody>
	</table>
</body>
</html>