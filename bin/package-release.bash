#! /bin/bash

echo ========================================
echo = .... package a ReadySET release .... =
echo = usage: package-release.bash TAGNAME  =
echo = TAGNAME must be an existing CVS tag  =
echo ========================================


version=$1
topdir=ReadySET-`echo $1 | sed s/v//g | sed s/_/-/g`

echo ========================================
echo Packaging version: $version
echo Top directory name: $topdir
echo ========================================


cvs export -d tmp-export -r $1 readyset/www

mkdir  -p /tmp/readysetbuild
mv tmp-export /tmp/readysetbuild/$topdir
cd /tmp/readysetbuild
rm -rf $topdir/words-of-wisdom
perl -p -i -e 's|/branding/images/sstree/||' $topdir/templates/css/*.css 
perl -p -i -e 's|/branding/images/sstree|css|' $topdir/templates/js/*.js
perl -p -i -e 's|/nonav/||' $topdir/*.html
tar cfz $topdir.tgz $topdir
zip -9 -r $topdir.zip $topdir
cd -
mv /tmp/readysetbuild/$topdir.zip .
mv /tmp/readysetbuild/$topdir.tgz .
rm -rf /tmp/readysetbuild



