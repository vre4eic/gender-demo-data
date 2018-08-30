# To run locally without docker requires installed swipl and swish, than make default.

default: localdata localconfig localrun
dockerlocal: drun
dockerdata: gitty.tgz rdf.tgz

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

toe:
	git clone https://github.com/vre4eic/gender-toe-data.git toe
	cd toe; git co V1.0.1

data/storage: 
	tar xzf gitty.tgz; 

data/RDF:
	tar xzf rdf.tgz; 

localdata: toe data/storage data/RDF

localconfig: 
	cd ../swish/config-available; cp auth_http.pl data.pl logging.pl provenance.pl rdf.pl r_serve.pl user_profile.pl landing.pl ${ROOT_DIR}/config-enabled

localrun:
	../swish/daemon.pl --interactive --port=3052

gitty.tgz: FORCE
	tar --create --gzip --file gitty.tgz $(DD)/storage config-enabled/gender.pl
rdf.tgz: FORCE
	tar --create --gzip --file rdf.tgz $(DD)/RDF
image:
	docker build --tag vre4eic/gender-demo-data .

dinit: localdata
	docker run -v $(PWD)/data:/data vre4eic/swish:vre --add-config auth_http.pl data.pl logging.pl provenance.pl rdf.pl r_serve.pl user_profile.pl landing.pl

drun: localinit
	docker run -it -p3053:3050 -v vre4eic_gender_r_volume:/rserve -v $(PWD)/data:/data vre4eic/swish:vre 

FORCE:

