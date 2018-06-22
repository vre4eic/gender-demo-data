local: localrun
data: gitty.tgz toe.tgz rdf.tgz

image:
	docker build --tag vre4eic/gender-demo-data .

gitty.tgz: data/data/storage data/config-enabled/gender.pl
	tar --create --gzip --directory data --file gitty.tgz data/storage config-enabled/gender.pl
toe.tgz: 
	tar --create --gzip --directory data --file toe.tgz toe
rdf.tgz:
	tar --create --gzip --directory data --file rdf.tgz data/RDF

localdata:
	mkdir -p data
	cd data; tar xzf ../rdf.tgz; tar xzf ../gitty.tgz; tar xzf ../toe.tgz; cp ../passwd .

localinit: localdata
	docker run -v $(PWD)/data:/data vre4eic/swish:vre --add-config auth_http.pl data.pl logging.pl provenance.pl rdf.pl r_serve.pl user_profile.pl landing.pl

localrun: localinit
	docker run -it -p3053:3050 -v vre4eic_gender_r_volume:/rserve -v $(PWD)/data:/data vre4eic/swish:vre 

