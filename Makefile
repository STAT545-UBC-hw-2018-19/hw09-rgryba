all: report.html

words.txt: /usr/share/dict/words
	cp $< $@

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html violin.png violin.tsv

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
	
violin.tsv: violin.r words.txt
	Rscript $<

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

# words.txt:
	#Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
