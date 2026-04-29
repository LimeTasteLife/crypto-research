# dYdX Chain Client for Python

Source: https://docs.dydx.community/dydx-chain-technical-docs/getting-started/developer-tools/dydx-chain-client-for-python

Python client for dYdX (v4 API).

## Repository: v4-client-py

## Installation

The `v4-client-py` package is available on PyPI. Install with `pip`:

```
pip install v4-client-py
```

## Development Setup - VS Code

Install Microsoft Python extensions:

```
Shift-Command-P: Create Python Environment
Select Venv
Select Python 3.9 as interpreter
Select requirements.txt as the dependencies to install
```

Install requirements:

```
pip install -r requirements.txt
```

Set PYTHONPATH:

```
export PYTHONPATH=~/<project_dir>/.venv/lib/<Python version>/site-packages
```

## Troubleshooting

Cython and Brownie must be installed before cytoolz. If there is any issue with cytoolz, uninstall cytoolz, Brownie and Cython, then reinstall Cython, Brownie and cytoolz sequentially. VS Code may need to be restarted to have Cython functioning correctly.
