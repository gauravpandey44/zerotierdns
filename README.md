# zerotierdns

## A DNS server for ZeroTier virtual networks.

### Features

- Address members of ZeroTier networks by <name>.zt
- Runs dns inside docker container
- IPv4 support
- Also uses the host computer `/etc/hosts` file to resolve the request.(If you dont want that remove the volume mount point in docker-compose.yml)

<!-- #region -->
### Usage

1. Start container using docker compose

- `mv .config_demo .config`
-  Add your API & NETWORK details in .config file
-  Start the dns `docker-compose up -d`

2. Now add `127.0.0.1` `inside /etc/resolv.conf` in the host computer where docker is running.

3. Access the zerotier DNS from other computers that are part of zerotier network. This can be acheived by any two method shown below :

  - If you want to access all the domains from all other computers that are part of zerotier.Add `A.B.C.D` that is the IP of host where docker is running `inside /etc/resolv.conf` in the every other computers.
  
  OR 
  
  - Run a new container in all other computers by following the step 1 & step 2 shown above.
  
  


<!-- #endregion -->
