//SPDX-License-Indentifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BOXV1} from "../src/BoxV1.sol";
import {BOXV2} from "../src/BOXV2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxUpgrade is Script {
    function run() external returns (address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
        vm.startBroadcast();
        BOXV2 box2 = new BOXV2();
        address proxy = upgrade(mostRecentlyDeployedProxy, address(box2));
        vm.stopBroadcast();
        return proxy;
    }

    function upgrade(address proxy, address contractToBeUpgradedWith) public returns (address) {
        // we need to call the upgrade on the V1 contract itself
        // this is also correct: UUPSUpgradeable contractToBeUpgraded = UUPSUpgradeable(payable(proxy));
        BOXV1 proxy = BOXV1(payable(proxy));
        proxy.upgradeTo(contractToBeUpgradedWith);
        return address(proxy); //this will never change
    }
}
