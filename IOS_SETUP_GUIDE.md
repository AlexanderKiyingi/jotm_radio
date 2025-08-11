# 🎵 iOS Setup Guide for JOTM Radio App - Codemagic Deployment

## 🚨 **iOS Crash Fixes Applied**

### ✅ **1. iOS Podfile Created**
- **File**: `ios/Podfile`
- **Purpose**: Manages iOS dependencies and sets minimum iOS version to 12.0
- **Key Features**: 
  - Platform target: iOS 12.0+
  - M1 Mac compatibility
  - Audio plugin configurations

### ✅ **2. iOS Info.plist Updated**
- **File**: `ios/Runner/Info.plist`
- **Added**:
  - `UIBackgroundModes`: audio, background-processing, background-fetch
  - `NSAppTransportSecurity`: HTTPS streaming configuration for edge.mixlr.com
  - `NSMicrophoneUsageDescription`: iOS 14+ permission requirements

### ✅ **3. AppDelegate.swift Enhanced**
- **File**: `ios/Runner/AppDelegate.swift`
- **Added**:
  - AVAudioSession configuration for background streaming
  - Bluetooth and AirPlay support
  - Background audio lifecycle methods

### ✅ **4. Plugin Versions Updated**
- **File**: `pubspec.yaml`
- **Updates**:
  - `just_audio`: 0.9.40 → 0.9.46
  - `audio_service`: 0.18.1 → 0.18.18
  - `audio_session`: 0.18.1 → 0.1.25

### ✅ **5. Codemagic Configuration**
- **File**: `codemagic.yaml`
- **Purpose**: Automated iOS builds and App Store deployment
- **Features**: TestFlight distribution, code signing, automated builds

## 🏗️ **Codemagic Setup for iOS Deployment**

### **Step 1: Connect Your Repository**
1. Go to [codemagic.io](https://codemagic.io)
2. Sign in with your GitHub account
3. Click "Add application"
4. Select your `jotm_radio` repository
5. Choose "iOS" as the platform

### **Step 2: Configure iOS Build Settings**
1. **In Codemagic dashboard**:
   - Platform: iOS
   - Build type: Release
   - Code signing: Automatic (Codemagic handles this)

2. **Update bundle identifier**:
   - Edit `codemagic.yaml` line 12
   - Change `com.yourcompany.jotmradio` to your actual bundle ID
   - Example: `com.yourname.jotmradio`

3. **Update team ID**:
   - Edit `ios/exportOptions.plist` line 6
   - Change `YOUR_TEAM_ID` to your Apple Developer Team ID

### **Step 3: Set Up App Store Connect**
1. **In Codemagic → Environment variables**:
   - `APP_STORE_CONNECT_PRIVATE_KEY`: Your App Store Connect API key
   - `KEY_ID`: Your API key ID
   - `ISSUER_ID`: Your issuer ID

2. **Get these from Apple Developer**:
   - Go to [developer.apple.com](https://developer.apple.com)
   - Account → Keys → Generate new key
   - Download the `.p8` file and note the Key ID and Issuer ID

### **Step 4: First Build & Test**
1. **Commit and push your changes**:
   ```bash
   git add .
   git commit -m "Fix iOS crashes: add Podfile, update Info.plist, enhance AppDelegate, add Codemagic config"
   git push origin main
   ```

2. **Trigger Codemagic build**:
   - Go to Codemagic dashboard
   - Click "Start new build"
   - Select your iOS workflow

3. **Monitor the build**:
   - Watch logs for any errors
   - Build should complete in ~10-15 minutes
   - IPA file will be generated automatically

## 📱 **Testing Your Fixed App**

### **Option 1: TestFlight (Recommended)**
1. **Codemagic automatically uploads to TestFlight**
2. **In App Store Connect**:
   - Go to TestFlight tab
   - Add internal testers (your team)
   - Add external testers (friends, family)
3. **Testers receive email invitation**
4. **Install TestFlight app on iPhone**
5. **Download and test your app**

### **Option 2: Direct IPA Installation**
1. **Download IPA from Codemagic build artifacts**
2. **Install via Xcode** (if you have access to a Mac):
   - Connect iPhone via USB
   - Open Xcode → Window → Devices and Simulators
   - Drag IPA to device
3. **Install via 3rd party tools** (not recommended for production)

## 🔍 **What Was Causing the iOS Crashes**

### **Root Cause 1: Missing iOS Dependencies**
- **Problem**: No Podfile meant iOS plugins weren't properly linked
- **Solution**: Created comprehensive Podfile with audio plugin configs

### **Root Cause 2: Audio Session Misconfiguration**
- **Problem**: AVAudioSession not configured for background streaming
- **Solution**: Added proper audio session setup in AppDelegate

### **Root Cause 3: Missing iOS Permissions**
- **Problem**: Info.plist missing critical audio and security settings
- **Solution**: Added UIBackgroundModes, NSAppTransportSecurity, etc.

### **Root Cause 4: Outdated Plugin Versions**
- **Problem**: Old plugin versions with known iOS compatibility issues
- **Solution**: Updated to latest stable releases

## 🧪 **Test Checklist**

### **Launch Testing**
- [ ] App launches without crash
- [ ] No permission dialogs on first launch
- [ ] Audio session initializes properly

### **Audio Functionality**
- [ ] Radio stream starts playing
- [ ] Audio continues in background
- [ ] Audio routing works (speaker, headphones, Bluetooth)
- [ ] Stream switching works without crash

### **Background Mode**
- [ ] Audio continues when app is backgrounded
- [ ] Lock screen controls work
- [ ] Control center shows audio info

### **Stability**
- [ ] No crashes during 10+ minutes of playback
- [ ] App handles network interruptions gracefully
- [ ] Memory usage remains stable

## 🚀 **Deployment to App Store**

### **Step 1: TestFlight Validation**
1. **Test thoroughly** on multiple iOS devices
2. **Fix any remaining issues** found during testing
3. **Update version number** in `pubspec.yaml` if needed

### **Step 2: Production Release**
1. **In Codemagic**:
   - Edit `codemagic.yaml`
   - Change `submit_to_app_store: false` to `submit_to_app_store: true`
2. **Trigger new build**
3. **App will be submitted to App Store Review**

### **Step 3: App Store Review**
- **Typical review time**: 24-48 hours
- **Common rejection reasons**:
  - Audio background modes not working
  - Missing privacy descriptions
  - App crashes during review

## 📞 **Support & Troubleshooting**

### **Codemagic Build Issues**
- **Build fails**: Check build logs in Codemagic dashboard
- **Code signing errors**: Verify App Store Connect API keys
- **Pod install fails**: Check `ios/Podfile` syntax

### **iOS App Issues**
- **App crashes on device**: Use TestFlight crash reporting
- **Audio issues**: Verify device audio settings and permissions
- **Background audio fails**: Check Info.plist UIBackgroundModes

### **Getting Help**
- Check Codemagic build logs
- Review TestFlight crash reports
- Test on multiple iOS versions (12.0+)

---

**🎯 Your iOS app should now be stable and ready for App Store deployment!** 

The fixes address the most common iOS audio streaming issues that cause crashes. Use Codemagic for automated builds and TestFlight for testing before submitting to the App Store.
