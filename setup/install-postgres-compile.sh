#!/bin/bash


install_dir=$HOME/opt/postgres
download_dir=$HOME/opt/download

cd $download_dir
git clone --depth 1 https://github.com/postgres/postgres.git postgres.git

cd postgres.git
./configure --prefix $install_dir --disable-rpath
export LD_RUN_PATH='$ORIGIN/../lib'
make -j 4
make install



# # Quick local usage

# https://stackoverflow.com/questions/38466190/cant-connect-to-postgresql-on-port-5432


#     You have to edit pg_hba.conf to accept all requests within the network
#     #TYPE  DATABASE        USER            ADDRESS                 METHOD
#     host    all             all             0.0.0.0/0                trust
#     host    all             all             ::1/128                  trust

#     postgresql.conf
#     listen_addresses = '*'
#     max_connections = 100 # (change requires restart)


# # Setup

#     # init
#     initdb -D /large/file/system

#     # run
#     postgres -D /large/file/system
