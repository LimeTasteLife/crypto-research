# Connect and Deposit
URL: https://mintlify.com/drift-labs/protocol-v2/examples/connect-and-deposit

# Connect and Deposit

Connect to Drift and deposit collateral.

```typescript
import { Connection, Keypair, PublicKey } from '@solana/web3.js';
import { getAssociatedTokenAddress } from '@solana/spl-token';
import {
  DriftClient, User, Wallet, BulkAccountLoader, BN,
  initialize, QUOTE_PRECISION
} from '@drift-labs/sdk';

const env = 'devnet';
const sdkConfig = initialize({ env });

const connection = new Connection('https://api.devnet.solana.com', 'confirmed');
const keypair = Keypair.fromSecretKey(Uint8Array.from(JSON.parse(process.env.BOT_PRIVATE_KEY)));
const wallet = new Wallet(keypair);

const bulkAccountLoader = new BulkAccountLoader(connection, 'confirmed', 1000);

const driftClient = new DriftClient({
  connection, wallet,
  programID: new PublicKey(sdkConfig.DRIFT_PROGRAM_ID),
  accountSubscription: { type: 'polling', accountLoader: bulkAccountLoader },
});
await driftClient.subscribe();

const userPda = await driftClient.getUserAccountPublicKey();
const user = new User({ driftClient, userAccountPublicKey: userPda,
  accountSubscription: { type: 'polling', accountLoader: bulkAccountLoader }});

const exists = await user.exists();
if (!exists) {
  const usdcAta = await getAssociatedTokenAddress(
    new PublicKey(sdkConfig.USDC_MINT_ADDRESS),
    wallet.publicKey
  );
  const depositAmount = new BN(10000).mul(QUOTE_PRECISION);
  await driftClient.initializeUserAccountAndDepositCollateral(
    depositAmount, usdcAta
  );
}
await user.subscribe();
```
