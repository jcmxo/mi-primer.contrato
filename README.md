# Mi Primer Contrato

Proyecto de aprendizaje de desarrollo de contratos inteligentes con Foundry. Este repositorio contiene ejemplos de contratos Solidity y herramientas para interactuar con ellos.

## 📋 Contratos Incluidos

### MiContrato
Contrato que almacena un valor numérico y permite solo al propietario modificarlo.

**Características:**
- Almacena un valor `uint256`
- Control de acceso: solo el owner puede cambiar el valor
- Emite eventos cuando el valor cambia

### Counter
Contrato contador simple que permite incrementar y establecer un número.

**Características:**
- Función `increment()` para aumentar el contador
- Función `setNumber()` para establecer un valor específico

## 🚀 Inicio Rápido

### Prerrequisitos

- [Foundry](https://book.getfoundry.sh/getting-started/installation) instalado
- Git

### Instalación

```bash
# Clonar el repositorio
git clone https://github.com/TU_USUARIO/mi-primer-contrato.git
cd mi-primer-contrato

# Instalar dependencias (si las hay)
forge install
```

### Compilar

```bash
forge build
```

### Ejecutar Tests

```bash
# Tests básicos
forge test

# Tests con más detalles
forge test -vv

# Tests con máximo detalle
forge test -vvv

# Tests con reporte de gas
forge test --gas-report
```

## 🧪 Probar en Anvil (Red Local)

### 1. Iniciar Anvil

```bash
anvil
```

Esto iniciará una blockchain local en `http://127.0.0.1:8545` con 10 cuentas pre-fundadas.

### 2. Desplegar el Contrato

En otra terminal:

```bash
# Para MiContrato
forge script script/MiContrato.s.sol:MiContratoScript \
  --rpc-url http://127.0.0.1:8545 \
  --broadcast

# Para Counter
forge script script/Counter.s.sol:CounterScript \
  --rpc-url http://127.0.0.1:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --broadcast
```

### 3. Interactuar con el Contrato

Usa `cast` para interactuar con los contratos desplegados:

```bash
# Leer el valor de MiContrato
cast call <DIRECCION> "value()(uint256)" --rpc-url http://127.0.0.1:8545

# Cambiar el valor (solo owner)
cast send <DIRECCION> "setValue(uint256)" 42 \
  --rpc-url http://127.0.0.1:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## 🌐 Interfaz Web para Anvil

Este proyecto incluye una interfaz HTML para interactuar con Anvil desde el navegador.

### Usar la Interfaz

1. Asegúrate de que Anvil esté corriendo en `http://127.0.0.1:8545`
2. Abre `anvil-interface.html` en tu navegador
3. Usa los botones para ejecutar métodos JSON-RPC comunes

**Características:**
- Ver número de bloque actual
- Listar cuentas disponibles
- Consultar balances
- Obtener nonces de transacciones
- Ejecutar métodos JSON-RPC personalizados

## 📚 Documentación

- [Cómo Probar MiContrato](COMO_PROBAR_MI_CONTRATO.md) - Guía detallada paso a paso
- [Cómo Probar Counter](COMO_PROBAR.md) - Guía para el contrato Counter
- [Foundry Book](https://book.getfoundry.sh/) - Documentación oficial de Foundry

## 🛠️ Comandos Útiles

```bash
# Formatear código
forge fmt

# Ver tamaño de contratos
forge build --sizes

# Limpiar archivos compilados
forge clean

# Ver balance de una cuenta en Anvil
cast balance <DIRECCION> --rpc-url http://127.0.0.1:8545

# Ver número de bloque
cast block-number --rpc-url http://127.0.0.1:8545
```

## 📝 Estructura del Proyecto

```
mi-primer-contrato/
├── src/              # Contratos Solidity
│   ├── MiContrato.sol
│   └── Counter.sol
├── script/           # Scripts de despliegue
│   ├── MiContrato.s.sol
│   └── Counter.s.sol
├── test/             # Tests
├── anvil-interface.html  # Interfaz web para Anvil
└── foundry.toml      # Configuración de Foundry
```

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para más detalles.

## 🔗 Recursos

- [Foundry Documentation](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Ethereum.org](https://ethereum.org/)

---

**Nota:** Este es un proyecto de aprendizaje. No uses las claves privadas de ejemplo en producción.
