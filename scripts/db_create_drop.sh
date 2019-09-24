set -e
set -u



T1='Do you want to create or drop a user? '
options=("createuser" "dropuser")

select opt in "${options[@]}"
do
    case $opt in
        "createuser")
	    break
            ;;
        "dropuser")
	    break
            ;;
    esac
done


read -p 'postgres users name: ' user

sudo -u postgres $opt $user;



T2='Do you want to create a create or drop a database? '
options2=("createdb" "dropdb")

select opt2 in "${options2[@]}"
do
    case $opt2 in
        "createdb")
	    break
            ;;
        "dropdb")
	    break
            ;;
    esac
done

read -p 'postgres users name: ' db

sudo -u postgres $opt2 $db;

exit

