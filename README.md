# tcpengine
a tcp server/client engine for testing(IM server emulated, huge concurrent connections and high TPS)

testing(ubuntu vivid 15.04 3.19.0-26-lowlatency x86_64)

## 1. bind enough ip address to loopback(lo) for more then 65535 connections in client side
run following script by root(sudo -s or su -):
for oneip in `seq 10 180`; do ip addr add 127.0.0.$oneip/8 dev lo; done

## 2. disable iptables/netfilter to avoid "ip_conntrack: table full, dropping packet"
run iptables-stop.sh script by root(sudo -s or su -)

## 3. test with map:

3.1 start server side with cpu profile: go build tcpengine.go && ./tcpengine -I 10 -P -d 90 2>panic.server.log || more panic.server.log

3.2 start client side without cpu profile: go build tcpengine.go && ./tcpengine -I 10 -c 800000 2>panic.client.log || more panic.client.log

3.3 after 90 seconds, check cpu profile: go tool pprof /somewhere/tcpengine /somewhere//pprof.server.12345.cpu.prof

## 4. test without map(add -M for server):

4.1 start server side with cpu profile of server: go build tcpengine.go && ./tcpengine -I 10 -P -d 90 -M 2>panic.server.log || more panic.server.log

4.2 start client side without cpu profile: go build tcpengine.go && ./tcpengine -I 10 -c 800000 2>panic.client.log || more panic.client.log

4.3 after 90 seconds, check cpu profile of server: go tool pprof /somewhere/tcpengine /somewhere//pprof.server.67890.cpu.prof
