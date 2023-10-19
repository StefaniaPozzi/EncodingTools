//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BoxDeploy} from "../script/BoxDeploy.s.sol";
import {BoxUpgrade} from "../script/BoxUpgrade.s.sol";
import {BOXV1} from "../src/BoxV1.sol";
import {BOXV2} from "../src/BOXV2.sol";

contract DeployAndUpgradeBox is Test {
    BoxDeploy deployer;
    BoxUpgrade upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy; //it's a fixed address, never changes!

    function setUp() public {
        deployer = new BoxDeploy();
        upgrader = new BoxUpgrade();
        proxy = deployer.run(); //proxy address that points to BOXV1
    }

    function test_InitialisingWithBoxV1() public {
        uint256 expectedVersion = 1;
        uint256 actualVersion = BOXV1(proxy).version();
        assertEq(expectedVersion, actualVersion);
    }

    function test_UpgradeV1toV2() public {
        BOXV2 box2 = new BOXV2();
        upgrader.upgrade(proxy, address(box2));
        uint256 expectedVersion = 2;
        uint256 actualVersion = BOXV2(proxy).version();
        assertEq(expectedVersion, actualVersion);
    }
}
