#!/bin/bash

########
# COLORS
########
NORMAL="\033[0m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BROWN="\033[0;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
LIGHT_BLUE="\033[1;34m"
LIGHT_YELLOW="\033[1;33m"
WHITE="\033[1;37m"
BLACK="\033[0;30m"
MAGENTA="\033[1;35m"
LIGHT_CYAN="\033[1;36m"
LIGHT_GRAY="\033[0;37m"
GRAY="\033[01;30m"
BOLD="\033[1m"
UNDERSCORE="\033[4m"
REVERSE="\033[7m"

CURRENT_FOLDER=`pwd`
FULLFILE="your_file"
FILENAME="${FULLFILE##*/}"
EXTENSION="${FILENAME##*.}"
FILENAME="${FILENAME%.*}"

# @TODO : get file by parameter and destination email insteaqd inserting them by hand :)

########
# @TODO VERIFY FILE EXISTS
########
echo -e "${YELLOW}Vérification du fichier${NORMAL}"

mkdir $FILENAME
SPLIT_FILENAME="${FILENAME}/${FILENAME}_"

# we split to 900M as Firefox send accepts 1G maximum
split -b 900m "${FULLFILE}" "${SPLIT_FILENAME}"

cd $FILENAME
for file in * ; do 
    echo -e "${LIGHT_YELLOW}Envoi du fichier ${file} à Firefox send${NORMAL}"
    ffsend upload $file
    # @TODO send the klink via mail
    echo ''
done

cd ${CURRENT_FOLDER}
echo ''
echo -e "${LIGHT_RED}Nettoyage du dossier temporaire${NORMAL}"
DELETE_VAR="`rm -rf ${FILENAME}`"

echo ''
echo -e "${GREEN}-- FINISHED --${NORMAL}"


