# Constellation-Ready Magnetometer Logging Instructions
*Matthew G. Finley, Chris Piker, Jason Homann, and David M. Miles*
*Last Updated: 16 February 2023*

## Initial Setup
1. Log into r-lnx715.physics.uiowa.edu using X2Go
2. Install and make the twinleaf-io codebase using:
    1. git clone https://github.com/twinleaf/tio-tools.git
    2. cd tio-tools
    3. git submodule update --init
    4. make PREFIX=$HOME/tio-tools
    5. make install PREFIX=$HOME/tio-tools (This step throws an error, but still seems necessary?)
    6. export PATH=$HOME/tio-tools/bin:$PATH

3. NOTE: Step 6 must be repeated in every fresh terminal window that needs to run a tio command

##  Setting Up the Listener
1. Identify which tty device is associated with the Sync4 box
    * Lots of techniques online for this, but it seems to consistently be ttyACM0 for me
2. cd ~/tio-tools
3. tio-proxy /dev/ttyACM0
    * This last step will have to be repeated until the only output is “Initialized. 4 sockets listening, 1 sensors, 64 max clients”.
    * If any other lines are output, can’t collect data and need to debug.

## Setting Up the VMRs and Taking Data
1. Open new terminal window, repeat steps (d)-(f) from ‘Initial Setup’
2. cd ~/tio-tools
3. tio-rpc -s /0 vector.data.decimation u32:4
    * Repeat this line for /0 to /3 for all 4 sensors.
    * Sampling Frequency = 800 Hz / 4 = 200 Hz
    * Divisor must be an integer value
4. tio-record File_Name.tio
    * It takes about 15 seconds to finally start collecting, so take that into account for when you want to collect for a certain amount of time
    * Records data until the user enters Ctrl+C

## Parsing Data for MATLAB Use
1. tio-logparse File_Name.tio
    * File saved in tio-tools directory

