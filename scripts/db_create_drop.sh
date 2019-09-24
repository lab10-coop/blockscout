set -e
set -u


read -p 'postgres users/database name: ' var

echo 'Do you want to create or drop a user/database? '
options=("createuser" "dropuser" "createdb" "dropdb" "Change database ownership")

select opt in "${options[@]}"
do
    case $opt in
        "createuser")
	    break
            ;;
        "dropuser")
	    break
            ;;
 	"createdb")
	    break
            ;;
        "dropdb")
	    break
            ;;
	"Change database ownership")
	    sudo -u postgres psql -c "ALTER DATABASE postgres OWNER TO $var"
	    echo "database owner changed"
	    exit
            ;;
    esac
done

sudo -u postgres $opt $var;

exit

