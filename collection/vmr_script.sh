#!/usr/bin/env bash

# The default rate is 800 Hz, which is a bit fast for the VMRs
# Dropping by a factor of 4 is generally a good idea
DECIMATE=4

# Start the proxy on tcp://localhost:7855
# tio-proxy /dev/ttyACM0 &

# Alternatively, the auto-proxy could be used to let twinleaf automatically
# find it's devices
tio-autoproxy

# Print the connection diagram for interest.  To turn these into sensor
# paths follow the documentation at:
# https://github.com/twinleaf/libtio/blob/master/doc/TIO%20Protocol%20Overview.md
tio-sensor-tree 

# Command decimation to 4 on the vmr's (so half speed)
tio-rpc -s /0 vector.data.decimation u32:$DECIMATE
tio-rpc -s /1 vector.data.decimation u32:$DECIMATE
tio-rpc -s /2 vector.data.decimation u32:$DECIMATE
tio-rpc -s /3 vector.data.decimation u32:$DECIMATE

# Collect data
tio-record data.bin



