//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {LowLevelFunctionsSandbox} from "../src/LowLevelFunctionsSandbox.sol";

contract LowLevelFunctionsSandboxTest is Test {
    LowLevelFunctionsSandbox lowLevelFunctionsSandbox;

    function setUp() external {
        lowLevelFunctionsSandbox = new LowLevelFunctionsSandbox();
    }

    function test_rawCallWithSignature() public {
        address currentTestAddress = address(lowLevelFunctionsSandbox);
        uint256 amountTest = 123;
        lowLevelFunctionsSandbox.rawCallWithSignature(currentTestAddress, amountTest);
        address newTestAddress = lowLevelFunctionsSandbox.getAddress();
        uint256 newAmount = lowLevelFunctionsSandbox.getAmount();
        assert(newTestAddress == address(lowLevelFunctionsSandbox));
        assert(newAmount == 123);
    }
}
