read -p "Welcome to web.sh. What would you like to install: " NAME

if [ "$NAME" == "exit" ] || [ "$NAME" == "" ]; then
	echo "Very well. Have a nice day!"
else
	bash <(curl -s wget.sh/${NAME/ /+} -A "")
fi