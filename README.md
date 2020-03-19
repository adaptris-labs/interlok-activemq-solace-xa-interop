# interlok-activemq-solace-xa-demo

## What is this

This is an complete interlok instance which basically show-cases ActiveMQ to Solace using XA; Since the optional `interlok-solace` package requires a license you will need one of those.
There are 2 channels

* HTTP-> ActiveMQ : http://localhost:8080/api/to-activemq -> that goes to an ActiveMQ Queue "Sample.T1"
* ActiveMQ -> Solace : `jms:queue:Sample.T1` -> `jms:topic:Sample.T2` with XA configured; essentially, a JMS Queue to JMS Topic bridge with XA.

## Quickstart

* You'll need java of course because gradle is the build system.
* Docker of course
* Get yourself a license, and make a file called `license.properties.docker` in _src/main/interlok/config_
```
adp.license.key=whatever-your-license-key-is
```

* `./gradlew docker`
    * Since you haven't specified a image name, it will be _adaptrislabs/interlok-activemq-solace-xa_
    * The version is _latest_;
* Either run `docker-compose up` or `./gradlew dockerComposeUp`
* Wait for Solace to be fully started.
* Once Interlok says it's started then you can push some data to activemq

```
curl -i -XPOST -d'{"hello":"world"}' http://localhost:8080/api/to-activemq
curl -i -XPOST -d'{"hello":"world"}' http://localhost:8080/api/to-activemq
curl -i -XPOST -d'{"hello":"world"}' http://localhost:8080/api/to-activemq
curl -i -XPOST -d'{"hello":"world"}' http://localhost:8080/api/to-activemq
curl -i -XPOST -d'{"hello":"world"}' http://localhost:8080/api/to-activemq
.... a bunch of times.
```

* Login to the UI and start the `ActiveMq-Solace-Channel` channel from the dashboard and eventually you'll see something like:
    * This channel is set with auto-start=false so that we can see multiple messages in a single transactions

```
interlok-activemq-solace | DEBUG [ManagedThreadFactory-45-1] [c.a.x.j.XAJmsConsumer] Committing transaction(172.25.0.4.tm0000100004): message count 19
```

## Resources

* https://interlok.adaptris.net/interlok-docs
* https://hub.docker.com/_/solace-pubsub-standard

## Gradle flags

You can control some behaviour by passing in project properties in the form *-PpropertyKey=value*

Property Key | Default Value | Description | Notes
------------ | ------------- | ----------- | -----
releaseVersion|latest|The docker tag version | You will have to edit docker-compose.yml|
dockerImageName|adaptrislabs/interlok-solace| The docker image name|You will have to edit docker-compose.yml|
buildEnv|docker|Change it to anything else to drive local properties from your hostname| This directly affects the way property files are sourced, by default it will be `variables.propertes.{buildEnv}`|
