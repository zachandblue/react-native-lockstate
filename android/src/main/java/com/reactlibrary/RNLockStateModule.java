package com.reactlibrary;

import android.app.KeyguardManager;
import android.content.Context;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.LifecycleEventListener;

import com.facebook.react.modules.core.DeviceEventManagerModule;

public class RNLockStateModule extends ReactContextBaseJavaModule implements LifecycleEventListener {

  private ReactApplicationContext mReactContext;

  public RNLockStateModule(ReactApplicationContext reactContext) {
    super(reactContext);
    mReactContext = reactContext;
    mReactContext.addLifecycleEventListener(this);
  }

  @Override
  public String getName() {
    return "RNLockState";
  }

  @Override
  public void onHostPause() {
    new Thread() {
      @Override
      public void run() {
        try {
          this.sleep(1000);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }


        // your code here

        KeyguardManager myKM = (KeyguardManager) mReactContext.getSystemService(Context.KEYGUARD_SERVICE);
//    boolean isKeyguardUp = myKM.inKeyguardRestrictedInputMode();

        if(myKM.isKeyguardLocked()) {
          System.out.println('l');
          getReactApplicationContext()
                  .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                  .emit("locked", null);
        } else {
          System.out.println('u');
          getReactApplicationContext()
                  .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                  .emit("unlocked", null);
        }

      }
    }.start();
  }

  @Override
  public void onHostResume() {
    getReactApplicationContext()
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
      .emit("unlocked", null);
  }

  @Override
  public void onHostDestroy() {
      // Activity `onDestroy`
  }
}
