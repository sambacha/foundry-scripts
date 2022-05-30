// SPDX-License-Identifier: GPL-2.0-Only 
pragma solidity ^0.5.17;

library Callable {
    struct CallResult {
        bool success;
        bytes data;
    }

    function makeCall(address to, bytes memory payload) internal returns(CallResult memory) {
        (bool success, bytes memory resultRaw) = address(to).call(payload);
        return CallResult(success, resultRaw);
    }
}

