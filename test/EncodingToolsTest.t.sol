//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {EncodingTools} from "../src/EncondingTools.sol";

contract EncodingToolsTest is Test {
    EncodingTools encodingTools;

    function setUp() external {
        encodingTools = new EncodingTools();
    }

    function testSimpleDecoding() public {
        string memory testString1 = "Test 1";
        assertEq(
            abi.encodePacked(testString1),
            abi.encodePacked(encodingTools.simpleDecoding())
        );
    }

    function testBinaryDecoding() public {
        string memory testString1 = "Test 1";
        string memory testString2 = "Test 2";
        (
            string memory resultString1,
            string memory resultString2
        ) = encodingTools.binaryDecoding();
        assertEq(
            abi.encodePacked(testString1),
            abi.encodePacked(resultString1)
        );
        assertEq(
            abi.encodePacked(testString2),
            abi.encodePacked(resultString2)
        );
    }
}
