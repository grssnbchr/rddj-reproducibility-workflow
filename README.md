# A workflow for reproducible and transparent data journalism with R and GitHub

This repo is tutorial & example at the same time, yay!

The goal of this workflow is to automagically upload your knitted RMarkdown file to a GitHub Page and to "build" your R code into a zipped folder
which can be downloaded by your readers. Ideally, you would reference this zipped folder from within your knitted RMarkdown. 

Note: The repo from which the knitted RMarkdown is served to the GitHub Page can also be private! 

## Steps

### Step 0

Init an empty repository & and add remote:
```
mkdir reproducibility-workflow
cd reproducibility-workflow
git init
git remote add origin https://github.com/srfdata/reproducibility-workflow.git (replace this with your account and repo, of course)
```

Add a `.gitignore` to ignore standard R output files & project files as well as the `tmp` folder we'll need for building
```
.Rdata
.Rhistory
.Rprofile
main.html
output/*
tmp
```

### Step 1 (repetitive)

All your "productive" R code goes into one RMarkdown file, but you can include source files (see `main.Rmd`).

You can work with your repo as you would with any other, doing stuff like
```
git add
git commit
git push
...
```

### Step 2

Now you want to publish your RMarkdown, and, ideally, your whole R script (together with the input files) on GitHub Pages. 

Initially, and only once, you need to do the following in your working directory:

* Start a new branch gh-pages

```
git checkout -b gh-pages
```

* remove everything except gitignore (need to enable an extension in Bash shells in order for this command to work)
```
shopt -s extglob
git rm -rf !(.gitignore)
git add -u
```

* make an initial commit
```
git commit -m "first commit to gh-pages branch"
```

### Step 3
For deployment, we want the following: 

* The knitted RMarkdown file (`main.html`) should be pushed as `ìndex.html`, so it is shown on the GitHub Page
* The R code and the input files should be made available for download as a **zipped folder**, so everyone can rerun the RMarkdown and/or modify the code and produce the output folder.

In order to automate this deployment process, we create a little shell script.

First, make sure you are in the master branch
```
git checkout master
```

Then, fire up your favorite editor and create a shell script called `deploy.sh` in the top folder, with the following content:

```
#!/bin/bash
# make temporary copy of the stuff we want to commit in with all data we need in build
mkdir tmp
cp main.Rmd tmp/
cp -r input tmp/
cp processData.R tmp/ # replace this with the name your subroutines and add more, if needed
# switch to gh-pages branch
git checkout gh-pages
# rename index file (the processed main.Rmd) from master branch
mv main.html index.html
# make folder for rscript
mkdir rscript
# copy over necessary scripts from master branch 
cp -r tmp/* rscript/

# zip the rscript folder
zip -r rscript.zip rscript
# remove the rscript folder
rm -rf rscript
# remove temporary folder
rm -rf tmp
# add everything for committing
git add .
# commit in gh-pages
git commit -m "build and deploy to gh-pages"
# push to remote:gh-pages
git push origin gh-pages 
# checkout master again
git checkout master
```
At the end, make the script executable 
```
chmod 755 deploy.sh
```

### Step 4 (repetitive)

Now, every time you want to deploy your updated RMarkdown and your R script to your GitHub page, you can 

```
./deploy.sh
```

And your knitted RMarkdown will magically find its way into *username*.github.io/*reponame*.
Note: This also works when *reponame* is a private repo!