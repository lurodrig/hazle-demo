CATALINA_OPTS=" \
  -Dhazelcast.logging.type=log4j2 \
  -Dhazelcast.diagnostics.enabled=true \
  -Dcom.sun.management.jmxremote \
  -Dcom.sun.management.jmxremote.ssl=false \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.port=9010 \
  -Dcom.sun.management.jmxremote.rmi.port=9110 \
  -Dcom.sun.management.jmxremote.local.only=false \
  "
