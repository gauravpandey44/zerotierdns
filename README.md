# zerotierdns

## A DNS server for ZeroTier virtual networks.

### Features

- Address members of ZeroTier networks by <name>.zt
- Runs dns inside docker container
- IPv4 support

<!-- #region -->
### Usage

1. Using docker compose


- `mv .config_demo .config`
-  Add your API & NETWORK details in .config file
-  Start the dns `docker-compose up -d`
<!-- #endregion -->
