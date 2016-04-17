#!/bin/bash
#########################################################
#-------------------------------------------------------#
# Developed by: Mathias Brem Garcia     ----------------#
#-------------------------------------------------------#
#########################################################
#
#SET VARIABLES
#
CFG="/etc/mygitschema.d/";
DIRECTORY="/usr/local/mygitschema"; #target directory to dump tables
USER="BACKUP_GITSCHEMA" #user
PASS="SENHAGITSCHEMA@(**&@$" #password
DATE=$(date +"%Y-%m-%d %H:%M:%S");
#
# LOOP CFG CLUSTERS
#
for cfg in $(ls $CFG/*.cfg);do
  #
  #SET CURRENT CLUSTER VARIABLES
  #
  source $cfg;
  #
  #LOOP DATABASES
  #
  for database in $(mysql -u$USER -h$hostname -p$PASS -s -e"select distinct table_schema from information_schema.tables where table_schema not in('mysql','information_schema','performance_schema')");do
    #
    #LOOP TABLES
    #
    echo "CLUSTER: $cluster DATABASE: $database ENVIRIOMENT:$envirioment";
    for table in $(mysql -u$USER -p$PASS -h$hostname -s -e"show tables in $database" );do
      if [ ! -d "$DIRECTORY/$envirioment/$cluster/$database" ];then
	mkdir -p "$DIRECTORY/$envirioment/$cluster/$database"
      fi;
      echo "CLUSTER: $cluster DATABASE: $database TABLE: $table ENVIRIOMENT:$envirioment";
      mysqldump -u$USER -p$PASS -h$hostname $database $table --no-data --skip-opt --single-transaction | sed -e '/Dump completed on/d' > $DIRECTORY/$envirioment/$cluster/$database/$table.sql
    done; # END LOOP TABLES
    mysqldump -u$USER -p$PASS -h$CLUSTER $database --no-create-info --no-data --skip-opt --single-transaction --routines | sed -e '/Dump completed on/d' > $DIRECTORY/$envirioment/$cluster/$database/routines.sql
    #
    #COMMIT CHANGES TO REPOSITORY
    #
    cd $DIRECTORY
    git add .
    git commit -m "Cluster:$cluster Database: $database | Database Schema Updated at: $DATE"
    git push
    done; #END LOOP DATABASES
done; #END LOOP CLUSTERS




