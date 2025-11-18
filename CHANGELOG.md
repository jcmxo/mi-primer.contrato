# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [Unreleased]

### Agregado
- Sección de Changelog en la interfaz web para visualizar los cambios del proyecto
- Archivo CHANGELOG.md para documentar el historial de cambios

## [1.0.0] - 2025-01-23

### Agregado
- Interfaz HTML (`anvil-interface.html`) para interactuar con Anvil desde el navegador
- Métodos RPC disponibles en la interfaz:
  - `eth_blockNumber` - Obtener número de bloque actual
  - `eth_accounts` - Listar cuentas disponibles
  - `eth_getBalance` - Consultar balance de una cuenta
  - `eth_getTransactionCount` - Obtener nonce de transacciones
  - Método personalizado para ejecutar cualquier método JSON-RPC
- Script de publicación a GitHub (`publish-to-github.sh`)
- Documentación mejorada en README.md
- Guías de prueba: `COMO_PROBAR.md` y `COMO_PROBAR_MI_CONTRATO.md`

### Características
- Diseño moderno con gradiente púrpura
- Manejo de errores con mensajes claros
- Conversión automática de valores hex a decimal
- Conversión de balances de Wei a ETH
- Indicadores de carga visual

## [0.1.0] - 2025-01-23

### Agregado
- Proyecto inicial con Foundry
- Contrato `MiContrato.sol` - Almacena un valor con control de acceso
- Contrato `Counter.sol` - Contador simple con funciones increment y setNumber
- Scripts de despliegue para ambos contratos
- Tests para los contratos
- Configuración de Foundry (`foundry.toml`)

---

## Notas

- Las versiones se basan en los commits principales del proyecto
- Los cambios se documentan en orden cronológico inverso (más recientes primero)

