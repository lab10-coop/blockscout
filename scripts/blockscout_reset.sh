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

read -p 'name of the user where blockscout is in. (ex. tau1, sigma1)' var

echo "This script resets the whole database of $var Blockscout."

echo "changed into blockscout folder"
cd /home/$var/$opt

systemctl stop $var-blockscout

echo "Please check first if the database name, user and password is set correctly in dev.secret.exs. If yes, press Enter." 

cat apps/explorer/config/dev.secret.exs
read -p "$*"

mix do ecto.drop, ecto.create, ecto.migrate

systemctl start $var-blockscout

echo "Database reset is done." 
