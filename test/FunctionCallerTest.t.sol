//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FunctionCaller} from "../src/FunctionCaller.sol";

contract LowLevelFunctionsTest is Test {
    FunctionCaller functionCaller;

    function setUp() external {
        functionCaller = new FunctionCaller();
    }

    function test_rawCallWithSignature() public {
        address currentTestAddress = address(functionCaller);
        uint256 amountTest = 123;
        functionCaller.rawCallWithSignature(currentTestAddress, amountTest);
        address newTestAddress = functionCaller.getAddress();
        uint256 newAmount = functionCaller.getAmount();
        assert(newTestAddress == address(functionCaller));
        assert(newAmount == 123);
    }
}
