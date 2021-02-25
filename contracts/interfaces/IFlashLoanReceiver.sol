pragma solidity ^0.6.2;

interface IFlashLoanReceiver {
    function executeOperation(address token, uint256 amount, uint256 fee, bytes calldata params) external;
}