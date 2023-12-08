all: report/_build/html/index.html

# count the words
results/isles.dat: scripts/wordcount.py data/isles.txt
	python scripts/wordcount.py --input_file=data/isles.txt \
		--output_file=results/isles.dat
results/abyss.dat: scripts/wordcount.py data/abyss.txt
	python scripts/wordcount.py --input_file=data/abyss.txt \
		--output_file=results/abyss.dat
results/last.dat: scripts/wordcount.py data/last.txt
	python scripts/wordcount.py --input_file=data/last.txt \
		--output_file=results/last.dat
results/sierra.dat: scripts/wordcount.py data/sierra.txt
	python scripts/wordcount.py --input_file=data/sierra.txt \
		--output_file=results/sierra.dat

# create the plots
results/figure/isles.png: scripts/plotcount.py results/isles.dat
	python scripts/plotcount.py --input_file=results/isles.dat \
		--output_file=results/figure/isles.png
results/figure/abyss.png: scripts/plotcount.py results/abyss.dat
	python scripts/plotcount.py --input_file=results/abyss.dat \
		--output_file=results/figure/abyss.png
results/figure/last.png: scripts/plotcount.py results/last.dat
	python scripts/plotcount.py --input_file=results/last.dat \
		--output_file=results/figure/last.png
results/figure/sierra.png: scripts/plotcount.py results/sierra.dat
	python scripts/plotcount.py --input_file=results/sierra.dat \
		--output_file=results/figure/sierra.png

# write the report
report/_build/html/index.html: report/count_report.ipynb \
	report/_toc.yml \
	report/_config.yml \
	results/figure/isles.png \
	results/figure/abyss.png \
	results/figure/last.png \
	results/figure/sierra.png
	jupyter-book build report

clean:
	rm -rf results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
	rm -rf results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	rm -rf report/_build/