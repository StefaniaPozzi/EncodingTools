//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

contract EncodingTools {
    string public constant TEST_STRING_1 = "Test 1";
    string public constant TEST_STRING_2 = "Test 2";

    function simpleDecoding() public pure returns (string memory) {
        bytes memory encodedOriginalString = abi.encode(TEST_STRING_1);
        return string(abi.decode(encodedOriginalString, (string)));
    }

    function binaryDecoding()
        public
        pure
        returns (string memory, string memory)
    {
        bytes memory binaryEncoding = abi.encode(TEST_STRING_1, TEST_STRING_2);
        (string memory testString1, string memory testString2) = abi.decode(
            binaryEncoding,
            (string, string)
        );
        return (testString1, testString2);
    }
}
