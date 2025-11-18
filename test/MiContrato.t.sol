// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MiContrato.sol";

contract MiContratoTest is Test {
    MiContrato miContrato;
    address owner = address(0xABCD);
    address atacante = address(0xBEEF);

    function setUp() public {
        // Simulamos que el deploy lo hace "owner"
        vm.prank(owner);
        miContrato = new MiContrato(42);
    }

    function testValorInicial() public {
        assertEq(miContrato.value(), 42);
        assertEq(miContrato.owner(), owner);
    }

    function testSoloDuenoPuedeCambiar() public {
        vm.prank(atacante);
        vm.expectRevert(bytes("Solo el dueno puede cambiar"));
        miContrato.setValue(100);
    }

    function testDuenoCambiaValor() public {
        vm.prank(owner);
        miContrato.setValue(100);
        assertEq(miContrato.value(), 100);
    }
}

