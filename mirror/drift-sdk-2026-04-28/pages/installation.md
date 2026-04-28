# Installation
URL: https://mintlify.com/drift-labs/protocol-v2/installation

# Installation

Get started with Drift Protocol v2 by installing the SDK and setting up your Solana wallet for trading.

## Prerequisites

- Node.js 24.0.0+
- Package manager (npm, yarn, or pnpm)
- Solana CLI (optional, for wallet management)

## Install the SDK

```bash
npm install @drift-labs/sdk
```

Current SDK version: 2.158.0-beta.0

## Core Dependencies

- `@coral-xyz/anchor` (0.29.0 & 0.30.1)
- `@solana/web3.js` (1.98.0)
- `@solana/spl-token` (0.4.13)
- `bn.js`

## Set Up a Solana Wallet

```bash
solana-keygen new
solana address
echo BOT_PRIVATE_KEY=`cat ~/.config/solana/id.json` >> .env
```

NEVER commit `.env` or share your private key.

### Fund Your Wallet

Devnet: `solana airdrop 2 YOUR_WALLET_ADDRESS --url devnet`. Drift devnet faucet provides USDC.

Mainnet: purchase SOL, transfer to wallet, acquire USDC for collateral. Need both SOL (fees) and USDC (collateral).

## Environment Variables

```bash
BOT_PRIVATE_KEY=[123,45,67,...]
ANCHOR_PROVIDER_URL=https://api.devnet.solana.com
ANCHOR_WALLET=/path/to/your/keypair.json
```

## RPC Endpoints

Public:
- Devnet: `https://api.devnet.solana.com`
- Mainnet: `https://api.mainnet-beta.solana.com`

Premium (recommended for production): Helius, QuickNode, Triton.

## Verify Installation

```typescript
import { Connection, PublicKey } from '@solana/web3.js';
import { initialize } from '@drift-labs/sdk';

const main = async () => {
  const sdkConfig = initialize({ env: 'devnet' });
  const connection = new Connection('https://api.devnet.solana.com');
  const version = await connection.getVersion();
  console.log('Drift Program ID:', sdkConfig.DRIFT_PROGRAM_ID);
  console.log('USDC Mint:', sdkConfig.USDC_MINT_ADDRESS);
};

main().catch(console.error);
```

Run: `npx tsx test-setup.ts` (after `npm install -D ts-node typescript` or `tsx`).

## TypeScript Configuration

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

## Building from Source

```bash
git clone https://github.com/drift-labs/protocol-v2.git
cd protocol-v2
yarn
cd sdk/
yarn
yarn build
yarn test
```

For M1 Mac users: `rustup default stable-x86_64-apple-darwin`
