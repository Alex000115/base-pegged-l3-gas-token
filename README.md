# Base-Pegged L3 Native Gas Engine

By mid-2026, hyper-scalable app-chains are predominantly deployed as Layer-3 networks (L3s) on top of dominant L2 hubs like Base or Arbitrum. This repository provides a professional-grade reference configuration for customizing an **Arbitrum Orbit L3** execution engine. 

It explicitly overrides default network configurations to utilize a native ERC-20 token living on Base as the foundational transaction gas fee payment token for the app-chain ecosystem.

## Core Features
- **Custom Native Fee Token Routing:** Hooks directly into the Arbitrum Nitro source stack to replace standard Native ETH gas collection with any validated ERC-20 token.
- **Bridge Escrow Orchestration:** Automated lock-and-mint bridge templates enabling users to pass custom gas tokens seamlessly from Base (L2) to the App-chain (L3).
- **Gas Pricing Middleware:** Script matrices designed to calculate dynamic execution minimums based on gas oracle parameters matching L2 feed baselines.
- **Flat Layout:** All genesis setup configurations, parameters, and deployment bridge code reside in the root path.

## Setup & Initialization
1. Install configuration packages: `npm install`
2. Specify the L2 ERC-20 contract address and connection RPC parameters in `.env`.
3. Generate the network configuration genesis block: `node generateGenesis.js`
