gen:
	thrift --gen rb:namespaced --gen py --gen java config/service.thrift
	thrift --gen rb:namespaced --gen py --gen java config/auth.thrift
	thrift --gen rb:namespaced --gen py --gen java config/notes.thrift

haproxy:
	haproxy -f config/haproxy.cfg

deps:
	sudo easy_install thrift
	mkdir -p vendor
	rm vendor/*.jar
	cd vendor && wget http://repo.maven.apache.org/maven2/org/apache/thrift/libthrift/0.9.1/libthrift-0.9.1.jar
	cd vendor && wget http://central.maven.org/maven2/org/slf4j/slf4j-api/1.7.5/slf4j-api-1.7.5.jar

java:
	javac -cp vendor/libthrift-0.9.1.jar:vendor/slf4j-api-1.7.5.jar:services/auth gen-java/auth/Server.java gen-java/auth/User.java services/auth/Worker.java
	java -cp vendor/libthrift-0.9.1.jar:vendor/slf4j-api-1.7.5.jar:gen-java:. services.auth.Worker

