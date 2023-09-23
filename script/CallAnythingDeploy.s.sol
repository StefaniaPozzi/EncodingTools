//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {CallAnything} from "../src/CallAnything.sol";

contract CallAnythingDeploy is Script {
    function run() external returns (CallAnything) {
        return new CallAnything();
    }
}
