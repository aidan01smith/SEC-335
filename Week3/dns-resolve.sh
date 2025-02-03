#!/bin/bash

network_prefix=$1
dns=$2

echo "dns resolution for $1"

for i in {1..254}; do
        ip="$network_prefix.$i"
        host_output=$(host "$ip" "$dns")
        if [[ $host_output == *"pointer"* ]]; then
                name=$(echo "$host_output" | grep -v "Aliases" | awk '{print $NF}' | sed 's/\.$//')
                echo -n "$name, "
        fi
done
