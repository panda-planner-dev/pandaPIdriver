#!/bin/bash

DOMAINFILE=$1
PROBLEMFILE=$2
PLANFILE=$3
TIME=$4
MEMORY=$5
RANDOMSEED=$6

if [ a$RANDOMSEED == a ] ; then
	RANDOMSEED=42
fi
if [ a$TIME == a ] ; then
	TIME=1800
fi

/planner/pandaPIparser/pandaPIparser $DOMAINFILE $PROBLEMFILE $PROBLEMFILE.htn
/planner/pandaPIgrounder/pandaPIgrounder -DE $PROBLEMFILE.htn $PROBLEMFILE.sas
/planner/pandaPIengine/build/pandaPIengine --suboptimal -g none $PROBLEMFILE.sas -S $RANDOMSEED -t $TIME | tee $PLANFILE
