//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {CallAnything} from "../src/CallAnything.sol";

contract CallAnythingTest is Test {
    CallAnything callAnything;

    function setUp() external {
        callAnything = new CallAnything();
    }

    //TODO does not pass
    function testRawTransfer() public {
        address currentTestAddress = address(callAnything);
        uint256 amountTest = 123;
        (bool success, bytes4 result) = callAnything.rawTransfer(
            currentTestAddress,
            amountTest
        );
        address newTestAddress = callAnything.getAddress();
        uint256 newAmount = callAnything.getAmount();
        assert(newAmount != 0);
    }
}
