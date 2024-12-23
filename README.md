## Test lab overview

This repo includes code and instructions how to create a test network using Cumulus routers.

The test network is created by using containerlab and it consists of three Cumulus VX switches that are connected into a spine-leaf topology (one spine and two leafs).

BGP unnumbered are configured between spine and each of leaf switches. 


## Requirements to this lab
To recreate this lab you need to have basic familiarity with Linux (Ubuntu), Docker, and containerlab. This lab was created and tested on an Ubuntu VM.

Environment:
- Ubuntu 22.04 (make sure that curl and git are pre-installed)
- Docker 26.1.4
- Containerlab v0.60.1
- Cumulus_cvx networkop/cx:4.3.0 image

Cumulus images will be downloaded automatically by containerlab when you deploy the lab for the first time.


## Lab Topology
<img width="477" alt="Screenshot 2024-12-18 at 21 48 09" src="https://github.com/user-attachments/assets/5308af4c-e031-4a94-a290-404789e7834f" />

This graph was made using a command: 

```
sudo clab graph -s "0.0.0.0:8080"-t cvx-dcn.clab.yaml
```


## IP addresses

clab-hostinger-homework-leaf01: 
- 10.10.10.1/32 lo IP address

clab-hostinger-homework-leaf02: 
- 10.10.10.2/32 lo IP address

clab-hostinger-homework-spine01: 
- 10.10.10.101/32 lo IP address
<br>

## Step-by-step instruction how to install the lab

<br>

#### 1. Download repo files to the Ubuntu server and place them to users home directory.
```
git clone https://github.com/AdmineLaura/containerlab_test.git
```  
<br>

#### 2. Run script "0_install_all.sh"
   _This script will automaticaly install the whole containerlab by launching all other scripts one by one._
```
./0_install_all.sh
``` 
<br>

#### 3. Run script "check_bgp_status.sh" to check if bgp sessions are established.
   _This script will show bgp summary of each container to verity the bpg status_
```
sudo ./check_bgp_status.sh
```   
<br>
<br>

To delete the lab use the command: 
```
sudo containerlab destroy -t homework-lab.clab.yml --cleanup
```
<br>
<br>
<br>

## Usefull commands to navigate inside the lab

Basic Usage inspect the status of all nodes in the network:
```
sudo containerlab inspect
```

```
╭───────────────────────────────┬────────────────────┬─────────┬───────────────────╮
│              Name             │     Kind/Image     │  State  │   IPv4/6 Address  │
├───────────────────────────────┼────────────────────┼─────────┼───────────────────┤
│ clab-network-homework-leaf01  │ cumulus_cvx        │ running │ 172.20.20.2       │
│                               │ networkop/cx:4.3.0 │         │ 3fff:172:20:20::3 │
├───────────────────────────────┼────────────────────┼─────────┼───────────────────┤
│ clab-network-homework-leaf02  │ cumulus_cvx        │ running │ 172.20.20.4       │
│                               │ networkop/cx:4.3.0 │         │ 3fff:172:20:20::4 │
├───────────────────────────────┼────────────────────┼─────────┼───────────────────┤
│ clab-network-homework-spine01 │ cumulus_cvx        │ running │ 172.20.20.3       │
│                               │ networkop/cx:4.3.0 │         │ 3fff:172:20:20::2 │
╰───────────────────────────────┴────────────────────┴─────────┴───────────────────╯
```
(The output should confirm that all nodes are running.)
<br>

Confirm that BGP sessions are established among all peers.
```
sudo docker exec clab-network-homework-spine01 vtysh -c "show bgp summary"
```
or using Cumulus commands:
```
sudo docker exec clab-network-homework-spine01 net show bgp summary
```
<br>
<br>

Show routes that were learned from BGP in the routing table. 
```
sudo docker exec clab-network-homework-spine01 vtysh -c "show ip route bgp"   
```
or using Cumulus commands:
```
sudo docker exec clab-network-homework-spine01 net show bgp
```
