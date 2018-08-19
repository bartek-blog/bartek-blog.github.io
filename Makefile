.PHONY: build_rmd serve clean_rmd

build: build_rmd clean_rmd
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

build_rmd: _posts/2018-08-14-install-sparkR.md

_posts/2018-08-14-install-sparkR.md: Rmd/2018-08-14-install-sparkR.Rmd
	scripts/processRmds.R Rmd/2018-08-14-install-sparkR.Rmd
	cp Rmd/2018-08-14-install-sparkR.md _posts/2018-08-14-install-sparkR.md 

clean_rmd:
	if [ -e Rmd/*_files ]; then rm -R Rmd/*_files; fi
	if [ -e Rmd/metastore_db ]; then rm -R Rmd/metastore_db; fi

