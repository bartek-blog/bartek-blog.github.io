build: build_rmd
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

.PHONY: build_rmd serve

build_rmd: _posts/2018-08-14-install-sparkR.md

_posts/2018-08-14-install-sparkR.md: Rmd/2018-08-14-install-sparkR.Rmd scripts/processRmds.R
	scripts/processRmds.R Rmd/2018-08-14-install-sparkR.Rmd
	mv Rmd/2018-08-14-install-sparkR.md _posts
	rm -R  Rmd/2018-08-14-install-sparkR_files 

