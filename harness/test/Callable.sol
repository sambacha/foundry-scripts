pragma solidity 0.5.4;


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

