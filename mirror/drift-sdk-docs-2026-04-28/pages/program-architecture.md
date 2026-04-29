# Drift Protocol v2 Program Architecture

Source: https://mintlify.com/drift-labs/protocol-v2/program/architecture

## Overview

Drift Protocol operates as a Solana-based derivatives exchange built with the Anchor framework, supporting perpetual futures and spot markets through a cross-margined system.

Program ID (Mainnet & Devnet): `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH`

## Core Components

### State Accounts

- State: Global protocol settings
- PerpMarket: Perpetual market setup and AMM state
- SpotMarket: Collateral asset configuration
- User: Trading positions and orders
- UserStats: Metrics and fee classifications

### Controllers

- Position Controller: Manages trading positions
- Order Controller: Order processing and matching
- AMM Controller: Market maker functionality
- Liquidation Controller: Account liquidations
- Funding Controller: Funding rate administration

### Instructions

Operations organized in the `instructions/` module:

- User account and fund management
- Order operations (placement, modification, cancellation)
- Administrative functions and parameter adjustments
- Keeper operations for order fills and liquidations

## Key Features

The protocol emphasizes "Single collateral pool supports all positions" through cross-margin functionality, utilizes virtual AMM mechanics, incorporates a decentralized limit order book, and integrates Pyth and Switchboard oracle services.

## Technical Architecture

The system includes an Anchor-based entry point, on-chain account storage with version control, precision-oriented mathematical operations, and protective validation mechanisms for oracle data and risk parameters.

## Security Posture

Multiple audit completions, active bug bounty initiatives, governance-controlled upgrades, and oracle safeguards protect critical operations.

NOTE: This page was fetched via WebFetch fallback after `mcp__exa-web-search__web_fetch_exa` returned CRAWL_LIVECRAWL_TIMEOUT on first attempt. WebFetch returned a summarized rendition (shorter than exa would have produced); the full page may contain additional detail (e.g. instruction-level breakdowns and account-relationship diagrams). Recorded crawler: webfetch.
