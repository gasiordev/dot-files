#!/bin/bash

virst list

for i in `virsh list | grep "^ [0-9]\+" | awk '{ print $1 }' | sort`; do virsh domifaddr $i; done | grep vnet | awk '{ print $4 }'
