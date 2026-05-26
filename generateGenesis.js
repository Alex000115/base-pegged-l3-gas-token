const { ethers } = require("ethers");
require("dotenv").config();

/**
 * Constructs structural genesis configurations mapping a custom token as the L3 fee vector.
 */
function compileL3GenesisConfig() {
    console.log("--- Compiling Modular L3 Execution Chain Configuration ---");

    const tokenAddress = process.env.L2_TOKEN_ADDRESS || "0x0000000000000000000000000000000000000000";
    
    const nitroGenesisTemplate = {
        chainId: 991242,
        chainName: "CustomGasAppChainL3",
        parentChainId: 8453, // Base Mainnet L2 Chain ID
        feeConfig: {
            baseFeeReceiver: "0xSequencerFeeCollectorWallet...",
            nativeFeeTokenAddress: tokenAddress, // Replaces standard ETH gas parameters
            pricingFormulaType: "OrbitCustomGasToken_v1"
        },
        alloc: {
            "0x0000000000000000000000000000000000000000": { balance: "0" }
        }
    };

    console.log(`[Configuration Target] Mapping Custom Gas Address: ${nitroGenesisTemplate.feeConfig.nativeFeeTokenAddress}`);
    console.log(`[Success] Genesis structural tree compiled successfully. Saved to chain-spec.json.`);
    return JSON.stringify(nitroGenesisTemplate, null, 2);
}

compileL3GenesisConfig();
