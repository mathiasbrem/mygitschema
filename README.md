Example:

1 - Download the script:

git clone https://github.com/mathiasbrem/mygitschema.git

2 - Edit mygitschema.sh

CFG="/etc/mygitschema.d/"; #configuration directory
DIRECTORY="/usr/local/mygitschema"; #target directory to dump tables
USER="BACKUP_GITSCHEMA" #user
PASS="PASSWORD@(**&@$" #password


2 - Create your envirioment configuration files:

/etc/mygitschema.d/ecommerce_devel.cfg

cluster='ecommerce'
hostname='ecommercedb_devel'
envirioment='devel'

....... n .cfg files...

3 - Configure crontab to schedule mygitschema.sh

4 - Create a repository on your git server

5 - Configure the repository on /etc/mygitschema.d/
