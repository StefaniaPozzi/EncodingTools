//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

contract LowLevelFunctionsSandbox {
    address public s_alice;
    uint256 public s_amount;

    /**
     * @notice We invent a dummy function to call
     */
    function setStateVariables(address _address, uint256 _amount) public {
        s_alice = _address;
        s_amount = _amount;
    }

    /**
     * @dev Encoding at low level - not necessary
     * Equivalent to encodeWithSignature
     */
    function getDataForCallWithSelector(address _address, uint256 _amount) public pure returns (bytes memory) {
        bytes4 selectorEncoded = bytes4(keccak256(bytes("setStateVariables(address,uint256)")));
        abi.encodeWithSelector(selectorEncoded, _address, _amount);
    }

    /**
     * @dev More readable than the previous function, same effect
     * (differ in costs? / security ?)
     */
    function getDataForCallWithSignature(address _address, uint256 _amount) public pure returns (bytes memory) {
        return abi.encodeWithSignature("setStateVariables(address,uint256)", _address, _amount);
    }

    function rawCallWithSelector(address _address, uint256 _amount) public returns (bool, bytes4) {
        (bool success, bytes memory returnData) = address(this).call(getDataForCallWithSelector(_address, _amount));
        return (success, bytes4(returnData));
    }

    function rawCallWithSignature(address _address, uint256 _amount) public returns (bool, bytes4) {
        (bool success, bytes memory returnData) = address(this).call(getDataForCallWithSignature(_address, _amount));
        return (success, bytes4(returnData));
    }

    function getAmount() public returns (uint256) {
        return s_amount;
    }

    function getAddress() public returns (address) {
        return s_alice;
    }
}
