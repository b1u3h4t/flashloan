pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "./interfaces/IFlashLoanProvider.sol";
import "./lib/FlashLoanReceiver.sol";

contract FlashLoanExample is FlashLoanReceiver {
    IFlashLoanProvider internal flashLoanProvider;
    uint256 private _balance;

    constructor(address _flashLoanProvider) public {
        flashLoanProvider = IFlashLoanProvider(_flashLoanProvider);
    }

    function execute(
        address token,
        uint256 amount,
        uint256 fee,
        address back,
        bytes calldata //unused
    ) external override {
        require(
            amount.add(_balance) == balance(token, address(this)),
            "flashloan failed"
        );

        //To do something...

        payback(back, token, amount.add(fee));
    }

    function flashloan(
        address token,
        uint256 amount,
        bytes memory params
    ) public payable onlyOwner {
        _balance = balance(token, address(this));
        flashLoanProvider.flashloan(address(this), token, amount, params);
    }
}
