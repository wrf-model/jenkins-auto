#!/bin/bash
su - ubuntu << 'EOF'
mkdir /home/ubuntu/wrf-stuff
cd wrf-stuff/
git clone git@github.com:davegill/wrf-coop.git
cd wrf-coop/
sed -e "s^_GIT_URL_^$GIT_URL^" -e "s/_GIT_BRANCH_/$GIT_BRANCH/" Dockerfile-sed > Dockerfile
csh build.csh /home/ubuntu/wrf-stuff/ /home/ubuntu/wrf-stuff/
echo "==============================================================" >  SERIAL
echo "==============================================================" >> SERIAL
echo "                         SERIAL START" >> SERIAL
echo "==============================================================" >> SERIAL

echo "==============================================================" >  OPENMP
echo "==============================================================" >> OPENMP
echo "                         OPENMP START" >> OPENMP
echo "==============================================================" >> OPENMP

echo "==============================================================" >  MPI
echo "==============================================================" >> MPI
echo "                         MPI START" >> MPI
echo "==============================================================" >> MPI

date ; ./single.csh > output_006 ; date 
./test_006s.csh > outs & 
./test_006o.csh > outo & 
./test_006m.csh > outm & 
wait 
cat SERIAL outs OPENMP outo MPI outm >> output_006
date ; ./last_only_once.csh >> output_006 ; date
rm outs outo outm 
rm SERIAL OPENMP MPI 
EOF
