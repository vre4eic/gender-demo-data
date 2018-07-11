local: localrun
data: gitty.tgz rdf.tgz toe

image:
	docker build --tag vre4eic/gender-demo-data .

gitty.tgz: data/storage config-enabled/gender.pl
	tar --create --gzip --file gitty.tgz data/storage config-enabled/gender.pl
rdf.tgz:
	tar --create --gzip --file rdf.tgz data/RDF

toe:	data/toe FORCE 
	cd data/toe; git co V1.0.1

data/toe:
	git clone https://github.com/vre4eic/gender-toe-data.git data/toe

localdata: data/toe
	mkdir -p data
	cd data; tar xzf ../rdf.tgz; tar xzf ../gitty.tgz; cp ../passwd .

localinit: localdata
	docker run -v $(PWD)/data:/data vre4eic/swish:vre --add-config auth_http.pl data.pl logging.pl provenance.pl rdf.pl r_serve.pl user_profile.pl landing.pl

localrun: localinit
	docker run -it -p3053:3050 -v vre4eic_gender_r_volume:/rserve -v $(PWD)/data:/data vre4eic/swish:vre 

FORCE:

