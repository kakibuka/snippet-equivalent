#!/usr/bin/env bash
set -x

PROJECT_ROOT=$(dirname $(realpath ${BASH_SOURCE[0]}))

if [ ! -e ${PROJECT_ROOT}/docs ]; then
  mkdir ${PROJECT_ROOT}/docs
fi

cd ${PROJECT_ROOT}/template
snippets=()
for i in ${PROJECT_ROOT}/snippets/*; do
  src_path=${PROJECT_ROOT}/docs/$(basename $i)
  snippets+=($(basename $i))
  if [ ! -e $src_path ]; then
    mkdir $src_path
  fi
  ruby ${PROJECT_ROOT}/render-template.rb $i/data.yml ${PROJECT_ROOT}/template/snippets.mustache > $src_path/index.html
done

echo ${snippets[@]}
cat <<data | mustache - ${PROJECT_ROOT}/template/index.mustache > ${PROJECT_ROOT}/docs/index.html
---
snippets:
$(for i in ${snippets[@]}; do echo "  - $i"; done)
---
data
