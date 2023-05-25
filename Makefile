sandbox = 'numbat_sandbox'
minimal_sand = 'minimal_sandbox'
target = 'numbat_singularity'
minimal_target = 'ThisMinimal'
version="1.0"
lunarc_path = '/projects/fs1/common/software/numbat_singularity/'
buildScript = 'Numbat_analysis.txt'
minimal_buildScript = "Minimal.txt"

user = `whoami`
all: build toLunarc

restart:
ifneq ($(wildcard $(target)),) # file exists ## https://stackoverflow.com/questions/5553352/how-do-i-check-if-file-exists-in-makefile-so-i-can-delete-it
	mv ${target} OLD_${target}
endif
ifneq ($(wildcard $(sandbox)),)
	mv ${sandbox} OLD_${sandbox}
endif
	sudo singularity build --sandbox ${sandbox} ${buildScript} 
build:
	sudo chown -R ${user}:${user} ${sandbox}
	rm -f ${target}_${version}
	sudo singularity build ${target}_${version}.sif ${sandbox}
toLunarc:
	rsync -I --progress ${target}_${version}.sif stefanl@aurora-ls2.lunarc.lu.se:${lunarc_path}/${version}/
download_data: 1000G_hg38 genome1K

numbat_data:
ifeq ($(wildcard numbat_data),)
	mkdir numbat_data
endif
1000G_hg38: numbat_data
ifeq ($(wildcard numbat_data/1000G_hg38/.),)
	cd numbat_data && get http://pklab.med.harvard.edu/teng/data/1000G_hg38.zip
	cd numbat_data && unzip 1000G_hg38.zip 
	rm numbat_data/1000G_hg38.zip
endif

genome1K: numbat_data
ifeq ($(wildcard numbat_data/genome1K.phase3.SNP_AF5e2.chr1toX.hg38.vcf),)
	cd numbat_data && wget https://sourceforge.net/projects/cellsnp/files/SNPlist/genome1K.phase3.SNP_AF5e2.chr1toX.hg38.vcf.gz
	cd numbat_data && gzip -d genome1K.phase3.SNP_AF5e2.chr1toX.hg38.vcf.gz
endif

dataToLunarc:
	rsync -r -I --progress numbat_data stefanl@aurora-ls2.lunarc.lu.se:${lunarc_path}
restart_min:
	sudo singularity build --sandbox ${minimal_sand} ${minimal_buildScript}
build_min:
	sudo chown -R ${user}:${user} ${minimal_sand}
	rm -f ${minimal_target}
	sudo singularity build ${minimal_target} ${minimal_sand}
