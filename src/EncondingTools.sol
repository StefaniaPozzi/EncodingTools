//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

contract EncodingTools {
    uint256 public constant TEST_NUMBER_1 = 1;
    string public constant TEST_STRING_0 = "Test 0";
    string public constant TEST_STRING_1 = "Test 1";
    string public constant TEST_STRING_2 = "Test 2";

    function encodeNumber() public pure returns (bytes memory number) {
        number = abi.encode(TEST_NUMBER_1);
    }

    /**
     * @dev returns
     * 0x0000000000000000000000000000000000000000000000000000000000000
     * 02000000000000000000000000000000000000000000000000000000000000000
     * 065465737420300000000000000000000000000000000000000000000000000000
     */
    function encodeString() public pure returns (bytes memory word) {
        word = abi.encode(TEST_STRING_0);
    }

    /**
     * @dev returns
     * 0x546573742030
     *
     * METHOD: Copying from memory - MORE EXPENSIVE
     */
    function encodeStringPacked() public pure returns (bytes memory word) {
        word = abi.encodePacked(TEST_STRING_0);
    }

    /**
     * @notice casting to bytes gives equal result to encodepacking
     *
     * METHOD: casts the pointer type - LESS EXPENSIVE
     */

    function castStringToBytes() public pure returns (bytes memory word) {
        word = bytes(TEST_STRING_0);
    }

    /**
     * @notice Just encoding and decoding one string
     */
    function simpleDecoding() public pure returns (string memory) {
        bytes memory encodedString = abi.encode(TEST_STRING_1);
        return abi.decode(encodedString, (string));
    }

    /**
     * @notice to decode the encodePacked, we need to cast it
     * Because ! Cast
     * @dev how to decode 2 encode packed strings? TODO
     */
    function simpleDecodingFromPacked() public pure returns (string memory word) {
        word = string(abi.encodePacked(TEST_STRING_1));
    }

    /**
     * @notice Just encoding and decoding two string
     */
    function binaryDecoding() public pure returns (string memory testString1, string memory testString2) {
        bytes memory binaryEncoding = abi.encode(TEST_STRING_1, TEST_STRING_2);
        (testString1, testString2) = abi.decode(binaryEncoding, (string, string));
    }

    /**
     * @notice This function reverts on decoding.
     * Use the following function instead
     */
    function binaryDecodingFromPacked() public pure returns (string memory testString1, string memory testString2) {
        bytes memory binaryEncodingPacked = abi.encodePacked(TEST_STRING_1, TEST_STRING_2);
        (testString1, testString2) = abi.decode(binaryEncodingPacked, (string, string));
    }
}
