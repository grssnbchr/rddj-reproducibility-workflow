# A workflow for reproducible and transparent data journalism with R and GitHub

This repo is tutorial & example at the same time, yay!

## Steps

### 0

Init an empty repository & and add remote:
```
mkdir reproducibility-workflow
cd reproducibility-workflow
git init
git remote add origin https://github.com/srfdata/reproducibility-workflow.git
```

Add a .gitignore to ignore standard R output files & project files
```
.Rdata
.Rhistory
.Rprofile
*.html
output/*
```

All your "productive" R code goes into one RMarkdown file, but you can include source files (see `main.Rmd`).