echo -n `cat /proc/cpuinfo | grep processor | wc -l`
echo -n x
cat /proc/cpuinfo | grep "cpu\ MHz" | head -n1 | awk '{print $4/1000"GHz"}'
