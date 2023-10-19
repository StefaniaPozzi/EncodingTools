//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract CalledContract {
    uint256 public varStoredAtAddress0Number;
    address public varStoredAtAddress1Address;
    uint256 public varStoredAtAddress2Value;
    uint256 public differentTypeLayout0;

    //
    constructor(address _owner) {
        varStoredAtAddress1Address = _owner;
    }
    /**
     * Unmodifiable variables from the caller:
     * 1. msg.sender
     * 2. msg.value
     * 3. address(this) storage variables > are set in the constructor during its own deployment
     *
     * This contract cannot access the Caller (3) unmodifiable values (bottom-up).
     */

    function setVariables(uint256 _number) public payable {
        varStoredAtAddress0Number = _number;
        varStoredAtAddress1Address = msg.sender; //Target's caller, not Caller's caller
        varStoredAtAddress2Value = msg.value; //Target's value
        differentTypeLayout0 = 1;
        // varStoredAtAddress3Address = address(this);
        // this will be 0 -> it needs to be set after deployment !
    }
}

contract CallerContract {
    //same storage layout of the Called contract
    uint256 public number;
    address public sender;
    uint256 public value;
    bool public differentTypeLayout0;

    /**
     * The compiler sobstitutes setVariables with the delegatecall
     * and executes the function as it were in this contract,
     * except for the (3) unmodifiable fields
     */
    function setVariablesDelegatecall(address _contract, uint256 _number) public payable returns (bool) {
        (bool success, bytes memory data) =
            _contract.delegatecall(abi.encodeWithSignature("setVariables(uint256)", _number));
        return success;
    }

    function setVariablesCall(address _contract, uint256 _number) public payable {
        (bool success, bytes memory data) = _contract.call(abi.encodeWithSignature("setVariables(uint256)", _number));
    }
}
