//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

contract CallAnything {
    address public s_alice;
    uint256 public s_amount;

    function transfer(address _address, uint256 _amount) public {
        s_alice = _address;
        s_amount = _amount;
    }

    function getFirstSelector() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function getDataForTransfer(
        address _address,
        uint256 _amount
    ) public pure returns (bytes memory) {
        abi.encodeWithSelector(getFirstSelector(), _address, _amount);
    }

    function rawTransfer(
        address _address,
        uint256 _amount
    ) public returns (bool, bytes4) {
        (bool success, bytes memory returnData) = address(this).call(
            getDataForTransfer(_address, _amount)
        );
    }

    function getAmount() public returns (uint256) {
        return s_amount;
    }

    function getAddress() public returns (address) {
        return s_alice;
    }
}
