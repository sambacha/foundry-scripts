pragma solidity 0.5.4;
pragma experimental ABIEncoderV2;

import "./Callable.sol";


library TestUtils {
    function returnAndRevert(bool result) internal returns(bool) {
        assembly {
             let memOffset := mload(0x40)
             mstore(memOffset, result)
             mstore(0x40, add(memOffset, 32))
             revert(memOffset, 32)
        }
    }

    function expectTrue(Callable.CallResult memory callResult) internal returns(Callable.CallResult memory) {
        bytes memory data = callResult.data;
        if (!callResult.success) {
            returnAndRevert(false);
        }
        if (data.length != 32) {
            returnAndRevert(false);
        }
        bool result = abi.decode(data, (bool));
        if (!result) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function expectEqual(Callable.CallResult memory callResult, uint expectedResult) internal returns(Callable.CallResult memory) {
        uint parsedData = toUInt(callResult);
        if (parsedData != expectedResult) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function expectUInt(Callable.CallResult memory callResult) internal returns(Callable.CallResult memory) {
        if (!callResult.success || callResult.data.length != 32) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function expectNonEmptyResult(Callable.CallResult memory callResult) internal returns(Callable.CallResult memory) {
        if (!callResult.success || callResult.data.length == 0) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function expectSuccess(Callable.CallResult memory callResult) internal returns(Callable.CallResult memory) {
        if (!callResult.success) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function expectRevert(Callable.CallResult memory callResult) internal returns(Callable.CallResult memory) {
        if (callResult.success) {
            returnAndRevert(false);
        }
        return callResult;
    }

    function toBool(Callable.CallResult memory callResult) internal returns(bool) {
        if (callResult.data.length != 32) {
            return false;
        }
        return abi.decode(callResult.data, (bool));
    }

    function toUInt(Callable.CallResult memory callResult) internal returns(uint) {
        expectUInt(callResult);
        return abi.decode(callResult.data, (uint));
    }
}