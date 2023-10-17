//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {CalledContract, CallerContract} from "../src/DelegateCall.sol";

contract DelegateCallTest is Test {
    CalledContract public bob;
    CallerContract public alice;

    function setUp() external {
        bob = new CalledContract();
        alice = new CallerContract();
    }

    function test_Delegatecall() public {
        alice.setVariablesDelegatecall(address(bob), 123);
        //Bob is not modified :(
        assert(bob.varStoredAtAddress0Number() == 0);
        assert(bob.varStoredAtAddress1Address() == address(0));
        assert(bob.varStoredAtAddress2Value() == 0);
        //Alice is modified!! :)
        assert(alice.number() == 123);
        assert(alice.sender() == address(this)); //Test contract is calling Alice's function
            // assert(alice.value() == 456) ; value?
    }

    function test_Call() public {
        alice.setVariablesCall(address(bob), 123);
        //Bob is modified!! :)
        assert(bob.varStoredAtAddress0Number() == 123);
        assert(bob.varStoredAtAddress1Address() == address(alice)); //Alice is calling Bob's function
        assert(bob.varStoredAtAddress2Value() == 0);
        //Alice is not modified :(
        assert(alice.number() == 0);
        assert(alice.sender() == address(0));
    }
}
