# React Squall

### Setup

1. Add the node-modules/ios/RNSquall.xcodeproject xcode project to `Libraries` of your react native project
2. Add `libRNSquall.a` to Linked Frameworks and Libraries
3. Add `Squall.framework` to the parent react-native projects from node-modules/react-squall/ios (create a Frameworks group, if desired)
4. Add `Squall.framework` to _Embedded Binaries_ under General
5. Add `($SRCROOT)/../node-modules/react-squall/` to Framework Headers in Build Settings
6. Don't forget to add a `Squall License` key-value pair to your project's info.plist

### Animations

Animations needs to be bundled with the parent react-native project
