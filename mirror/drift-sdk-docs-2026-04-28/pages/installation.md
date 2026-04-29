# Installation - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/installation

# Installation

> Install the Drift Protocol SDK and set up your development environment

# Installation

Get started with Drift Protocol v2 by installing the SDK and setting up your Solana wallet for trading.

## Prerequisites

Before installing the Drift SDK, ensure you have:

## Node.js

Node.js version 24.0.0 or higher

```bash
node --version

```

## Package Manager

npm, yarn, or pnpm installed

```bash
npm --version
# or
yarn --version

```

## Solana CLI (Optional)

For wallet generation and management

```bash
solana --version

```

Install from Solana's official docs if needed

## Install the SDK

Install the `@drift-labs/sdk` package in your project:

```bash
npm install @drift-labs/sdk

```

```bash
yarn add @drift-labs/sdk

```

```bash
pnpm add @drift-labs/sdk

```

Current SDK version: 2.158.0-beta.0

## Core Dependencies

The Drift SDK includes these key dependencies:

- `@coral-xyz/anchor` (0.29.0 & 0.30.1) - Solana program framework
- `@solana/web3.js` (1.98.0) - Solana JavaScript API
- `@solana/spl-token` (0.4.13) - SPL token operations
- `bn.js` - BigNumber support for precise calculations

These are automatically installed with the SDK.

## Set Up a Solana Wallet

You'll need a Solana wallet to interact with Drift Protocol.

### Generate a New Keypair

## Generate keypair

```bash
solana-keygen new

```

This creates a new keypair at `~/.config/solana/id.json`

## Get your wallet address

```bash
solana address

```

Save this address - you'll need it to fund your wallet

## Add private key to environment

```bash
cd your-project-directory
echo BOT_PRIVATE_KEY=`cat ~/.config/solana/id.json` >> .env

```

Never commit your `.env` file or share your private key! Add `.env` to your `.gitignore` file.

### Fund Your Wallet

## Devnet (Testing)

For testing on devnet, use the Solana faucet:

```bash
solana airdrop 2 YOUR_WALLET_ADDRESS --url devnet

```

You can also get devnet USDC from Drift's faucet after connecting your wallet.

## Mainnet (Production)

For mainnet:

1. Purchase SOL from an exchange
2. Transfer SOL to your wallet address
3. Acquire USDC (you'll need it for collateral)

You need both SOL (for transaction fees) and USDC (for trading collateral) on mainnet.

## Environment Variables

Create a `.env` file in your project root:

```bash
# Your wallet's private key (as JSON array)
BOT_PRIVATE_KEY=[123,45,67,...]

# Solana RPC endpoint
ANCHOR_PROVIDER_URL=https://api.devnet.solana.com
# For mainnet: https://api.mainnet-beta.solana.com

# Wallet path (optional, defaults to ~/.config/solana/id.json)
ANCHOR_WALLET=/path/to/your/keypair.json

```

## Finding RPC Endpoints

You can use public RPC endpoints or premium providers for better performance:

Public Endpoints:

- Devnet: `https://api.devnet.solana.com`
- Mainnet: `https://api.mainnet-beta.solana.com`

Premium Providers (Recommended for Production):

- Helius
- QuickNode
- Triton

Premium RPC providers offer higher rate limits and better reliability.

## Verify Installation

Create a simple test script to verify everything is set up correctly:

```typescript
import { Connection, PublicKey } from '@solana/web3.js';
import { initialize } from '@drift-labs/sdk';

const main = async () => {
  // Initialize SDK config
  const sdkConfig = initialize({ env: 'devnet' });
  console.log('SDK initialized for:', 'devnet');
  
  // Connect to Solana
  const connection = new Connection('https://api.devnet.solana.com');
  
  // Check connection
  const version = await connection.getVersion();
  console.log('Connected to Solana cluster:', version);
  
  console.log('\nDrift Program ID:', sdkConfig.DRIFT_PROGRAM_ID);
  console.log('USDC Mint:', sdkConfig.USDC_MINT_ADDRESS);
  
  console.log('\n✅ Installation verified successfully!');
};

main().catch(console.error);

```

Run the script:

```bash
npx ts-node test-setup.ts

```

```bash
npx tsx test-setup.ts

```

You may need to install `ts-node` or `tsx` for running TypeScript files:

```bash
npm install -D ts-node typescript

```

## TypeScript Configuration

For TypeScript projects, ensure your `tsconfig.json` includes:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "moduleResolution": "node",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "strict": true,
    "resolveJsonModule": true
  }
}

```

## Next Steps

## Quick Start Guide

Place your first trade on Drift Protocol

## API Reference

Explore the complete SDK documentation

## Troubleshooting

## Module not found errors

Ensure all peer dependencies are installed:

```bash
npm install @solana/web3.js @coral-xyz/anchor @solana/spl-token

```

## Connection timeout errors

- Check your internet connection
- Try a different RPC endpoint
- Consider using a premium RPC provider for better reliability

## BigNum/BN errors

The SDK uses `bn.js` for BigNumber operations. Import `BN` from the SDK:

```typescript
import { BN } from '@drift-labs/sdk';

```

## Node version errors

Drift SDK requires Node.js 24.0.0 or higher. Update Node.js:

```bash
nvm install 24
nvm use 24

```

## Building from Source

If you want to contribute or build the SDK from source:

```bash
# Clone the repository
git clone https://github.com/drift-labs/protocol-v2.git
cd protocol-v2

# Install dependencies
yarn

# Build the SDK
cd sdk/
yarn
yarn build

# Run tests
yarn test

```

For M1 Mac users, set the Rust toolchain first:

```bash
rustup default stable-x86_64-apple-darwin

```
