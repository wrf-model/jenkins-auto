#!/bin/bash
su - ubuntu << 'EOF'
mkdir /home/ubuntu/wrf-stuff
cd wrf-stuff/
git clone git@github.com:davegill/wrf-coop.git
cd wrf-coop/
sed -e "s^_GIT_URL_^$GIT_URL^" -e "s/_GIT_BRANCH_/$GIT_BRANCH/" Dockerfile-sed > Dockerfile
csh build.csh /home/ubuntu/wrf-stuff/ /home/ubuntu/wrf-stuff/
date ; ( ./single.csh ; ./test_006s.csh & ./test_006o.csh & ./test_006m.csh & wait ) >output_6 ; date
date ; ./last_only_once.csh >> output_6 ; date
EOF
