data: gitty.tgz toe.tgz rdf.tgz

image:
	docker build --tag vre4eic/gender-demo-data .

gitty.tgz: data/storage config-enabled/network.pl
	tar czf gitty.tgz data/storage config-enabled/network.pl
toe.tgz: 
	tar czf toe.tgz toe
rdf.tgz:
	tar czf rdf.tgz data/RDF
