pragma solidity 0.5.4;
pragma experimental ABIEncoderV2;

import "./Callable.sol";


contract TestAccount {
    using Callable for address;

    function transfer(TestAccount to, uint256 value, address token) external returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("transfer(address,uint256)", to, value));
    }

    function approve(TestAccount spender, uint256 value, address token) external returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("approve(address,uint256)", spender, value));
    }

    function transferFrom(TestAccount from, TestAccount to, uint256 value, address token) external returns(Callable.CallResult memory) {
        return token.makeCall(abi.encodeWithSignature("transferFrom(address,address,uint256)", from, to, value));
    }
}
