
# react-native-lockstate

Compliant with Apple Guidelines

## Getting started

`$ npm install react-native-lockstate --save`

### Mostly automatic installation

`$ react-native link react-native-lockstate`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-lockstate` and add `RNLockState.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNLockState.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNLockStatePackage;` to the imports at the top of the file
  - Add `new RNLockStatePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-lockstate'
  	project(':react-native-lockstate').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-lockstate/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-lockstate')
  	```


## Usage

iOS 

In AppDelegate.m include the following code:

-(void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
   [[NSNotificationCenter defaultCenter]
    postNotificationName:@"DataWillBecomeUnavailable"
    object:self];
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
   [[NSNotificationCenter defaultCenter]
    postNotificationName:@"DataDidBecomeAvailable"
    object:self];
}


```javascript
import RNLockState from 'react-native-lockstate';

// locked / unlocked
RNLockState.addEventListener('change', (lockStateData) => {
  console.log(lockStateData);
});

// only lockComplete (obsolete)
RNLockState.addEventListener('lockComplete', (lockStateData) => {
  console.log(lockStateData);
});

```
