set -e
set -u


echo "This script resets the whole database of $var Blockscout."

read -p 'name of the user where blockscout is in. (ex. tau1, sigma1)' var

echo "changed into blockscout folder"
cd /home/$var/blockscout

systemctl stop $var-blockscout

echo "Please check first if the database name, user and password is set correctly in dev.secret.exs. If yes, press Enter." 

cat apps/explorer/config/dev.secret.exs
read -p "$*"

mix do ecto.drop, ecto.create, ecto.migrate

systemctl start $var-blockscout

echo "Database reset is done." 
