VOLS="/Volumes"
TEMP="/tmp/$NAME"

# if link and no destination, set destination
if [[ -n "$LINK" && ! -n "$DEST" ]]; then
	if [[ "$LINK" =~ .*prefpane$ ]]; then
		DEST="/System/Library/PreferencePanes"
	else
		DEST="/Applications"
	fi
fi

# detect existing install
if [[ -n "$LINK" ]] && [[ -f "$DEST/$LINK" || -d "$DEST/$LINK" ]]; then
	TEXT="$NAME is installed. Install again? (y/n)? "
else
	TEXT="Would like to install $NAME? (y/n)? "
fi

# prompt client for install
read -p "$TEXT" PROMPT

# if install is not confirmed
if [[ $PROMPT != "Y" && $PROMPT != "y" ]]; then
	exit
fi

# prepare permissions
sudo -v

# prepare temporary directory
if [[ ! -d "$TEMP" ]]; then
	mkdir "$TEMP"
fi

# if download does exist
if [[ -f "$TEMP/download.tmp" ]]; then
	read -p "$NAME is downloaded. Download again? (y/n)? " PROMPT

	# if install is not confirmed
	if [[ $PROMPT == "Y" || $PROMPT == "y" ]]; then
		# download href
		curl -L -# "$HREF" -o "$TEMP/download.tmp"
	fi

# if download does not exist
else
	# alert client
	echo "Downloading $NAME."

	# download href
	curl -L -# "$HREF" -o "$TEMP/download.tmp"
fi

# alert client
echo "Installing $NAME."

# attempt to attach
yes | hdiutil attach -noautoopen -noverify -nobrowse -mountpoint "$VOLS/$NAME" "$TEMP/download.tmp" >& /dev/null

# if attached
if [[ -d "$VOLS/$NAME" ]]; then
	# set $FROM
	FROM="$VOLS/$NAME"

# otherwise
else
	# attempt to decompress zip
	unzip -q -u -d "$TEMP" "$TEMP/download.tmp" >& /dev/null;

	# attempt to decompress tar
	tar -C "$TEMP" -xvjf "$TEMP/download.tmp" >& /dev/null;

	# set $FROM
	FROM="$TEMP"
fi

# if download has package
if [[ -n "$MPKG" && -f "$FROM/$MPKG" ]]; then
	# install package
	sudo installer -s -pkg "$FROM/$MPKG" -target / >& /dev/null

	# alert client
	echo "$NAME is installed."

# if link
elif [ -n "$LINK" ]; then
	# copy link
	sudo cp -r "$FROM/$LINK" "$DEST/$LINK"

	# alert client
	echo "$NAME is installed."
else
	# alert client
	echo "$NAME could not be installed."
fi

if [[ -d "$VOLS/$NAME" ]]; then
	# attempt to detach
	hdiutil detach -quiet "$VOLS/$NAME"
fi

read -p "So, what would you like to install: " NAME

if [ "$NAME" == "exit" ] || [ "$NAME" == "" ]; then
	echo "Have a nice day!"
else
	bash <(curl https://wget.sh/${NAME/ /+} -A "" -L -s)
fi
