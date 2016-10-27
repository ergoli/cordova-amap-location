package com.phonegap.plugins.aMapLocation;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationClientOption.AMapLocationMode;
import com.amap.api.location.AMapLocationListener;

import android.util.Log;

public class Location extends CordovaPlugin implements AMapLocationListener{
	
	private static String TAG="location";
	public static AMapLocationClient keepLocationInstance = null;
	private AMapLocationClient locationClient = null;
    private AMapLocationClientOption locationOption = null;
    boolean keepSendBack = false;
    CallbackContext callback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("getCurrentPosition")) {
            callback = callbackContext;
            
            locationClient = new AMapLocationClient(this.cordova.getActivity().getApplicationContext());
            locationOption = new AMapLocationClientOption();
            // 设置定位模式为高精度模式
            locationOption.setLocationMode(AMapLocationMode.Hight_Accuracy);
            //设置为单次定位
            locationOption.setOnceLocation(true);
            // 设置定位监听
            locationClient.setLocationListener(this);
            locationOption.setNeedAddress(true);
            locationOption.setInterval(2000);

            locationClient.setLocationOption(locationOption);
            // 启动定位
            locationClient.startLocation();
            
            return true;
        } else if (action.equals("watchPosition")) { //启动持续定位
        	int interval = args.optInt(0, 10000); //获取定位间隔参数，缺省10秒钟定位一次
        	
        	 locationClient = new AMapLocationClient(this.cordova.getActivity().getApplicationContext());
             locationOption = new AMapLocationClientOption();
             // 设置定位模式为高精度模式
             locationOption.setLocationMode(AMapLocationMode.Hight_Accuracy);
             //设置为多次定位
             locationOption.setOnceLocation(true);
             // 设置定位监听
             locationClient.setLocationListener(this);
             locationOption.setNeedAddress(true);
             locationOption.setInterval(interval);
             locationClient.setLocationOption(locationOption);
             // 启动定位
             locationClient.startLocation();
             keepSendBack = true;
             
             if (keepLocationInstance != null) { //判断是否存在未关闭的持续定位对象
            	 keepLocationInstance.stopLocation();
            	 keepLocationInstance.onDestroy();
            	 keepLocationInstance = null;
             }
             // 存储持续定位对象用于关闭
             keepLocationInstance = locationClient;
             return true;
        } else if (action.equals("stopWatch")) { //停止持续定位
        	if (keepLocationInstance != null) {
        		keepLocationInstance.stopLocation();
        		keepLocationInstance.onDestroy();
        		keepLocationInstance = null;
        	}
        	callback.success();
        	return true;
        }
        return false;
    }

    @Override
    public void onLocationChanged(AMapLocation aMapLocation) {
        if (aMapLocation != null) {
            if (aMapLocation.getErrorCode() == 0) {
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = new Date(aMapLocation.getTime());
                df.format(date);//定位时间

                JSONObject locationInfo = new JSONObject();
                try {
                    locationInfo.put("locationType", aMapLocation.getLocationType()); //获取当前定位结果来源，如网络定位结果，详见定位类型表
                    locationInfo.put("latitude", aMapLocation.getLatitude()); //获取纬度
                    locationInfo.put("longitude", aMapLocation.getLongitude()); //获取经度
                    locationInfo.put("accuracy", aMapLocation.getAccuracy()); //获取精度信息
                    locationInfo.put("speed", aMapLocation.getSpeed()); //获取速度信息
                    locationInfo.put("bearing", aMapLocation.getBearing()); //获取方向信息
                    locationInfo.put("accuracy", aMapLocation.getAccuracy()); //获取精度信息
                    locationInfo.put("date", date); //定位时间
                    locationInfo.put("address", aMapLocation.getAddress()); //地址，如果option中设置isNeedAddress为false，则没有此结果
                    locationInfo.put("country", aMapLocation.getCountry()); //国家信息
                    locationInfo.put("province", aMapLocation.getProvince()); //省信息
                    locationInfo.put("city", aMapLocation.getCity()); //城市信息
                    locationInfo.put("district", aMapLocation.getDistrict()); //城区信息
                    locationInfo.put("street", aMapLocation.getStreet()); //街道信息
                    locationInfo.put("streetNum", aMapLocation.getStreetNum()); //街道门牌号
                    locationInfo.put("cityCode", aMapLocation.getCityCode()); //城市编码
                    locationInfo.put("adCode", aMapLocation.getAdCode()); //地区编码
                    locationInfo.put("poiName", aMapLocation.getPoiName());
                    locationInfo.put("aoiName", aMapLocation.getAoiName());
                } catch (JSONException e) {
                	Log.e(TAG, "Locatioin json error:" + e);
                }
                PluginResult result = new PluginResult(PluginResult.Status.OK, locationInfo);
                if (!keepSendBack) { //不持续传回定位信息
                	locationClient.stopLocation(); //只获取一次的停止定位
                } else {
                	result.setKeepCallback(true);
                }
                callback.sendPluginResult(result);
            } else {
                //显示错误信息ErrCode是错误码，errInfo是错误信息，详见错误码表。
                Log.e(TAG, "Locatioin error:" + aMapLocation.getErrorCode());
                PluginResult result = new PluginResult(PluginResult.Status.ERROR, aMapLocation.getErrorCode());
                callback.sendPluginResult(result);
            }
        }
    }
}
