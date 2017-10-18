#!/bin/sh -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 module-directory"
    exit 1
fi

cd $1
if [ ! -f pom.xml ]; then
    exit 0;
fi

remote_url=$(git remote get-url origin)
module_name=$(basename ${remote_url})

scm_base="https://gitbox.apache.org/repos/asf/${module_name}"

sed -i "s#<connection>scm.*</connection>#<connection>scm:git:${scm_base}</conncetion>#" pom.xml
sed -i "s#<developerConnection>scm.*</developerConnection>#<developerConnection>scm:git:${scm_base}</developerConnection>#" pom.xml
sed -i "s#<url>.*svn.apache.org.*</url>#<url>https://gitbox.apache.org/repos/asf?p=${module_name}.git</url>#" pom.xml

git add pom.xml
git commit -m 'SLING-7162 - Update SCM information in all POM files to reference Git'

