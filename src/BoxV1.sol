//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BOXV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    /*
    * Implementation contracts cannot use constructor
    * because it updates the storage to the implementation, 
    * that has to be maintained inside the Proxy (where the owner is)
    */
    constructor() {
        _disableInitializers();
    }

    /**
     * The proxy will call inizialize after deployment
     * They alike constructor but for Proxies (called once).
     * It will call transferAccess and it
     * sets the owner to msg.sender
     */
    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init(); //just tells the @dev that it's UUPS
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    /**
     * The abstract function that has to be implemented
     * Not really used rn: anybody can upgrade this
     */
    function _authorizeUpgrade(address newImplementation) internal override {
        // if (msg.sender != owner) {
        //     revert BOXV1_upgradeNoAuthorized();
        // }
        //or onlyOwner modifier
    }
}
