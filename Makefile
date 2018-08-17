build:
	bundle exec jekyll build

build_rmd:
	scripts/processRmds.R Rmd/2018-08-14-install-sparkR.Rmd
	mv Rmd/2018-08-14-install-sparkR.md _posts
	rm -R  Rmd/2018-08-14-install-sparkR_files 

serve:
	bundle exec jekyll serve
