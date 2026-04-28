# Web Front End

Source: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/web-front-end

## Repository: v4-web

## Prerequisites

- Node.js version 18 and `pnpm` installed on your system
- Wallet Connect account
- For deploying with Vercel, create an account with Vercel
- For deploying to IPFS: a free web3.storage account, OR an IPFS client such as IPFS Kubo

### Part 1: Setting up your local environment

Clone the repo:
```
git clone https://github.com/dydxprotocol/v4-web.git
cd v4-web
```

Install pnpm and dependencies:
```
npm i -g pnpm
pnpm i
```

### Part 2: Running the project locally

```
pnpm dev
```

Dev server runs at `http://localhost:5173`. Component stories: `pnpm ladle` (opens at `http://localhost:61000`).

### Part 3: Configuring environment

Add or modify the relevant endpoints, links and options in `/public/configs/env.json`. You'll need to provide a Wallet Connect project id to enable onboarding and wallet connection.

### Part 4: Set Environment variables

Set environment variables via `.env`:

- `VITE_BASE_URL` (required): The base URL of the deployment (e.g., `https://www.example.com`).
- `VITE_ALCHEMY_API_KEY` (optional): Add an Alchemy API key for EVM interactions; the app will fall back to public RPCs if not provided.
- `VITE_PK_ENCRYPTION_KEY` (optional): AES encryption key used for signature obfuscation; necessary for enabling the "Remember Me" feature.
- `VITE_V3_TOKEN_ADDRESS` (optional): Address of the V3 $DYDX token.
- `VITE_TOKEN_MIGRATION_URI` (optional): The URL of the token migration website.
- `AMPLITUDE_API_KEY`, `AMPLITUDE_SERVER_URL`, `BUGSNAG_API_KEY`, `IOS_APP_ID`, `INTERCOM_APP_ID`, `STATUS_PAGE_SCRIPT_URI`, `SMARTBANNER_*` — various optional integrations.

## Deployments

### Deploying with Vercel

Connect repository, configure: Framework Preset: `Vite`, Build Command: `pnpm run build`. Use `--mode testnet` flag for testnet builds.

### Deploying to IPFS via web3.storage

```
export WEB3_STORAGE_TOKEN=your_token
pnpm run deploy:ipfs
```

### Deploying to IPFS via IPFS Kubo

```
ipfs add -r dist
```

### Accessing your content on IPFS

- Native IPFS browser (Brave/Opera): `ipfs://your_cid`
- Public gateway: `https://dweb.link/ipfs/your_cid` or `https://w3s.link/`

## Cloudflare Settings

Recommended additional security via Cloudflare. To block OFAC Sanctioned countries:

1. Navigate Websites > Domain > Security > WAF
2. Create Rule: If incoming requests match `(ip.geoip.country eq "CU") or (ip.geoip.country eq "IR") or (ip.geoip.country eq "KP") or (ip.geoip.country eq "SY") or (ip.geoip.country eq "MM") or (ip.geoip.subdivision_1_iso_code eq "UA-09") or (ip.geoip.subdivision_1_iso_code eq "UA-14") or (ip.geoip.subdivision_1_iso_code eq "UA-43")` — bring up custom Cloudflare page when restricted geography tries to access.

Suggested message: "Because you appear to be a resident of, or trading from, a jurisdiction that violates our terms of use, or have engaged in activity that violates our terms of use, you have been blocked. You may withdraw your funds from the protocol at any time."
