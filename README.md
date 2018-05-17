# Pritunl OpenVPN server on Docker installation guide

Pritunl is a distributed enterprise vpn server built using the OpenVPN protocol.

## Getting Started

### Prerequisites

* Ubuntu 16.04
* `curl` or `wget` should be installed

### Qucik Installation

**via curl**

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Proscend/docker-pritunl/master/install.sh)"
```

**via wget**

```
sh -c "$(wget https://raw.githubusercontent.com/Proscend/docker-pritunl/master/install.sh -O -)"
```

### Start Pritunl OpenVPN Server

```
cd ~/docker-pritunl
./start.sh
```

### Stop Pritunl OpenVPN Server

```
cd ~/docker-pritunl
./stop.sh
```

### Dump Pritunl OpenVPN Server Log

```
cd ~/docker-pritunl
./log.sh
```
