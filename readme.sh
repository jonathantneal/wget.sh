read -p "Welcome to web.sh. What would you like to install: " NAME

if [ "$NAME" == "exit" ] || [ "$NAME" == "" ]; then
	echo "Have a nice day!"
else
	bash <(curl wget.sh/${NAME/ /+} -s -L -A "")
fi
