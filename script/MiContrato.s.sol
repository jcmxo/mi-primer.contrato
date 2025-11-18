// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/MiContrato.sol";

contract MiContratoScript is Script {
    function run() external {
        // Tomar la private key desde variable de entorno PRIVATE_KEY
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy del contrato con valor inicial 42
        MiContrato miContrato = new MiContrato(42);

        vm.stopBroadcast();

        console2.log("MiContrato desplegado en:", address(miContrato));
    }
}

