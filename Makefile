all: gitty.tgz toe.tgz rdf.tgz

gitty.tgz: data/storage config-enabled/network.pl
	tar czf gitty.tgz data/storage config-enabled/network.pl
toe.tgz: 
	tar czf toe.tgz toe
rdf.tgz:
	tar czf rdf.tgz data/RDF
