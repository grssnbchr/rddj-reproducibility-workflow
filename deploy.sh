#!/bin/bash
# make temporary copy of the stuff we want to commit in with all data we need in build
mkdir tmp
cp main.Rmd tmp/
cp -r input tmp/
cp processData.R tmp/
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