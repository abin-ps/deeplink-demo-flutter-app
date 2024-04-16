# Deeplink demo app

## Intro
 - For setup deep link demo app like this, you need a website/webapp. if you don't have one. no worries check this repository, where I you can get idea about creating your own webapp with flutter and firebase with no cost.

 - If you have a website/webapp you need to add some configuration to it. for navigating user to the app, when he/she click the link.

 - Here will provide you all the information to add the configurations to app and setuping your own app. Stay tuned.

 ## Setup android application
 - once you create a flutter app. firstly you need to add/update some configurations to your app for verifying the link.
 - for that, open `AndroidManifest.xml` file which located inside `android/app/src/main`
 - add following lines inside `acitivity tag`
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
- After adding these on your app, you need generate app signing key with keytool.
- For generating the key. run following command. 
  ```bash
  keytool -genkey -v -keystore your-key-name-here.jks -keyalg RSA -keysize 2048 -validity 10000 -alias your-alias-name
  ```
  (*note: here dont forgot the keystorefilename, alias filename and the password)
-  after generating key, run following command to generated get access of SHA key,
  ```bash
  keytool -list -v -keystore path-to-your-jksfile/your_keystore_file.jks -alias your-alias-name -storepass your-password -keypass your-password
  ```
    * From the above command,
    * you need to update `path-to-your-jksfile/your_keystore_file.jks` with your file directory.
    * instead of `your-alias-name` use your alias name which is used for generating the jks file. in previous command.
    * for `your-password` update the password you entered on the previous step of generating key.
* After completing these steps, we need to add `key.properties` file inside `android/` of your project. in that you need to update following,
  ```properties
  storePassword=<your-password>
    keyPassword=<your-password>
    keyAlias=<your-alias>
    storeFile=<path-to-your-key-file.jks>
  ```
  for example check [this file](link to my key.properties file)

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

* now your appside configurations almost done.
* you need to run `flutter build apk --release` command on terminal to get a release build and install it on your device/emulator.
  
## Add Webapp/Website configurations:
* here i used flutter project for creating simple web app. you can check that [here](link your web app repo here).
### Steps for users who uses flutter for creating webapp:
 * If have hosted project then, firstly you need to open firebase.json file which is inside of your project directory. where, check the `public` key. navigate to the location mentioned to that, and create a foler called `.well-knowns/` inside that create a file called `assetlinks.json` file.
 * After creating file open [this url](https://developers.google.com/digital-asset-links/tools/generator) on your web browser.
 * And fill the details. for app package name update the applicationId of your android app and for package fingerprint update the key generated using keytool and linked with android app.
### Steps for users who doesn't use flutter for their website/webapp users:
* open [this url](https://developers.google.com/digital-asset-links/tools/generator) on your web browser.
* And fill the details. for app package name update the applicationId of your android app and for package fingerprint update the key generated using keytool and linked with android app.
* add these files to your project, which should be accessible like this, https://your-domain.com/.well-known/assetlinks.json. this file must not be a empty list. for updating the configurations. use this url

- (*note you can generate this file anywhere in your system, but ensure your directories doesn't have spaces in between the folder names. keep like this eg: home/linuxuser/keytool/)