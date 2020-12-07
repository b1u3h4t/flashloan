pragma solidity ^0.6.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "../interfaces/IFlashLoanReceiver.sol";

abstract contract FlashLoanReceiver is IFlashLoanReceiver, Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    event Withdrawn(
        address indexed account,
        address indexed token,
        uint256 amount
    );

    address constant ETH = address(0x0000000000000000000000000000000000000000);

    receive() external payable {}

    function payback(
        address to,
        address token,
        uint256 amount
    ) internal {
        address payable _to = address(uint160(to));
        if (token == ETH) {
            (bool success, ) = _to.call{value: amount}("");
            require(success == true, "Bad payback ETH");
            return;
        }
        IERC20(token).safeTransfer(_to, amount);
    }

    function balance(address token, address account)
        internal
        view
        returns (uint256)
    {
        if (token == ETH) return account.balance;
        return IERC20(token).balanceOf(account);
    }

    function withdraw(address token) public onlyOwner {
        uint256 _balance = balance(token, address(this));
        if (token == ETH) {
            msg.sender.transfer(_balance);
            return;
        }
        IERC20(token).safeTransfer(msg.sender, _balance);
        emit Withdrawn(msg.sender, token, _balance);
    }
}
