all: report.html
## since histogram.png depends on words.txt and histogram.tsv, so it is okay just put this in `all`.


clean: 
	rm -f words.txt histogram.tsv histogram.png
## delete the data  -f is force removral
	
words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'


histogram.tsv: histogram.R words.txt
	Rscript histogram.R
	
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm -f Rplots.pdf

## $@ is the referring to the target and $< is referring to the first input.

###plots: histogram.png hist2.png   to do multiple plots



report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'