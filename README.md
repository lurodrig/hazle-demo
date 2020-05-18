# Hazlecast client for hibernate second level demo (Work In Progress)

## What?

Spring-boot REST service client against MySQL database. Hibernate ORM with second level cache enabled.

## How?

Run mysql and create the demo empty database:
```
docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:latest 
CREATE DATABASE `demo`
```

Run Hazlecast In Memory Grid
```
docker run --network=host -e JAVA_OPTS="-Xms512M -Xmx512M" hazelcast/hazelcast:4.0.1
``` 

Compile, run the tests and package
```
mvn clean package
```

Build an apache-tomcat container with our app added to `${CATALINA_BASE}/webapps`
```
docker build -t 9.0.35-jdk8-spring-boot-hazle .
```

Run apache-tomcat
```
docker run --network=host --name tomcat-hazle-demo 9.0.35-jdk8-spring-boot-hazle:latest
```

Work In Progress

It looks like I am almost there:

Hazlecast is running and listening in 5701:
```
INFO: [192.168.1.16]:5701 [dev] [4.0.1] [192.168.1.16]:5701 is STARTING
May 18, 2020 6:59:11 AM com.hazelcast.internal.cluster.ClusterService
INFO: [192.168.1.16]:5701 [dev] [4.0.1] 

Members {size:1, ver:1} [
	Member [192.168.1.16]:5701 - ed7f8717-e1c3-4238-878f-2801f694dadf this
]

May 18, 2020 6:59:11 AM com.hazelcast.core.LifecycleService
INFO: [192.168.1.16]:5701 [dev] [4.0.1] [192.168.1.16]:5701 is STARTED
```

When the test run it seems to connect successfully, on the client side I see:
```
2020-05-18 08:59:21.850  INFO 9762 --- [           main] c.c.h.demo.demo.DemoApplicationTests     : Starting DemoApplicationTests on lurodrig-latitude with PID 9762 (started by lurodrig in /home/lurodrig/development/workspaces/hazle-demo)
2020-05-18 08:59:21.852  INFO 9762 --- [           main] c.c.h.demo.demo.DemoApplicationTests     : No active profile set, falling back to default profiles: default
2020-05-18 08:59:22.517  INFO 9762 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
2020-05-18 08:59:22.602  INFO 9762 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 75ms. Found 1 JPA repository interfaces.
2020-05-18 08:59:23.108  INFO 9762 --- [           main] c.h.i.config.AbstractConfigLocator       : Loading 'hazelcast-client.xml' from the classpath.
2020-05-18 08:59:23.186  WARN 9762 --- [           main] c.h.config.AbstractXmlConfigHelper       : Name of the hazelcast schema location[http://www.hazelcast.com/schema/client-config/hazelcast-client-config-3.12.xsd] is incorrect, using default
2020-05-18 08:59:23.401 DEBUG 9762 --- [           main] c.h.i.metrics.impl.MetricsConfigHelper   : hz.client_1 [dev] [4.0.1] Collecting debug metrics and sending to diagnostics is disabled
2020-05-18 08:59:23.546  INFO 9762 --- [           main] c.h.c.impl.spi.ClientInvocationService   : hz.client_1 [dev] [4.0.1] Running with 2 response threads, dynamic=true
2020-05-18 08:59:23.602  INFO 9762 --- [           main] com.hazelcast.core.LifecycleService      : hz.client_1 [dev] [4.0.1] HazelcastClient 4.0.1 (20200409 - e086b9c) is STARTING
2020-05-18 08:59:23.603  INFO 9762 --- [           main] com.hazelcast.core.LifecycleService      : hz.client_1 [dev] [4.0.1] HazelcastClient 4.0.1 (20200409 - e086b9c) is STARTED
2020-05-18 08:59:23.616 DEBUG 9762 --- [           main] c.h.i.networking.nio.NioNetworking       : hz.client_1 [dev] [4.0.1] TcpIpConnectionManager configured with Non Blocking IO-threading model: 1 input threads and 1 output threads
2020-05-18 08:59:23.616 DEBUG 9762 --- [           main] c.h.i.networking.nio.NioNetworking       : hz.client_1 [dev] [4.0.1] write through enabled:true
2020-05-18 08:59:23.616 DEBUG 9762 --- [           main] c.h.i.networking.nio.NioNetworking       : hz.client_1 [dev] [4.0.1] IO threads selector mode is SELECT
2020-05-18 08:59:23.629  INFO 9762 --- [           main] c.h.c.i.c.ClientConnectionManager        : hz.client_1 [dev] [4.0.1] Trying to connect to cluster: dev
2020-05-18 08:59:23.633  INFO 9762 --- [           main] c.h.c.i.c.ClientConnectionManager        : hz.client_1 [dev] [4.0.1] Trying to connect to [127.0.0.1]:5701
2020-05-18 08:59:23.680 DEBUG 9762 --- [           main] c.h.c.i.c.ClientConnectionManager        : hz.client_1 [dev] [4.0.1] Checking the cluster: d6b2eba7-3df7-4bab-9258-d1c9b93f5e69, current cluster: null
2020-05-18 08:59:23.681  INFO 9762 --- [           main] com.hazelcast.core.LifecycleService      : hz.client_1 [dev] [4.0.1] HazelcastClient 4.0.1 (20200409 - e086b9c) is CLIENT_CONNECTED
2020-05-18 08:59:23.681  INFO 9762 --- [           main] c.h.c.i.c.ClientConnectionManager        : hz.client_1 [dev] [4.0.1] Authenticated with server [192.168.1.16]:5701:ed7f8717-e1c3-4238-878f-2801f694dadf, server version: 4.0.1, local address: /127.0.0.1:54409
2020-05-18 08:59:23.691  INFO 9762 --- [           main] c.h.internal.diagnostics.Diagnostics     : hz.client_1 [dev] [4.0.1] Diagnostics disabled. To enable add -Dhazelcast.diagnostics.enabled=true to the JVM arguments.
2020-05-18 08:59:23.698  INFO 9762 --- [lient_1.event-3] c.h.c.impl.spi.ClientClusterService      : hz.client_1 [dev] [4.0.1] 

Members [1] {
	Member [192.168.1.16]:5701 - ed7f8717-e1c3-4238-878f-2801f694dadf
}
```

