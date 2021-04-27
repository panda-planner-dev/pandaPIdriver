#!/bin/bash

BENCHMARKS=~/Workspace/temp/ipc-repo/total-order

if [ a$1 = a ] ; then
	ls $BENCHMARKS/*/ -d | cut -d/ -f 8
	exit 0
fi


if [ $1 == bench ] ; then
	shift
	PROB=$(ls $BENCHMARKS/$1*/* -d | grep -v domain | grep hddl | sed -n $2p)
	DOM=$(ls $BENCHMARKS/$1*/* -d | grep domain)
	
	if [  $(echo $DOM | wc -w) != 1 ] ; then
		DOM=$(ls $BENCHMARKS/$1*/* -d | grep domain | sed -n $2p)
	fi
	
	echo Running planner on Domain $(ls ~/Workspace/temp/ipc-repo/total-order/$1* -d | cut -d/ -f 8) Instance \#$2
else
	DOM=$1
	PROB=$2
fi

shift 2
if [ a$1 == agrounder ] ; then
	GROUNDERARGS=$2
	shift 2
fi
		
echo -e "\tDomain:" $DOM
echo -e "\tProblem:" $PROB

./pandaPIparser/pandaPIparser $DOM $PROB /tmp/panda.htn
./pandaPIgrounder/pandaPIgrounder -DE$GROUNDERARGS /tmp/panda.htn /tmp/panda.sas
./pandaPIengine/build/pandaPIengine /tmp/panda.sas $@ | tee /tmp/panda.plan

./pandaPIparser/pandaPIparser -c /tmp/panda.plan /tmp/panda.plan2
./pandaPIparser/pandaPIparser -v $DOM $PROB /tmp/panda.plan2
