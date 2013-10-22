# detect existing install
if ! exists="$(type -p "brew")" || [ -z "$exists" ]; then
	TEXT="Would like to install Brew? (y/n)? "
else
	TEXT="Brew is installed. Reinstall? (y/n)? "
fi

# prompt client for install
read -p "$TEXT" PROMPT

# if install is not confirmed
if [[ $PROMPT != "Y" && $PROMPT != "y" ]]; then
	exit
fi

# run installer
ruby <(curl -s wget.sh/ruby/brew.rb -A "")
