.PHONY: build build_rmd build_jupyter clean clean_rmd clean_jupyter

build: build_rmd clean_rmd build_jupyter clean_jupyter
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

build_rmd: _posts/2018-08-14-install-sparkR.markdown

_posts/2018-08-14-install-sparkR.markdown: Rmd/2018-08-14-install-sparkR.Rmd
	scripts/processRmds.R Rmd/2018-08-14-install-sparkR.Rmd
	cp Rmd/2018-08-14-install-sparkR.md _posts/2018-08-14-install-sparkR.markdown

build_jupyter: _post/2018-09-11-AWS-CLI-And-S3.markdown _post/2018-10-06-Serving-Model.markdown

_post/2018-09-11-AWS-CLI-And-S3.markdown:
	jupyter nbconvert --to markdown jupyter/2018-09-11-AWS-CLI-And-S3.ipynb
	cp jupyter/2018-09-11-AWS-CLI-And-S3.header _posts/2018-09-11-AWS-CLI-And-S3.markdown
	cat jupyter/2018-09-11-AWS-CLI-And-S3.md >> _posts/2018-09-11-AWS-CLI-And-S3.markdown

_post/2018-10-06-Serving-Model.markdown:
	jupyter nbconvert --to markdown jupyter/2018-10-06-Serving-Model.ipynb
	cp jupyter/2018-10-06-Serving-Model.header _posts/2018-10-06-Serving-Model.markdown
	cat jupyter/2018-10-06-Serving-Model.md >> _posts/2018-10-06-Serving-Model.markdown

clean: clean_rmd clean_jupyter

clean_rmd:
	if [ -e Rmd/*_files ]; then rm -R Rmd/*_files; fi
	if [ -e Rmd/metastore_db ]; then rm -R Rmd/metastore_db; fi

clean_jupyter:
	rm jupyter/*.md

