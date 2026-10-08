#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `federation/ldap/src/main/java/org/keycloak/storage/ldap/idm/store/ldap/LDAPContextManager.java`:

This pull request introduces the defect later reported as "Using truststore with LDAP and StartTLS is not working". The
problem a user observed, and its root cause:

### Before reporting an issue

- [X] I have searched existing issues
- [X] I have reproduced the issue with the [latest nightly release](https://github.com/keycloak/keycloak/releases/tag/nightly)

### Area

ldap

### Describe the bug

The parameters for an external trust store does not seems to be working anymore on KC v22 :
* the docker parameters KC_SPI_TRUSTSTORE_FILE_FILE and KC_SPI_TRUSTSTORE_FILE_PASSWORD 
* the command line parameters --spi-truststore-file-file and --spi-truststore-file-password

While none of those settings raise an error, providing a cacerts.jks store to KC containing both the usual dist bundle certificates and some custom certs with the self-signed CA public cert seems to be ignored while working perfectly up to v21.

A connection to an active directory server, default LDAP port but with STARTTLS enforced and a certificate signed by an internal CA will generate the following error on KC side :
(I've kept the executor info line, but some informations has been replaced with **** )
```
docker-keycloak[445949]: 2023-07-25 01:28:53,777 INFO  [org.keycloak.storage.ldap.LDAPIdentityStoreRegistry] (executor-thread-1) Creating new LDAP Store for the LDAP storage provider: '*****', LDAP Configuration: {fullSyncPeriod=[-1], pagination=[true], startTls=[true], usersDn=[ou=*****,dc=local], connectionPooling=[true], cachePolicy=[DEFAULT], useKerberosForPasswordAuthentication=[false], importEnabled=[true], enabled=[true], usernameLDAPAttribute=[sAMAccountName], bindDn=[*****@*****.local], changedSyncPeriod=[-1], lastSync=[1628546799], vendor=[ad], uuidLDAPAttribute=[objectGUID], allowKerberosAuthentication=[false], connectionUrl=[ldap://*****.local:389], syncRegistrations=[false], authType=[simple], customUserSearchFilter=[(&(objectCategory=person)(objectClass=user)(memberOf:1.2.840.113556.1.4.1941:=CN=*****,DC=local)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))], debug=[false], searchScope=[2], useTruststoreSpi=[always], usePasswordModifyExtendedOp=[false], trustEmail=[false], priority=[0], userObjectClasses=[person, organizationalPerson, user], rdnLDAPAttribute=[cn], editMode=[READ_ONLY], validatePasswordPolicy=[false], batchSizeForSync=[1000]}, binaryAttributes: []
docker-keycloak[445949]: 2023-07-25 01:28:53,903 ERROR [org.keycloak.storage.ldap.idm.store.ldap.LDAPContextManager] (executor-thread-1) Could not negotiate TLS: javax.naming.CommunicationException: Connection or outbound has closed [Root exception is java.net.SocketException: Connection or outbound has closed]
docker-keycloak[445949]: #011at java.naming/com.sun.jndi.ldap.LdapCtx.extendedOperation(LdapCtx.java:3433)
docker-keycloak[445949]: #011at java.naming/javax.naming.ldap.InitialLdapContext.extendedOperation(InitialLdapContext.java:184)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPContextManager.startTLS(LDAPContextManager.java:115)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPContextManager.createLdapContext(LDAPContextManager.java:88)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPContextManager.getLdapContext(LDAPContextManager.java:100)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPOperationManager.execute(LDAPOperationManager.java:709)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPOperationManager.execute(LDAPOperationManager.java:704)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPOperationManager.lookupById(LDAPOperationManager.java:410)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.store.ldap.LDAPIdentityStore.fetchQueryResults(LDAPIdentityStore.java:261)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.query.internal.LDAPQuery.getResultList(LDAPQuery.java:167)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.idm.query.internal.LDAPQuery.getFirstResult(LDAPQuery.java:178)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.LDAPStorageProvider.loadLDAPUserByUuid(LDAPStorageProvider.java:839)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.LDAPStorageProvider.loadAndValidateUser(LDAPStorageProvider.java:498)
docker-keycloak[445949]: #011at org.keycloak.storage.ldap.LDAPStorageProvider.validate(LDAPStorageProvider.java:173)
docker-keycloak[445949]: #011at org.keycloak.storage.UserStorageManager.importValidation(UserStorageManager.java:127)
docker-keycloak[445949]: #011at org.keycloak.storage.UserStorageManager.getUserByUsername(UserStorageManager.java:365)
(...)
```

Even with some debugging information, the SSL handshake is printed, but the error is insufficient : Fatal (UNEXPECTED_MESSAGE): Connection reset

### Version

22.0.1

### Expected behavior

Connect to any service using an usual ldap/ad account, being authenticated and sent back to the application

### Actual behavior

Blocking error from KC when validating the ldap/ad user + password : Unexpected error when handling authentication request to identity provider.

### How to Reproduce?

Just upgrade KC v21.1.2 to v22.0.1 and try to authenticate, the error will appear on validation.
Stop the container, change back to v21.1.2 (no need to restore the DB), the AD authentication is working correctly.

Details about the configuration are provided right after



### Anything else?

Warning : not for the faint of heart

### Part 1
I'm using an automaton to put at the side of the docker-compose.yaml under the directory ./data/certificates the following files :
* the public cert for the internal CA (self-signed)
* a public cert for the Active Directory server, signed by the internal CA.  
  It is valid for the server itself (short name and server fqdn) and the domain fqdn
* a similar public cert for another AD server

Notice : The certs have been checked, they are still valid with a long duration.

### Part 2
Then, I'm using the java tools from the KC docker image to generate a custom cacert file containing : 
* the system cert-bundle automatically generated, which allow to validate any internet ressource
* the provided internal public certificates

This is done with the ./data/certificates mounted as a volume to the image directory `/usr/share/pki/ca-trust-source/anchors`
Said /usr/.../anchors/ directory is loaded by the usual system tools when (re)generating the ca bundle for the system and the default java cacerts bundle.
Using this, it is possible to automatically integrate self-signed or internal certificates without any effort. You can then do an extract to generate a final cacerts file 
It is also possible to also directly copy the /etc/pki/java/cacerts file back instead.

The commands are as follow :
```
update-ca-trust
/usr/bin/p11-kit extract --format=java-cacerts --filter=certificates --overwrite --purpose server-auth /usr/share/pki/ca-trust-source/anchors/cacerts.jks
```

Warning : I've discovered that someone though it would be nice [to remove the p11-kit package](https://github.com/keycloak/keycloak/blame/0ddef5dda884aa5d56f13ee8d1f573e935c33dcc/quarkus/container/ubi-null.sh#L33), so this won't work with KC v21 and v22


### Part 3

Rest is having the certificate directory mounted as a volume, and KC instructed to load the generated cacert.jks file using the KC_SPI_TRUSTSTORE_FILE_* env variables.
KC has the AD domain declared as a user federation provider. 
The controllers use each their own certificates, signed by the CA, supporting also the domain fqdn. STARTTLS is required, TLS v1.2 & v1.3 are supported.
Working perfectly since a while, KC configuration updated for v18 Quarkus, not a hickup since, until KC v22


### Docker compose and config file

Compose : 
```
version: '3'

# ref: https://github.com/keycloak/keycloak/tree/main/quarkus/container

x-service: &keycloak-svc
    image: quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
    ports:
      - "${DOCKER_HOST_IP:-127.0.0

This same root cause must be fixed before merging.
REVIEW_EOF
