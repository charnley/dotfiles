
# Quick local usage

https://stackoverflow.com/questions/38466190/cant-connect-to-postgresql-on-port-5432


    You have to edit pg_hba.conf to accept all requests within the network
    #TYPE  DATABASE        USER            ADDRESS                 METHOD
    host    all             all             0.0.0.0/0                trust
    host    all             all             ::1/128                  trust

    postgresql.conf
    listen_addresses = '*'
    max_connections = 100 # (change requires restart)


# Setup

    # init
    initdb -D /large/file/system

    # run
    postgres -D /large/file/system
