//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract CalledContract {
    uint256 public varStoredAtAddress0Number;
    address public varStoredAtAddress1Address;
    uint256 public varStoredAtAddress2Value;

    function setVariables(uint256 _number) public payable {
        varStoredAtAddress0Number = _number;
        varStoredAtAddress1Address = msg.sender;
        varStoredAtAddress2Value = msg.value;
    }
}

contract CallerContract {
    uint256 public number;
    address public sender;
    uint256 public value;

    function setVariablesDelegatecall(address _contract, uint256 _number) public payable {
        (bool success, bytes memory data) =
            _contract.delegatecall(abi.encodeWithSignature("setVariables(uint256)", _number));
    }

     function setVariablesCall(address _contract, uint256 _number) public payable {
        (bool success, bytes memory data) =
            _contract.call(abi.encodeWithSignature("setVariables(uint256)", _number));
    }
}
