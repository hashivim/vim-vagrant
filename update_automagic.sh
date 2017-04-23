#!/bin/bash
VERSION=$1

function usage {
    echo -e "
    USAGE EXAMPLES:

        ./$(basename $0) 0.8.7
        ./$(basename $0) 0.9.2
    "
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

EXISTING_VAGRANT_VERSION=$(vagrant version | head -n1 | awk '{print $3}')

if [ "${EXISTING_VAGRANT_VERSION}" != "${VERSION}" ]; then
    echo "-) You are trying to update this script for vagrant ${VERSION} while you have"
    echo "   vagrant ${EXISTING_VAGRANT_VERSION} installed at $(which vagrant)."
    echo "   Please update your local vagrant before using this script."
    exit 1
fi

echo "+) Acquiring vagrant-${VERSION}"
wget https://github.com/mitchellh/vagrant/archive/v${VERSION}.tar.gz

echo "+) Extracting vagrant-${VERSION}.tar.gz"
tar zxf v${VERSION}.tar.gz

echo "+) Running update_commands.rb"
./update_commands.rb

echo "+) Updating the badge in the README.md"
sed -i "/img.shields.io/c\[\![](https://img.shields.io/badge/Supports%20Vagrant%20Version-${VERSION}-blue.svg)](https://github.com/hashicorp/vagrant/blob/v${VERSION}/CHANGELOG.md)" README.md

echo "+) Cleaning up after ourselves"
rm -f v${VERSION}.tar.gz
rm -rf vagrant-${VERSION}

git status
