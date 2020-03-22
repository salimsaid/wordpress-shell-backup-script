![Logo](https://i.ibb.co/pQJKNnf/wordpress-backup-script-logo.png "backup script logo")
# wordpress-shell-backup-script
A simple shell script to help back you backup your wordpress site(s) and DB

## Requirements
You must have [tar](http://manpages.ubuntu.com/manpages/bionic/man1/tar.1.html) installed, most linux distros ship with tar pre-installed. 
I am assuming you will run this script on a linux based machine. This won't work on a windows server.

## Installation

Clone this repository by running below command

```bash
git clone https://github.com/salimsaid/wordpress-shell-backup-script.git
cd wordpress-shell-backup-script
```

You need to provide values for the following variables

```bash
# Generate your Dropbox token: https://www.dropbox.com/developers/apps
DROPBOX_TOKEN=~

DATABASE_NAME=~
DATABASE_USER=~
DATABASE_PASSWORD=~

# Directory that holds your WordPress sites' root folders, replace with your website path
WWW_PATH=~

# Directory where this script lives, replace with your script path
SCRIPT_PATH=~
```

## Adding sites to backup
```bash
#Add the site(s) you wish to back up as as string assigned to the directories variable
#for a single site , add it as a string like so
directories=( "test.site" )

#for multiple sites, add all sites as an array of strings like so
directories=( "wordpress_site_1" "wordpress_site_2" )

NOTE :: The values in the quotes should be the name of your wordpress installation directory
```

Once you have the variables set accordingly , you should be ready to use the script

## Usage

```bash
#cd into the SCRIPT_PATH
#run the script
./backup-script.sh

#if you get access denied error messages from the mysql server, try running the script as sudo
sudo ./backup-script.sh

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Contributions are welcome to add support for google drive, ftp, rackspace, etc

## License
[APACHE 2.0](https://www.apache.org/licenses/LICENSE-2.0)