package com.xunsoft.location;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.amap.api.location.AMapLocationClientOption.AMapLocationMode;

public class Location extends CordovaPlugin {
	
	private static String TAG="location";

	@Override
	public boolean execute(String action, JSONArray args,
			CallbackContext callbackContext) throws JSONException {
		final CallbackContext context=callbackContext;
		Log.d(TAG, "We are entering execute");
		
		if(action.equals("getCurrentPosition")){
			final AMapLocationClient mLocationClient=new AMapLocationClient(this.cordova.getActivity().getApplicationContext());
	        
	        AMapLocationListener mLocationListener = new AMapLocationListener(){
	        	
				@Override
				public void onLocationChanged(AMapLocation arg0) {
					// TODO Auto-generated method stub
					Log.d(TAG, "location finished");
					if(arg0.getErrorCode()==0){
						JSONObject r = new JSONObject();
						try {
							r.put("locationType", arg0.getLocationType());
							r.put("latitude", arg0.getLatitude());
							r.put("longitude", arg0.getLongitude());
							r.put("accuracy", arg0.getAccuracy());
							r.put("altitude", arg0.getAltitude());
							r.put("address", arg0.getAddress());
							r.put("country", arg0.getCountry());
							r.put("province", arg0.getProvince());
							r.put("city", arg0.getCity());
							r.put("district", arg0.getDistrict());
							r.put("street", arg0.getStreet());
							r.put("locationDetail", arg0.getLocationDetail());
							Log.d(TAG,r.toString());
							context.success(r);
						} catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					else{
						JSONObject r = new JSONObject();
						try{
							r.put("code", arg0.getErrorCode());
							r.put("message", arg0.getErrorInfo());
							Log.d(TAG,r.toString());
							context.error(r);
						}catch (JSONException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					mLocationClient.stopLocation();
					mLocationClient.onDestroy();
				}
	        };
	        
	        //地图定位选项
	        AMapLocationClientOption mLocationOption=new AMapLocationClientOption();
	        mLocationOption.setOnceLocation(true);
	        mLocationOption.setNeedAddress(true);
	        mLocationOption.setHttpTimeOut(100000);
	        mLocationOption.setLocationMode(AMapLocationMode.Hight_Accuracy);
	        
	        mLocationClient.setLocationListener(mLocationListener);
	        mLocationClient.setLocationOption(mLocationOption);
	        mLocationClient.startLocation();
		}
		return true;
	}
	
}
