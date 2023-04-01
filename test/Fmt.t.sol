//// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

import {Test, expect, config, Rpc, console} from "../src/test.sol";
import {Type, Placeholder, fmt} from "../src/Fmt.sol";

contract PrintfTest is Test {
    function testFormat() external {
        string memory template = "{address} hello {string} world {bool}";
        string memory result = fmt.format(template, abi.encode(address(123), "foo", true));

        expect(result).toEqual("0x000000000000000000000000000000000000007B hello foo world true");
    }

    function testFormatDecimals() external {
        expect(fmt.format("{uint:d18}", abi.encode(1e17))).toEqual("0.1");
        expect(fmt.format("{uint:d17}", abi.encode(1e17))).toEqual("1.0");
        expect(fmt.format("{uint:d19}", abi.encode(1e17))).toEqual("0.01");
        expect(fmt.format("{uint:d2}", abi.encode(123))).toEqual("1.23");
        expect(fmt.format("{uint:d2}", abi.encode(103))).toEqual("1.03");
        expect(fmt.format("{uint:d2}", abi.encode(1003))).toEqual("10.03");
        expect(fmt.format("{uint:d2}", abi.encode(1000))).toEqual("10.0");
    }
}
