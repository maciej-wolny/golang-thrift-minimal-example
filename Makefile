
# use the vendor/ subdir which holds the vendored apache thrift go library, version 
# the vendored thrift is commit fa0796d33208eadafb6f42964c8ef29d7751bfc2 on 1.0.0-dev,
# last commit there is Fri Oct 16 21:33:39 2015 +0200, from https://github.com/apache/thrift
all:
	cd src/client && GO15VENDOREXPERIMENT=1 go build -o ../../bin/thrift-ex-client
	cd src/server && GO15VENDOREXPERIMENT=1 go build -o ../../bin/thrift-ex-server

regen:
	rm -rf vendor/shared vendor/tutorial
	thrift -version || true # thrift -version needs to be 1.0.0-dev ! 
	thrift --gen go -out vendor -r -I idl idl/tutorial.thrift


clean:
	rm -f bin/* *~

run:
	bin/thrift-ex-server -secure &
	sleep 1 && bin/thrift-ex-client -secure
	sleep 1 && pkill -9 thrift-ex-server
