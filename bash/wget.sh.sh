# prompt client for install
read -p "Would like to install wget.sh? (y/n)? " PROMPT

# if install is not confirmed
if [[ $PROMPT != "Y" && $PROMPT != "y" ]]; then
	exit
fi

echo "bash <(curl https://wget.sh -s -A '')" > /usr/local/bin/wget.sh
chmod +x /usr/local/bin/wget.sh

echo "wget.sh is installed."
