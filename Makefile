%.html: %.md
	Rscript -e "rmarkdown::render(\"$<\")"
