pragma solidity 0.5.4;
pragma experimental ABIEncoderV2;

import "./Callable.sol";
import "./TestAccount.sol";

library TestedToken {
    using Callable for address;

    function totalSupply(address token) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("totalSupply()"));
    }

    function balanceOf(address token, TestAccount who) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("balanceOf(address)", who));
    }

    function allowance(address token, TestAccount owner, TestAccount spender) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("allowance(address,address)", owner, spender));
    }

    function name(address token) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("name()"));
    }

    function symbol(address token) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("symbol()"));
    }

    function decimals(address token) internal returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("decimals()"));
    }
}
