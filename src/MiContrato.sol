// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title MiContrato - Guarda un número y el dueño que lo puede actualizar
contract MiContrato {
    address public owner;
    uint256 public value;

    event ValueChanged(uint256 oldValue, uint256 newValue);

    constructor(uint256 _initialValue) {
        owner = msg.sender;
        value = _initialValue;
        emit ValueChanged(0, _initialValue);
    }

    /// @notice Cambia el valor, solo el dueño puede hacerlo
    function setValue(uint256 _newValue) external {
        require(msg.sender == owner, "Solo el dueno puede cambiar");
        uint256 old = value;
        value = _newValue;
        emit ValueChanged(old, _newValue);
    }
}

