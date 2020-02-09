package com.archko.wuhan2020.wuhan2020_flutter_app

import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.umeng.analytics.MobclickAgent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        const val TAG = "wuhan_main"
    }

    private var mMethodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        initMethodChannel(getFlutterEngine())
    }

    public override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 设置为U-APP场景
        MobclickAgent.setScenarioType(this, MobclickAgent.EScenarioType.E_UM_NORMAL);
    }

    public override fun onPause() {
        super.onPause()
        MobclickAgent.onPause(this) // 基础指标统计，不能遗漏
    }

    public override fun onResume() {
        super.onResume()
        MobclickAgent.onResume(this) // 基础指标统计，不能遗漏
    }

    public fun onPageStart() {
        MobclickAgent.onPageStart(TAG)
    }

    public fun onPageEnd() {
        MobclickAgent.onPageEnd(TAG)
    }

    private fun initMethodChannel(flutterEngine: FlutterEngine?) {
        mMethodChannel = MethodChannel(flutterEngine!!.dartExecutor, "plugins.cn.archko/wuhan2020_flutter_app");
        //设置监听
        mMethodChannel?.setMethodCallHandler { methodCall, result ->
            Log.d(TAG, "call:" + methodCall.method)
            when (methodCall.method) {
                "analytics_request" -> {
                    handle(methodCall)
                    result.success("success");
                }
                else -> {
                    result.notImplemented()
                }
            }
        };
    }

    private fun handle(methodCall: MethodCall) {
        val method: String = methodCall.argument("method")!!
        Log.d(TAG, "method:$method")
        if ("analytics".equals(method)) {
            analytics(methodCall)
        }
    }

    private fun analytics(methodCall: MethodCall) {
        val params: Map<String, String>? = methodCall.argument("params");
        Log.d("", "params:$params")
        params?.run {
            val key: String? = params["page"]
            when (key) {
                "page_start" -> onPageStart()
                "page_end" -> onPageEnd()
                "page_province_detail" -> onPageProvince(params["page_cities"])
                "page_tab" -> onPageTab(params["tab_index"], params["tab_name"])
            }
        }
    }

    public fun onPageProvince(name: String?) {
        val map = mapOf("province_name" to name)
        MobclickAgent.onEvent(activity, "province_detail", map)
    }

    private fun onPageTab(index: String?, name: String?) {
        val map = mapOf("tab_index" to index, "tab_name" to name)
        MobclickAgent.onEvent(activity, "tab", map)
    }
}
