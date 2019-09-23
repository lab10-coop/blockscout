set -e
set -u

read -p 'name of the database, username and password: (ex. tau1, sigma1)' var

echo "This a script for updating a existing $var Blockscout instance."
 
echo "Make sure the service is stopped, if not, this script will stop the service." 

systemctl stop $var-blockscout

echo "stopping the service"

cd /home/$var/blockscout

cat apps/explorer/config/dev.secret.exs

rm -rf apps/block_scout_web/priv/static

mix do deps.get, local.rebar --force, deps.compile, compile

mix do ecto.migrate

cd apps/block_scout_web/assets; npm install && node_modules/webpack/bin/webpack.js --mode production; cd -

cd apps/explorer && npm install; cd -

systemctl start $var-blockscout

echo "starting the service"

echo "all done"



