package com.archko.wuhan2020.wuhan2020_flutter_app

import com.umeng.commonsdk.UMConfigure
import io.flutter.app.FlutterApplication

/**
 * @author: archko 2020/2/9 :12:44 下午
 */
class App : FlutterApplication() {

    companion object {
        const val appkey = "5e3f940119ce475332c987cb"
    }

    override fun onCreate() {
        super.onCreate()
        UMConfigure.init(this, appkey, "archko", UMConfigure.DEVICE_TYPE_PHONE, null);
    }
}