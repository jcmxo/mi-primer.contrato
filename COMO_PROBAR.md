# Cómo Probar el Contrato Counter

## 1. Tests Unitarios

Ejecuta los tests con diferentes niveles de detalle:

```bash
# Tests básicos
forge test

# Tests con más detalles
forge test -vv

# Tests con máximo detalle (ver todas las llamadas)
forge test -vvv

# Tests con información de gas
forge test --gas-report
```

## 2. Probar en Anvil (Red Local)

### Paso 1: Inicia Anvil en una terminal
```bash
anvil
```

Esto iniciará una blockchain local en `http://127.0.0.1:8545` con 10 cuentas pre-fundadas.

### Paso 2: Despliega el contrato (en otra terminal)
```bash
forge script script/Counter.s.sol:CounterScript --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
```

### Paso 3: Interactúa con el contrato usando Cast

Una vez desplegado, obtendrás la dirección del contrato. Usa esa dirección para:

```bash
# Leer el número actual
cast call <DIRECCION_CONTRATO> "number()" --rpc-url http://localhost:8545

# Establecer un número (necesitas la dirección del contrato)
cast send <DIRECCION_CONTRATO> "setNumber(uint256)" 42 --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Incrementar el contador
cast send <DIRECCION_CONTRATO> "increment()" --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Verificar el nuevo valor
cast call <DIRECCION_CONTRATO> "number()" --rpc-url http://localhost:8545
```

## 3. Probar en una Red de Prueba (Sepolia, etc.)

### Desplegar a Sepolia
```bash
forge script script/Counter.s.sol:CounterScript \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

## 4. Ver el Código del Contrato Desplegado

Si desplegaste a una red pública, puedes ver el contrato en:
- Etherscan (Ethereum): https://sepolia.etherscan.io/address/<DIRECCION>
- O el explorador correspondiente a la red que usaste

## 5. Comandos Útiles

```bash
# Ver el tamaño del contrato
forge build --sizes

# Formatear el código
forge fmt

# Ver el gas usado
forge snapshot

# Compilar
forge build

# Limpiar archivos compilados
forge clean
```

