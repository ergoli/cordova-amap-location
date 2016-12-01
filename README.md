<!--
# license: Licensed to the Apache Software Foundation (ASF) under one
#         or more contributor license agreements.  See the NOTICE file
#         distributed with this work for additional information
#         regarding copyright ownership.  The ASF licenses this file
#         to you under the Apache License, Version 2.0 (the
#         "License"); you may not use this file except in compliance
#         with the License.  You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#         Unless required by applicable law or agreed to in writing,
#         software distributed under the License is distributed on an
#         "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#         KIND, either express or implied.  See the License for the
#         specific language governing permissions and limitations
#         under the License.
-->


# cordova-amap-location

## 描述
	高德(amap)定位cordova插件，采用高德(amap)最新的api版本，IOS库采用AMapFoundationKit 1.3.1，AMapLocationKit 2.2.0。


## 安装

    cordova plugin add cordova-amap-location --variable ANDROID_KEY=高德网站申请android证书 --variable IOS_KEY=高德网站申请IOS证书

## 方法
- 获取当前定位
`window.plugins.aMapLocationPlugin.getCurrentPosition(success, fail);`

- 启用定时获取定位，interval参数仅支持Android，单位为毫秒，需要大于1000毫秒，success方法定时得到位置信息回调
`window.plugins.aMapLocationPlugin.watchPosition(success, fail, interval);`

- 关闭定时获取定位
`window.plugins.aMapLocationPlugin.clearWatch(success, fail);`

## callback function have a params

### success callback params properties
	#### locationType  获取当前定位结果来源，如网络定位结果，详见定位类型表，仅支持Android
	#### latitude  获取纬度
	#### longitude  获取经度
	#### accuracy  获取精度信息
	#### speed  获取速度信息
	#### bearing  获取方向信息
	#### date  定位时间
	#### address  地址详情
	#### country  国家信息
	#### province  省信息
	#### city  城市信息
	#### district  城区信息
	#### street  街道信息
	#### streetNum  街道门牌号
	#### cityCode  城市编码
	#### adCode  地区编码
	#### poiName POI名称
	#### aoiName AOI名称


### fail callback params properties
	#### code
	#### message

### example
	window.plugins.aMapLocationPlugin.getCurrentPosition(function(response){
			console.log(response.locationType);
			console.log(response.latitude);
			console.log(response.longitude);
		},function(response){
			console.log(response.code);
			console.log(response.message);
		})

### Supported Platforms
- Android
- iOS


