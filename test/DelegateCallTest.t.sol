//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {CalledContract, CallerContract} from "../src/DelegateCall.sol";

contract DelegateCallTest is Test {
    CalledContract public bob;
    CallerContract public alice;
    address someOwner = makeAddr("someOwner");

    function setUp() external {
        bob = new CalledContract(someOwner);
        alice = new CallerContract();
        alice.setVariablesDelegatecall(address(bob), 123);
    }

    function test_call() public {
        //Bob is modified!! :)
        assert(bob.varStoredAtAddress0Number() == 123);
        assert(bob.varStoredAtAddress1Address() == address(alice)); //Alice is calling Bob's function
        assert(bob.varStoredAtAddress2Value() == 0);
        //Alice is not modified :(
        assert(alice.number() == 0);
        assert(alice.sender() == address(0));
    }

    function test_delegatecall() public {
        //Bob is not modified :(
        assert(bob.varStoredAtAddress0Number() == 0);
        assert(bob.varStoredAtAddress1Address() == address(0));
        assert(bob.varStoredAtAddress2Value() == 0);
        //Alice state variables are modified!! :)
        assert(alice.number() == 123);
        assert(alice.sender() == address(this)); //Test contract is calling Alice's function
            // assert(alice.value() == 456) ; value?
    }

    function test_addressThisDoesNotChangeItsValue() public {}

    function test_differentLayoutStorage() public {
        assert(alice.differentTypeLayout0()); //this could generate unexpectable behaviour
    }

    function test_delegatecallOnEOA() public {
        assert(alice.setVariablesDelegatecall(someOwner, 123)); //calling delegate cal on EOA return success
    }
}
