#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `gradle/fips.gradle`:

This pull request introduces the defect later reported as "1.2.840.113549.1.1.4 Signature not available for BCJSSE in fips mode". The
problem a user observed, and its root cause:

<!--
Please fill out the following information, and ensure you have attempted
to reproduce locally
-->

**Build scan**:
https://gradle-enterprise.elastic.co/s/sl7mn5m3gqtts/console-log?task=:client:sniffer:test

**Repro line**:

**Reproduces locally?**:

**Applicable branches**:

**Failure history**:
<!--
Link to build stats and possible indication of when this started failing and how often it fails
<https://build-stats.elastic.co/app/kibana>
-->
**Failure excerpt**:

```
: Test class org.elasticsearch.client.sniff.SniffOnFailureListenerTests |  
-- | --
  | 2> Dec 26, 2020 5:01:56 AM org.bouncycastle.jsse.provider.ProvKeyManagerFactorySpi getDefaultKeyStore |  
  | 2> INFO: Initializing empty key store |  
  | 2> Dec 26, 2020 5:01:56 AM org.bouncycastle.jsse.provider.ProvTrustManagerFactorySpi getDefaultTrustStore |  
  | 2> INFO: Initializing with trust store at path: /dev/shm/elastic+elasticsearch+master+matrix-java-periodic-fips/ES_RUNTIME_JAVA/java11/nodes/general-purpose/client/sniffer/build/fips-resources/cacerts.bcfks |  
  | 2> java.lang.ExceptionInInitializerError |  
  | at __randomizedtesting.SeedInfo.seed([E9613EC44B53D6F:A6FD937FBFBB3E3D]:0) |  
  | at java.base/javax.crypto.ProviderVerifier.verify(ProviderVerifier.java:128) |  
  | at java.base/javax.crypto.JceSecurity.verifyProvider(JceSecurity.java:191) |  
  | at java.base/javax.crypto.JceSecurity.getVerificationResult(JceSecurity.java:217) |  
  | at java.base/javax.crypto.JceSecurity.getInstance(JceSecurity.java:141) |  
  | at java.base/javax.crypto.Mac.getInstance(Mac.java:273) |  
  | at org.bouncycastle.jcajce.provider.ProvBCFKS$BCFIPSKeyStoreSpi.calculateMac(Unknown Source) |  
  | at org.bouncycastle.jcajce.provider.ProvBCFKS$BCFIPSKeyStoreSpi.verifyMac(Unknown Source) |  
  | at org.bouncycastle.jcajce.provider.ProvBCFKS$BCFIPSKeyStoreSpi.engineLoad(Unknown Source) |  
  | at java.base/java.security.KeyStore.load(KeyStore.java:1479) |  
  | at org.bouncycastle.jsse.provider.ProvTrustManagerFactorySpi.getDefaultTrustStore(ProvTrustManagerFactorySpi.java:98) |  
  | at org.bouncycastle.jsse.provider.ProvSSLContextSpi.getDefaultTrustManagers(ProvSSLContextSpi.java:302) |  
  | at org.bouncycastle.jsse.provider.DefaultSSLContextSpi$LazyManagers.<clinit>(DefaultSSLContextSpi.java:57) |  
  | at org.bouncycastle.jsse.provider.DefaultSSLContextSpi.<init>(DefaultSSLContextSpi.java:86) |  
  | at org.bouncycastle.jsse.provider.BouncyCastleJsseProvider$7.createInstance(BouncyCastleJsseProvider.java:217) |  
  | at org.bouncycastle.jsse.provider.BouncyCastleJsseProvider$BcJsseService.newInstance(BouncyCastleJsseProvider.java:373) |  
  | at java.base/sun.security.jca.GetInstance.getInstance(GetInstance.java:236) |  
  | at java.base/sun.security.jca.GetInstance.getInstance(GetInstance.java:164) |  
  | at java.base/javax.net.ssl.SSLContext.getInstance(SSLContext.java:168) |  
  | at java.base/javax.net.ssl.SSLContext.getDefault(SSLContext.java:99) |  
  | at org.elasticsearch.client.RestClientBuilder.createHttpClient(RestClientBuilder.java:222) |  
  | at java.base/java.security.AccessController.doPrivileged(Native Method) |  
  | at org.elasticsearch.client.RestClientBuilder.build(RestClientBuilder.java:201) |  
  | at org.elasticsearch.client.sniff.SniffOnFailureListenerTests.testSetSniffer(SniffOnFailureListenerTests.java:49) |  
  |   |  
  | Caused by: |  
  | java.lang.SecurityException: Framework jar verification can not be initialized |  
  | at java.base/javax.crypto.JarVerifier.<clinit>(JarVerifier.java:198) |  
  | ... 23 more |  
  |   |  
  | Caused by: |  
  | java.security.PrivilegedActionException: java.security.NoSuchAlgorithmException: 1.2.840.113549.1.1.4 Signature not available |  
  | at java.base/java.security.AccessController.doPrivileged(Native Method) |  
  | at java.base/javax.crypto.JarVerifier.<clinit>(JarVerifier.java:166) |  
  | ... 23 more |  
  |   |  
  | Caused by: |  
  | java.security.NoSuchAlgorithmException: 1.2.840.113549.1.1.4 Signature not available |  
  | at java.base/java.security.Signature.getInstance(Signature.java:267) |  
  | at org.bouncycastle.jcajce.provider.X509CertificateObject.getSignatureFromProvider(Unknown Source) |  
  | at org.bouncycastle.jcajce.provider.X509CertificateObject.verify(Unknown Source) |  
  | at java.base/javax.crypto.JarVerifier.testSignatures(JarVerifier.java:735) |  
  | at java.base/javax.crypto.JarVerifier$1.run(JarVerifier.java:192) |  
  | at java.base/javax.crypto.JarVerifier$1.run(JarVerifier.java:167) |  
  | ... 25 more

```

It's not obvious what triggers this and it is only occured in certain tests and not always or when starting elasticsearch in fips mode. I presume it has to do with a combination of jdk provider and version.  @BigPandaToo has been seeing this locally too IIRC

It looks like we are hitting https://bugs.openjdk.java.net/browse/JDK-8198743 and the appropriate workaround would be to add the SunRsaSign provider too in the list of providers we pack for CI in fips_java.security file, but we should look into why this is not always triggered and the verification of what jar causes this ( I.e. where is the md5withrsa signature used)

This same root cause must be fixed before merging.
REVIEW_EOF
