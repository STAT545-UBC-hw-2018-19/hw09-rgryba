all: report.html report2.html

words.txt: /usr/share/dict/words
	cp $< $@

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html violin.png violin.tsv report2.md

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
	
violin.png: violin.R words.txt
	Rscript $<
	rm Rplots.pdf
	
violin.tsv: violin.R words.txt
	Rscript $<

report.html: report.Rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'
	
report2.html: report2.Rmd violin.tsv violin.png
	Rscript -e 'rmarkdown::render("$<")'

# words.txt:
	#Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
