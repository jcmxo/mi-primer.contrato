// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function run() public {
        vm.startBroadcast();

        Counter counter = new Counter();
        
        console.log("Counter deployed at:", address(counter));
        console.log("Initial number:", counter.number());

        vm.stopBroadcast();
    }
}
