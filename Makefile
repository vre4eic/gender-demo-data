local: localrun

image:
	docker build --tag vre4eic/gender-demo-data .

localinit: 
	docker run -v $(PWD)/data:/data vre4eic/swish:vre --add-config auth_http.pl data.pl logging.pl provenance.pl rdf.pl r_serve.pl user_profile.pl landing.pl

localrun: localinit
	docker run -it -p3053:3050 -v vre4eic_gender_r_volume:/rserve -v $(PWD)/data:/data vre4eic/swish:vre 

