#!/bin/bash

# This script will create a html report of latest git tag and previous git tag.

# find tag name with creation date
new_tag=$(git tag -l --sort=-creatordate --format='%(refname:short): %(creatordate:short)' | head -1)
pre_tag=$(git tag -l --sort=-creatordate --format='%(refname:short): %(creatordate:short)' | head -2 | tail -1)

#seperate tag name and date
latest_tag_name=$(echo $new_tag | awk -F ":" '{print $1}')
latest_tag_date=$(echo $new_tag | awk -F ":" '{print $2}')

pre_tag_name=$(echo $pre_tag | awk -F ":" '{print $1}')
pre_tag_date=$(echo $pre_tag | awk -F ":" '{print $2}')

#generate change logs
git log --stat $pre_tag_name...$latest_tag_name> ${latest_tag_name}_${pre_tag_name}_changelog.txt

# create commit diff report in html
pretty-diff $pre_tag_name..$latest_tag_name && mv /tmp/diff.html ${latest_tag_name}_${pre_tag_name}_diff.html
