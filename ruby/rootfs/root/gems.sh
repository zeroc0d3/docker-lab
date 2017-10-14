#!/bin/sh

RUBY=`which ruby`
RUBY_V=`ruby -v`
GEM=`which gem`
BUNDLER=`which bundler`

echo '-------------------------------------------------------------'
echo '## Ruby version: '
echo $RUBY_V
echo '-------------------------------------------------------------'
echo '## Path ruby in folder: '
echo $RUBY
echo '-------------------------------------------------------------'
echo '## Path gem in folder: '
echo $GEM

echo ''
echo 'Begin Installation'
echo '-------------------------------------------------------------'

$GEM install bundler
$BUNDLER install
