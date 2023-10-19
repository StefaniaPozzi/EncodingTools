//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {BOXV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract BoxDeploy is Script {
    function run() external returns (address) {
        address proxy = deploy();
        return proxy;
    }

    function deploy() public returns (address) {
        vm.startBroadcast();
        BOXV1 box = new BOXV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        vm.stopBroadcast();
        return address(proxy);
    }
}
