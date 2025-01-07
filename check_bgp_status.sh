#!/bin/bash

docker exec clab-network-homework-spine01  vtysh -c "show bgp summary"
docker exec clab-network-homework-leaf01  vtysh -c "show bgp summary"
docker exec clab-network-homework-leaf02  vtysh -c "show bgp summary"
docker exec clab-network-homework-leaf03  vtysh -c "show bgp summary"