In the hazlecast server side:
```
May 18, 2020 6:59:23 AM com.hazelcast.client.impl.protocol.task.AuthenticationMessageTask
INFO: [192.168.1.16]:5701 [dev] [4.0.1] Received auth from Connection[id=1, /127.0.0.1:5701->/127.0.0.1:54409, qualifier=null, endpoint=[127.0.0.1]:54409, alive=true, connectionType=JVM], successfully authenticated, clientUuid: f5d1dee0-fbef-4100-819b-7ee4d5730dc8, client version: 4.0.1
May 18, 2020 6:59:27 AM com.hazelcast.internal.nio.tcp.TcpIpConnection
INFO: [192.168.1.16]:5701 [dev] [4.0.1] Connection[id=1, /127.0.0.1:5701->/127.0.0.1:54409, qualifier=null, endpoint=[127.0.0.1]:54409, alive=false, connectionType=JVM] closed. Reason: Connection closed by the other side
May 18, 2020 6:59:27 AM com.hazelcast.client.impl.ClientEndpointManager
INFO: [192.168.1.16]:5701 [dev] [4.0.1] Destroying ClientEndpoint{connection=Connection[id=1, /127.0.0.1:5701->/127.0.0.1:54409, qualifier=null, endpoint=[127.0.0.1]:54409, alive=false, connectionType=JVM], clientUuid='f5d1dee0-fbef-4100-819b-7ee4d5730dc8, authenticated=true, clientVersion=4.0.1, creationTime=1589785163669, latest clientAttributes=lastStatisticsCollectionTime=1589785163764,enterprise=false,clientType=JVM,clientVersion=4.0.1,clusterConnectionTimestamp=1589785163644,clientAddress=127.0.0.1,clientName=hz.client_1,credentials.principal=null,os.committedVirtualMemorySize=5966778368,os.freePhysicalMemorySize=1118932992,os.freeSwapSpaceSize=1024454656,os.maxFileDescriptorCount=1048576,os.openFileDescriptorCount=115,os.processCpuTime=9670000000,os.systemLoadAverage=1.42,os.totalPhysicalMemorySize=8233611264,os.totalSwapSpaceSize=1024454656,runtime.availableProcessors=8,runtime.freeMemory=164187304,runtime.maxMemory=1830813696,runtime.totalMemory=273678336,runtime.uptime=3066,runtime.usedMemory=109491032,executionService.userExecutorQueueSize=0}
```

But, yes there is always a but :(, when I deployed to apache-tomcat:
```
2020-05-18 07:07:59.794  WARN 1 --- [           main] ConfigServletWebServerApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'hazelcastInstance' defined in class path resource [org/springframework/boot/autoconfigure/hazelcast/HazelcastClientConfiguration$HazelcastClientConfigFileConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [com.hazelcast.core.HazelcastInstance]: Factory method 'hazelcastInstance' threw exception; nested exception is java.lang.NoClassDefFoundError: com/hazelcast/core/DuplicateInstanceNameException
2020-05-18 07:07:59.813  INFO 1 --- [           main] ConditionEvaluationReportLoggingListener : 

Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
2020-05-18 07:07:59.826 ERROR 1 --- [           main] o.s.boot.SpringApplication               : Application run failed

org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'hazelcastInstance' defined in class path resource [org/springframework/boot/autoconfigure/hazelcast/HazelcastClientConfiguration$HazelcastClientConfigFileConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [com.hazelcast.core.HazelcastInstance]: Factory method 'hazelcastInstance' threw exception; nested exception is java.lang.NoClassDefFoundError: com/hazelcast/core/DuplicateInstanceNameException

.../...

	Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [com.hazelcast.core.HazelcastInstance]: Factory method 'hazelcastInstance' threw exception; nested exception is java.lang.NoClassDefFoundError: com/hazelcast/core/DuplicateInstanceNameException
		at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:185)
		at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:651)
		... 62 more
	Caused by: java.lang.NoClassDefFoundError: com/hazelcast/core/DuplicateInstanceNameException
		at org.springframework.boot.autoconfigure.hazelcast.HazelcastClientConfiguration$HazelcastClientConfigFileConfiguration.hazelcastInstance(HazelcastClientConfiguration.java:57)
		at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
		at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
		at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
		at java.lang.reflect.Method.invoke(Method.java:498)
		at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154)
		... 63 more
	Caused by: java.lang.ClassNotFoundException: com.hazelcast.core.DuplicateInstanceNameException
		at org.apache.catalina.loader.WebappClassLoaderBase.loadClass(WebappClassLoaderBase.java:1365)
		at org.apache.catalina.loader.WebappClassLoaderBase.loadClass(WebappClassLoaderBase.java:1188)
		... 69 more
18-May-2020 07:07:59.836 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive [/usr/local/tomcat/webapps/hazle-demo.war] has finished in [4,529] ms
```

Every help is appreciated, thanks in advance!
