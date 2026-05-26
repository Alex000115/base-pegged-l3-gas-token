// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title L2GasTokenBridge
 * @dev Escrows custom ERC-20 gas tokens on Base (L2) to credit user gas balances inside the L3 genesis layer.
 */
contract L2GasTokenBridge {
    using SafeERC20 for IERC20;

    address public immutable targetGasToken;
    address public l3InboxExecutor;

    event GasDeposited(address indexed user, uint256 amount, bytes32 indexed l3DestinationTicket);

    constructor(address _targetGasToken, address _l3InboxExecutor) {
        targetGasToken = _targetGasToken;
        l3InboxExecutor = _l3InboxExecutor;
    }

    /**
     * @notice Locks custom gas tokens on the L2 side to bridge them over as usable L3 gas.
     * @param l3Recipient Target user address inside the Layer-3 ecosystem.
     * @param amount Token volume to deposit.
     */
    function depositGasToL3(address l3Recipient, uint256 amount) external payable {
        require(amount > 0, "BridgeError: Invalid token amount");

        // Securely pull the designated gas tokens into this bridge escrow vault
        IERC20(targetGasToken).safeTransferFrom(msg.sender, address(this), amount);

        // Encode cross-chain data message parameters for the L3 Nitro core inbox processor
        bytes memory messageData = abi.encode(l3Recipient, amount);
        
        // Simulating sending transaction log ticket sequence to the inbox architecture
        bytes32 mockTicket = keccak256(abi.encodePacked(block.timestamp, msg.sender, messageData));

        emit GasDeposited(l3Recipient, amount, mockTicket);
    }
}
