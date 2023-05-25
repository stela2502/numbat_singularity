SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
singularity shell --fakeroot -w -B/.:/mnt -B${SCRIPTPATH}/numbat_data:/data ${SCRIPTPATH}/numbat_sandbox/
