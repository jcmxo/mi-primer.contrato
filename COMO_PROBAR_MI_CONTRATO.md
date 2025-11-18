# Cómo Probar MiContrato

Esta guía te muestra paso a paso cómo compilar, testear y desplegar el contrato `MiContrato` usando Foundry.

## Requisitos Previos

- Foundry instalado (`forge`, `anvil`, `cast`)
- WSL con Ubuntu funcionando

## 1. Compilar el Contrato

```bash
forge build
```

Este comando compila todos los contratos en `src/` y genera los archivos de salida en `out/`.

## 2. Ejecutar los Tests

```bash
# Tests básicos
forge test

# Tests con más detalles (recomendado)
forge test -vv

# Tests con máximo detalle (ver todas las llamadas)
forge test -vvv

# Tests con reporte de gas
forge test --gas-report
```

Los tests verifican:
- ✅ Que el valor inicial se establece correctamente
- ✅ Que el owner se asigna correctamente
- ✅ Que solo el owner puede cambiar el valor
- ✅ Que el owner puede cambiar el valor exitosamente

## 3. Probar en Anvil (Blockchain Local)

### Paso 1: Iniciar Anvil

En una terminal, ejecuta:

```bash
anvil
```

Anvil iniciará una blockchain local en `http://127.0.0.1:8545` y mostrará 10 cuentas con fondos. Verás algo como:

```
Available Accounts
==================
(0) 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
...
```

### Paso 2: Exportar la Private Key

En otra terminal (o en la misma después de detener Anvil), exporta la private key de una de las cuentas:

```bash
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

**Nota:** Reemplaza la private key con una de las que muestra Anvil. La primera cuenta (índice 0) es la más común.

### Paso 3: Desplegar el Contrato

Con Anvil corriendo y la variable `PRIVATE_KEY` exportada, ejecuta:

```bash
forge script script/MiContrato.s.sol:MiContratoScript \
  --rpc-url http://127.0.0.1:8545 \
  --broadcast
```

El script mostrará la dirección del contrato desplegado, algo como:

```
MiContrato desplegado en: 0x5FbDB2315678afecb367f032d93F642f64180aa3
```

**Guarda esta dirección** para interactuar con el contrato.

## 4. Interactuar con el Contrato usando Cast

### Leer el Valor Actual

```bash
cast call <DIRECCION> "value()(uint256)" --rpc-url http://127.0.0.1:8545
```

Reemplaza `<DIRECCION>` con la dirección del contrato que obtuviste en el paso anterior.

**Ejemplo:**
```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "value()(uint256)" --rpc-url http://127.0.0.1:8545
```

Deberías ver `42` (el valor inicial).

### Leer el Owner

```bash
cast call <DIRECCION> "owner()(address)" --rpc-url http://127.0.0.1:8545
```

### Cambiar el Valor

Solo el owner puede cambiar el valor. Usa la misma private key que usaste para el deploy:

```bash
cast send <DIRECCION> "setValue(uint256)" 123 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key $PRIVATE_KEY
```

**Ejemplo:**
```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "setValue(uint256)" 123 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key $PRIVATE_KEY
```

### Verificar el Nuevo Valor

```bash
cast call <DIRECCION> "value()(uint256)" --rpc-url http://127.0.0.1:8545
```

Ahora deberías ver `123` (o el valor que hayas establecido).

## 5. Probar que Solo el Owner Puede Cambiar el Valor

Intenta cambiar el valor usando una private key diferente (de otra cuenta de Anvil):

```bash
# Primero, exporta una private key diferente
export PRIVATE_KEY_ATACANTE=0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d

# Intenta cambiar el valor (debería fallar)
cast send <DIRECCION> "setValue(uint256)" 999 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key $PRIVATE_KEY_ATACANTE
```

Deberías ver un error indicando que la transacción fue revertida con el mensaje "Solo el dueno puede cambiar".

## 6. Ver Eventos

Para ver los eventos emitidos por el contrato, puedes usar:

```bash
cast logs --rpc-url http://127.0.0.1:8545
```

O revisar los logs en Anvil cuando ejecutas transacciones.

## Comandos Útiles Adicionales

```bash
# Ver el tamaño del contrato compilado
forge build --sizes

# Formatear el código
forge fmt

# Ver el gas usado en los tests
forge snapshot

# Limpiar archivos compilados
forge clean

# Ver información de una cuenta en Anvil
cast balance <DIRECCION> --rpc-url http://127.0.0.1:8545
```

## Solución de Problemas

### Error: "PRIVATE_KEY not set"
Asegúrate de haber exportado la variable de entorno:
```bash
export PRIVATE_KEY=0x...
```

### Error: "Connection refused"
Verifica que Anvil esté corriendo en `http://127.0.0.1:8545`.

### Error: "Insufficient funds"
Usa una de las cuentas que Anvil muestra, todas tienen 10000 ETH.

### Error: "execution reverted"
Si intentas cambiar el valor con una cuenta que no es el owner, verás este error. Es el comportamiento esperado.

## Próximos Pasos

- Desplegar a una red de prueba (Sepolia, Mumbai, etc.)
- Interactuar con el contrato desde una dApp
- Agregar más funcionalidades al contrato
- Escribir más tests (fuzz testing, invariant testing)

