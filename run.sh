version="1.0"
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
singularity run  -B/mnt:/mnt -B${SCRIPTPATH}/numbat_data:/data ${SCRIPTPATH}/numbat_singularity_${version}.sif
