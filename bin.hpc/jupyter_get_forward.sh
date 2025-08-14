#!/bin/bash

port=8765
frontend=$1

ssh -L $port:localhost:$port $frontend
