# prompt client for install
read -p "Would like to install NPM? (y/n)? " PROMPT

# if install is not confirmed
if [[ $PROMPT != "Y" && $PROMPT != "y" ]]; then
	exit
fi

# detect existing install
if ! exists="$(type -p "brew")" || [ -z "$exists" ]; then
	read -p "This installation requires Brew. Would like to install it? (y/n)? " PROMPT

	# if install is not confirmed
	if [[ $PROMPT != "Y" && $PROMPT != "y" ]]; then
		exit
	fi

	# run installer
	ruby <(curl -s wget.sh/ruby/brew.rb -A "")
fi

# installer
brew install npm >& /dev/null

echo "NPM is installed."
