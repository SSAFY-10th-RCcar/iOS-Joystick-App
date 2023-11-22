# CocoaMQTT

![PodVersion](https://img.shields.io/cocoapods/v/CocoaMQTT5.svg)
![Platforms](https://img.shields.io/cocoapods/p/CocoaMQTT5.svg)
![License](https://img.shields.io/cocoapods/l/BadgeSwift.svg?style=flat)
![Swift version](https://img.shields.io/badge/swift-5-orange.svg)

MQTT v3.1.1 and v5.0 client library for iOS/macOS/tvOS written with Swift 5


## Build

Build with Xcode 11.1 / Swift 5.1

IOS Target: 9.0 or above
OSX Target: 10.12 or above
TVOS Target: 10.0 or above

##  xcode 14.3 issue:
```ruby
File not found: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/arc/libarclite_iphonesimulator.a
```
If you encounter the issue, Please update your project minimum depolyments to 11.0


## Installation
### CocoaPods

To integrate CocoaMQTT into your Xcode project using [CocoaPods](http://cocoapods.org), you need to modify you `Podfile` like the followings:

```ruby
use_frameworks!

target 'Example' do
    pod 'CocoaMQTT'
end
```

Then, run the following command:

```bash
$ pod install
```

At last, import "CocoaMQTT" to your project:

```swift
import CocoaMQTT
```


### Carthage
Install using [Carthage](https://github.com/Carthage/Carthage) by adding the following lines to your Cartfile:

```
github "emqx/CocoaMQTT" "master"
```

Then, run the following command:

```bash
$ carthage update --platform iOS,macOS,tvOS --use-xcframeworks
```

At last:

On your application targets “General” settings tab, in the "Frameworks, Libraries, and Embedded content" section, drag and drop CocoaMQTT.xcframework, CocoaAsyncSocket.xcframework and Starscream.xcframework from the Carthage/Build folder on disk. Then select "Embed & Sign". 



## Usage

Create a client to connect [MQTT broker](https://www.emqx.com/en/mqtt/public-mqtt5-broker):

```swift
///MQTT 5.0
let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
let mqtt5 = CocoaMQTT5(clientID: clientID, host: "broker.emqx.io", port: 1883)

let connectProperties = MqttConnectProperties()
connectProperties.topicAliasMaximum = 0
connectProperties.sessionExpiryInterval = 0
connectProperties.receiveMaximum = 100
connectProperties.maximumPacketSize = 500
mqtt5.connectProperties = connectProperties

mqtt5.username = "test"
mqtt5.password = "public"
mqtt5.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
mqtt5.keepAlive = 60
mqtt5.delegate = self
mqtt5.connect()

///MQTT 3.1.1
let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
let mqtt = CocoaMQTT(clientID: clientID, host: "broker.emqx.io", port: 1883)
mqtt.username = "test"
mqtt.password = "public"
mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
mqtt.keepAlive = 60
mqtt.delegate = self
mqtt.connect()
```

Now you can use closures instead of `CocoaMQTTDelegate`:

```swift 
mqtt.didReceiveMessage = { mqtt, message, id in
    print("Message received in topic \(message.topic) with payload \(message.string!)")           
}
```

## SSL Secure

#### One-way certification

No certificate is required locally.
If you want to trust all untrust CA certificates, you can do this:

```swift
mqtt.allowUntrustCACertificate = true
```

#### Two-way certification

Need a .p12 file which is generated by a public key file and a private key file. You can generate the p12 file in the terminal:

```
openssl pkcs12 -export -clcerts -in client-cert.pem -inkey client-key.pem -out client.p12
```

## MQTT over Websocket

In the 1.3.0, The CocoaMQTT has supported to connect to MQTT Broker by Websocket.

If you integrated by **CocoaPods**, you need to modify you `Podfile` like the followings and execute `pod install` again:

```ruby
use_frameworks!

target 'Example' do
    pod 'CocoaMQTT/WebSockets'
end

```

If you're using CocoaMQTT in a project with only a `.podspec` and no `Podfile`, e.g. in a module for React Native, add this line to your `.podspec`:

```ruby
Pod::Spec.new do |s|
  ...
  s.dependency "Starscream"
end
```

Then, Create a MQTT instance over Websocket:

```swift
///MQTT 5.0
let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
let mqtt5 = CocoaMQTT5(clientID: clientID, host: host, port: 8083, socket: websocket)
let connectProperties = MqttConnectProperties()
connectProperties.topicAliasMaximum = 0
// ...
mqtt5.connectProperties = connectProperties
// ...

_ = mqtt5.connect()

///MQTT 3.1.1
let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
let mqtt = CocoaMQTT(clientID: clientID, host: host, port: 8083, socket: websocket)

// ...

_ = mqtt.connect()
```

If you want to add additional custom header to the connection, you can use the following:

```swift
let websocket = CocoaMQTTWebSocket(uri: "/mqtt")
websocket.headers = [
            "x-api-key": "value"
        ]
        websocket.enableSSL = true

let mqtt = CocoaMQTT(clientID: clientID, host: host, port: 8083, socket: websocket)

// ...

_ = mqtt.connect()
```

## Example App

You can follow the Example App to learn how to use it. But we need to make the Example App works fisrt:

```bash
$ cd Examples

$ pod install
```

Then, open the `Example.xcworkspace/` by Xcode and start it!


## Dependencies


These third-party functions are used:

~~[GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)~~
* [MqttCocoaAsyncSocket](https://github.com/leeway1208/MqttCocoaAsyncSocket)
* [Starscream](https://github.com/daltoniam/Starscream)


## LICENSE

MIT License (see `LICENSE`)

## Contributors

* [@andypiper](https://github.com/andypiper)
* [@turtleDeng](https://github.com/turtleDeng)
* [@jan-bednar](https://github.com/jan-bednar)
* [@jmiltner](https://github.com/jmiltner)
* [@manucheri](https://github.com/manucheri)
* [@Cyrus Ingraham](https://github.com/cyrusingraham)

## Author

- Feng Lee <feng@emqx.io>
- CrazyWisdom <zh.whong@gmail.com>
- Alex Yu <alexyu.dc@gmail.com>
- Leeway <leeway1208@gmail.com>


## Twitter

https://twitter.com/EMQTech