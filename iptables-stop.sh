#!/bin/bash
iptables -F
iptables -F -t nat
iptables -F -t mangle
list=`lsmod|grep ipt | awk '{print $1}'`
l2=`lsmod|grep 'nf_' | awk '{print $1}'`
list="$list $l2"
allok=1
for ccc in 1 2 3 4 5 6 7 8 9 0
do
allok=1
for aaa in $list; do 
modprobe -r $aaa
if [ $? -ne 0 ]
then
rmmod $aaa
echo "$aaa"
allok=0
fi
done;
if [ $allok -eq 1 ]
then
break
fi
sleep 1;
done
if [ $allok -eq 0 ]
then
echo "rmmod netfilter failed"
lsmod|grep ipt
fi
