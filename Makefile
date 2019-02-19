.PHONY: sync_jupyter_imgs build build_rmd build_jupyter clean clean_rmd clean_jupyter

build: build_rmd sync_jupyter_imgs markdowns_from_jupyter
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

build_rmd: _posts/2018-08-14-install-sparkR.markdown

_posts/2018-08-14-install-sparkR.markdown: Rmd/2018-08-14-install-sparkR.Rmd
	scripts/processRmds.R Rmd/2018-08-14-install-sparkR.Rmd
	cp Rmd/2018-08-14-install-sparkR.md _posts/2018-08-14-install-sparkR.markdown

sync_jupyter_imgs:
	rsync -avu --delete "jupyter/jupyter_imgs/" "assets/jupyter_imgs/"

jupyter_notebooks = 2018-09-11-AWS-CLI-And-S3\
	2018-10-06-Serving-Model\
	2018-11-12-install-pytorch-with-conda\
	2019-02-15-Train-Test-Model\
	2019-02-16-How-to-choose-best-model\
	2019-02-17-Bias-Variance-Trade-Off\
	2019-02-19-Classification

jupyter2markdown: $(jupyter_notebooks)

$(jupyter_notebooks):
	echo notebook: "$@"
	jupyter nbconvert --to markdown jupyter/$@.ipynb
	python scripts/move_jupyter_md_to_posts.py $@

clean: clean_rmd clean_jupyter

clean_rmd:
	if [ -e Rmd/*_files ]; then rm -R Rmd/*_files; fi
	if [ -e Rmd/metastore_db ]; then rm -R Rmd/metastore_db; fi

clean_jupyter:
	rm jupyter/*.md

