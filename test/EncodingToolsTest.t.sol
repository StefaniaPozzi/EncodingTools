//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {EncodingTools} from "../src/EncondingTools.sol";

contract EncodingToolsTest is Test {
    EncodingTools encodingTools;

    function setUp() external {
        encodingTools = new EncodingTools();
    }

    function test_numberEncoding() public {
        bytes memory number = encodingTools.encodeNumber();
        console.logBytes(number);
    }

    function test_stringEncoding() public {
        bytes memory word = encodingTools.encodeString();
        bytes memory packedWord = encodingTools.encodeStringPacked();
        bytes memory castedWord = encodingTools.castStringToBytes();
        console.logBytes(word);

        console.logBytes(packedWord);
        console.logBytes(castedWord);
    }

    function testSimpleDecoding() public {
        string memory testString1 = "Test 1";
        assertEq(abi.encodePacked(testString1), abi.encodePacked(encodingTools.simpleDecoding()));
    }

    function testBinaryDecoding() public {
        string memory testString1 = "Test 1";
        string memory testString2 = "Test 2";
        (string memory resultString1, string memory resultString2) = encodingTools.binaryDecoding();
        assertEq(abi.encodePacked(testString1), abi.encodePacked(resultString1));
        assert(keccak256(abi.encodePacked(testString2)) == keccak256(abi.encodePacked(resultString2)));
    }

    function testBinaryDecodingFromPacked() public {
        string memory testString1 = "Test 1";
        string memory testString2 = "Test 2";
        vm.expectRevert();
        (string memory resultString1, string memory resultString2) = encodingTools.binaryDecodingFromPacked();
    }
}
