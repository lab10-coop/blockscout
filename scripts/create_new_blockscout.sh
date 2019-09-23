set -e
set -u

PS3='Prod or Testnet?'
options=("blockscout_prod" "blockscout")

select opt in "${options[@]}"
do
    case $opt in
        "blockscout_prod")
	    break
            ;;
        "blockscout")
	    break
            ;;
    esac
done

read -p 'name of the database, username and password: (ex. tau1, sigma1)' var

dbpasswd="<REPLACE WITH THE PASSWORD YOU CHOSE>"
uname="postgres"
db="explorer_dev"

echo "This a script for making a new $var Blockscout instance."

#cd /home/$var/blockscout
cd /home/$var/$opt

cp apps/explorer/config/dev.secret.exs.example apps/explorer/config/dev.secret.exs

cp apps/block_scout_web/config/dev.secret.exs.example apps/block_scout_web/config/dev.secret.exs

sed -i -e "s/$dbpasswd/$var/g" apps/explorer/config/dev.secret.exs

sed -i -e "s/$uname/$var/g"  apps/explorer/config/dev.secret.exs

sed -i -e "s/$db/$var/g"  apps/explorer/config/dev.secret.exs

mix do deps.get, local.rebar --force, deps.compile, compile

mix do ecto.create, ecto.migrate

cd apps/block_scout_web/assets; npm install && node_modules/webpack/bin/webpack.js --mode production; cd -

cd apps/explorer && npm install; cd -

cd apps/block_scout_web

mix phx.gen.cert blockscout blockscout.local; cd -
