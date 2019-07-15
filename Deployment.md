#Blockscout manual install

###Erlang & Elixir:

`wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb`

`sudo dpkg -i erlang-solutions_1.0_all.deb`

`sudo apt-get update`

`sudo apt-get install esl-erlang elixir`


To test the Erlang installation: 
`vi helloworld.erl`

add the following contents:

```
% hello world program
-module(helloworld).
-export([start/0]).

start() ->
io:fwrite("Hello World!\n").
```

Now compile the hello world program using below command: 
`erlc helloworld.erl`

The above command will create a file helloworld.beam in the current directory. You can run your program now.

`erl -noshell -s helloworld start -s init stop`

Hello World!

To test Elixir:
`elixir --version`

###PostgreSQL install

`sudo apt update`

`sudo apt install postgresql postgresql-contrib`


Switch over to the postgres account on your server by typing:
`sudo -i -u postgres`


You can now access a Postgres prompt immediately by typing:
`psql`


Inside the psql shell you need to give the DB user postgres a password:

`ALTER USER postgres PASSWORD 'newPassword';`



To exit:
 `\q`


###Node.js 10

`sudo apt-get install curl python-software-properties`

`curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -`


test:
`nodejs --version`

###Install GCC compiler

`sudo apt install automake libtool inotify-tools gcc`

`gcc --version`


###GMP installation:

`sudo apt-get update`

`sudo apt-get install g++ m4 zlib1g-dev make p7zip`

`mkdir math && cd math`

`wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2`

`tar -xvjf gmp-6.1.2.tar.bz2`

`cd Math/gmp`

`./configure`

When the configuration script ends, type:

`make`

When make ends, type:

`make check`

If all checked out, type:

`sudo make install`

Note that gmp should be installed to /usr/local/...


###Blockscout manual deploying:

`git clone https://github.com/poanetwork/blockscout`

`cd blockscout`

Setup default configurations:
`cp apps/explorer/config/dev.secret.exs.example apps/explorer/config/dev.secret.exs`

`cp apps/block_scout_web/config/dev.secret.exs.example apps/block_scout_web/config/dev.secret.exs`

Update `apps/explorer/config/dev.secret.exs` with nano or vi

```
Linux: Update the database username and password configuration
Mac: Remove the username and password fields
```

If you have deployed previously, delete the `apps/block_scout_web/priv/static` folder. This removes static assets from the previous build.

Install dependencies. `mix do deps.get, local.rebar --force, deps.compile, compile`

If not already running, start postgres: `systemctl start postgresql`

Create and migrate database `mix do ecto.create, ecto.migrate`

Note: If you have run previously, drop the previou.explores database `mix do ecto.drop, ecto.create, ecto.migrate`

Install Node.js dependencies:

`cd apps/block_scout_web/assets; npm install && node_modules/webpack/bin/webpack.js --mode production; cd -`

`cd apps/explorer && npm install; cd -`

 Enable HTTPS in development. The Phoenix server only runs with HTTPS.

 `cd apps/block_scout_web`

 `mix phx.gen.cert blockscout blockscout.local; cd -`

Add blockscout and blockscout.local to your /etc/hosts 

```
127.0.0.1 localhost blockscout blockscout.local

255.255.255.255 broadcasthost

::1 localhost blockscout blockscout.local

```


* If using Chrome, Enable  `chrome://flags/#allow-insecure-localhost` .

11.  Set your [environment variables] with systemd.  For example:

example:
```
[Unit]
Description=tau1 blockscout
After=network.target
[Service]
Type=simple
StandardOutput=journal
StandardError=journal
SyslogIdentifier=explorer
KillMode=process
TimeoutStopSec=60
Restart=on-failure
RestartSec=5
RemainAfterExit=no

User=tau1
Group=tau1

export COIN=ATS
export ETHEREUM_JSONRPC_VARIANT=parity
export ETHEREUM_JSONRPC_TRACE_URL=http://rpc-trace.sigma1.artis.network
export ETHEREUM_JSONRPC_HTTP_URL=http://rpc-trace.sigma1.artis.network
export ETHEREUM_JSONRPC_WS_URL=wss://ws.sigma1.artis.network
export NETWORK=246529
export SUBNETWORK='ARTIS sigma1'
export LOGO='/images/artis_sigma_logo.svg'
export METADATA_CONTRACT=0x5e5a1f6ca522ee68ddbe45b51f2a7cceb32985ee
export VALIDATORS_CONTRACT=0xAAA0000000000000000000000000000000000AAA
export SECRET_KEY_BASE=P2VzPXkTa5NEYJ8hBZKBLaM32yTkbYpVVS7GWJKAZQRtvKqXJvwPx2FcUvUcRkTA
export PORT=4100


Environment=SECRET_KEY_BASE=dzQUQeNV2gBw4VHc4aC2xsTyLeRLyZ5zw3tZBX5xZfRfwnj7K8w7pGB3xjykwbB9

Environment=DATABASE_URL=postgresql://tau1:tau1@localhost:5432/tau1



WorkingDirectory=/home/tau1/blockscout_prod
ExecStart=/usr/local/bin/mix phx.server

[Install]
WantedBy=multi-user.target
```

Now you can start it with systemctl and visit localhost:4100.

***Start without the ENV variables:***

Return to the root directory and start the Phoenix Server. mix phx.server

Now you can visit localhost:4000 from your browser.




###File to import not found or unreadable: fa-brands #675:


This error occurs for me with node v10.12.0 - the steps described above did not resolve it.

On further investigation, I discovered the missing "fa-brands.scss" file @imported by "app.scss" is present in version 5.1.0 of package "@fortawesome/fontawesome-free" but was removed in version 5.1.1 and all later versions.

I made the following change to "apps/block_scout_web/assets/package.json" to force version 5.1.0 to be used which resolved the issue.

   ` "@fortawesome/fontawesome-free": "^5.1.0-4",`

   ` "@fortawesome/fontawesome-free": "=5.1.0",`

It would appear some work on the app is needed for it to work with the later versions of "@fortawesome/fontawesome-free".








