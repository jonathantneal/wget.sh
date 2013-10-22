if [ -n "$APPS" ]; then
	echo -e "\nTry one of the following apps:\n"
	echo -e $APPS
else
	echo "An app like that could not be found.\nVisit github.com/jonathantneal/wget.sh to report the issue."
fi

echo ""

read -p "What would you like to install: " NAME

if [ "$NAME" == "exit" ] || [ "$NAME" == "" ]; then
	echo "Very well. Have a nice day!"
else
	bash <(curl -s wget.sh/${NAME/ /+} -A "")
fi
