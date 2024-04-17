# Deeplink demo app

## Intro
 - For setup deep link demo app like this, you need a website/webapp. if you don't have one, no worries check [this repository](https://github.com/abin-ps/simple-web-app-with-flutter-firebase), where you can get idea about creating your own webapp with flutter and firebase.

 - If you have a website/webapp you need to add some configuration to it. you can check required configuration [here](link here).

 - Here I'll help you to implement android applinks on your flutter app. If you're looking for iOS configureations, you can check this article by CodeWithAndrena. Let's get started.

 ## Setup android application
 - For setuping android we need to create flutter app. Hope you already have it.
 - Once you created a flutter app, Firstly you need to add some configurations to your app to verify and launch your app when user clicks the link.
 - To do that, open `AndroidManifest.xml` file which located inside `android/app/src/main`
 - Add the following lines inside `acitivity tag`. Also update your domain instead `"your-domain.com"`.
```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" />
    <!-- here update your domain for me its, simple-web-app.web.app -->
    <data android:host="your-domain.com"/>
</intent-filter>
```
- After adding these on your app, you need unique Signing keys of your app. where this key is verified by android with our domain configurations, when user clicks the link.
- If you're already have the signing key to your app and app is not published yet then, [follow from this step](link here) or if you already published your app to playstore then, [check this](Steps for users already published their app on playstore). otherwise do following steps carefully.
- For generating unique signing key for your app, run following command. 
```bash
  keytool -genkey -v -keystore your-keystore-filename-here.jks -keyalg RSA -keysize 2048 -validity 10000 -alias your-alias-name
```
- example: i generate keystore file on my home dir. and i use my-alias for alias name. for password use mypassword
```bash
  keytool -genkey -v -keystore /home/user/keystore/flutter/deeplink_demo_app_key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-alias
```
  **Note: Here don't forgot the `keystore filename`, `alias name` and the `password`. Also you can generate this keystore file anywhere on your system. but make sure the directory path doesn't contains spaces between the `folder names`**.
-  After successful generation of the key, To get access to the SHA-256 key run following command,
```bash
  keytool -list -v -keystore path-to-your-jksfile/your_keystore_file.jks -alias your-alias-name -storepass your-password -keypass your-password
```
    * Here, you need to provide `your path to the keystore file` instead of `path-to-your-jksfile/your_keystore_file.jks`. Also update `alias name you used for generating keystore file`. Do same for the password as well. 
    * Example: in my case command is,
```bash
  keytool -list -v -keystore /home/user/keystore/flutter/deeplink_demo_app_key.jks -alias my-alias -storepass mypassword -keypass mypassword
```
  * After completing these steps, we need to add `key.properties` file inside `android/` of your project. in that you need to update following,
```properties
  storePassword=<your-password>
    keyPassword=<your-password>
    keyAlias=<your-alias>
    storeFile=<path-to-your-key-file.jks>
```
  * Example: in mycase,
```properties
  storePassword=mypassword
    keyPassword=mypassword
    keyAlias=my-alias
    storeFile=/home/user/keystore/flutter/deeplink_demo_app_key.jks
```
* After updating `key.properties` file, we need to update `app level build.gradle` file,
- Firstly add following to above `android{}` block.
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```
* then, add following above `buildTypes` which is inside of `android{}` block.
```gradle
   signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }

```
* after these update buildType to release mode, 
```gradle
   buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.release
        }
  }
```

* Now your App side configurations are almost done.
* You need to run `flutter build apk --release` command on terminal to get a release build and install it on your device/emulator.
  
## Add Webapp/Website configurations:
* Here I use flutter project for creating simple web app. you can check that [here](https://github.com/abin-ps/simple-web-app-with-flutter-firebase).

### Steps for users already have signingKey but not published their app on playstore:
* If you already have SHA-256 appSigning key then go to your webapp/website project and add  `assetlinks.json` file on that project. which should be accessible like this, `https://your-domain.com/.well-known/assetlinks.json` which basically used for verifying your apps unique key. then [check this](Update `assetlinks.json` file) for adding configurations to it.

### Steps for users already published their app on playstore:
* If you're already published the app to playstore. check `app Signing`  on your google console and copy the ` SHA-256 key` (which is unique for each apps) from their. then update your `assetlinks.json` file. which should be accessible like this, `https://your-domain.com/.well-known/assetlinks.json` which basically used for verifying your apps unique key. This verification is done by android itself. after creating the file [check this](Update `assetlinks.json` file) for adding configurations to it.

### Steps for users who uses flutter for creating webapp:
 * If you done `firebase init hosting` to your flutter web app then, firstly you need to open `firebase.json` file which is inside of your project directory. where, check the `public` key. navigate to the location mentioned in that, and create a folder called `.well-known/` inside that create a file called `assetlinks.json` file.
 * If you don't use firebase hosting, then you need to create a file called `assetlinks.json` which should be accessible like this, `https://your-domain.com/.well-known/assetlinks.json`. 
* Once created [check this](Update `assetlinks.json` file) 

### Steps for users who doesn't use flutter for their website/webapp users:
- The users didn't use flutter for their website/webapp. need to create a file called, `.well-known/assetlinks.json` on your website/webapp project. 
  [check this](Update `assetlinks.json` file) to add configurations to it.
- Note: these configurations are used by android when a user click on your link, it will check the signingKey with your configureations. so you should make sure these configurations accessible like this, `https://your-domain.com/.well-known/assetlinks.json`. if not, android will navigate user to your website instead of app.

## Update `assetlinks.json` file:
 * After creating assetlinks.json file, you need to add the configurations to it. for that open [this url](https://developers.google.com/digital-asset-links/tools/generator) on your web browser.
 * And fill the details. for `app package name` update the `applicationId of your android app` and for `package fingerprint` update the `unique SHA-256 key of your app`, which we'll generated in previous steps.
 * After filled the required fields. click generate button then, copy the generated instructions and paste it to your assetlinks.json file.
 * Once done these steps. then build web app and deploy it.

## For iOS Configuration
 check [this article](https://codewithandrea.com/articles/flutter-deep-links/#types-of-deep-links)