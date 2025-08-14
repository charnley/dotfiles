#!/bin/bash

# Select partition
parition=$1

# Get a node for the work day
srun -p $partition --time=08:00:00 --ntasks-per-node 8 --pty bash
