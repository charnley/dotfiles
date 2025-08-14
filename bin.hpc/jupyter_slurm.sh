#!/bin/bash

# select port
port=8765
frontend=puppetmaster

# Forward port to frontend node
ssh -N -f -R $port:localhost:$port $frontend

# Load modules?
jupyter lab --no-browser --port $port
