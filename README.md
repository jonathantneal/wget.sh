# wget.sh

**wget.sh** is a cloud-based app installer. Ask it for something &mdash; it will detect your system configuration, your package manager, and install it for you.

Just paste this into your terminal.

```sh
bash <(curl -s wget.sh)
```

You will be greeted with a friendly message.

```
Welcome to web.sh. What would you like to install:
```

Not sure what to install? Type `help` to get a list of available apps.

```
Welcome to web.sh. What would you like to install: help

Try one of the following apps:

· adium
· chrome
· droplr
...
```

Looking for a particular app? Type `help YOUR_APP_NAME` to search for matching apps.

```
Welcome to web.sh. What would you like to install: help op

Try one of the following apps:

· droplr
· imageoptim
· kaleidoscope
· opera

What would you like to install:
```

Unable find the app your looking for? Please [file an issue](https://github.com/jonathantneal/wget.sh/issues/new) or [contribute to this project](https://github.com/jonathantneal/wget.sh).
