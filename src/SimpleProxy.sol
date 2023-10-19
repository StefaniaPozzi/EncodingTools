//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Proxy} from "@openzeppelin/contracts/proxy/Proxy.sol";

contract SimpleProxy is Proxy {
    /**
     * Location of the implementation address
     * There are slots in storage dedicated to proxy
     * This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
     *
     */
    bytes32 private constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    /**
     * @notice equivalent to upgrading the smart contract
     * @param newImplementation Where the delegate call are sending their requests
     *
     */
    function setImplementation(address newImplementation) public {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    /**
     * @notice reads the address of the implementation contract
     */
    function _implementation() internal view override returns (address implementationAddress) {
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    /**
     * @dev to be sent inside calldata transaction
     * !! It will trigger the fallback function inside Proxy 
     * and this will delegatecall to the desired function!!
     * @return bytes that contain the function we want to call
     * 
    */
    function getDataToTransact(uint256 numberToUpdate) public pure returns (bytes memory) {
        return abi.encodeWithSignature("setValue(uint256)", numberToUpdate);
    }

    function readStorageAtSlotZero() public view returns (uint256 valueAtStorageSlotZero) {
        assembly {
            valueAtStorageSlotZero := sload(0)
        }
    }
}

contract ImplementationA {
    uint256 public value;

    function setValue(uint256 _value) public {
        value = _value;
    }

    /**
     * Never be called
    */
    function setImplementation(address test) public{}
}

contract ImplementationB{
    uint256 public value;

    function setValue(uint256 _value) public {
        value = _value+2;
    }
}
