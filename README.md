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
	高德定位cordova插件


## Installation

    cordova plugin add cordova-amap-location --variable ANDROID_KEY=高德网站申请android证书 --variable IOS_KEY=高德网站申请IOS证书

## Properties
### 获取当前定位
`window.plugins.aMapLocationPlugin.getCurrentPosition(success, fail);`

### 启用定时获取定位，interval参数单位为毫秒，需要大于1000毫秒，success方法定时得到位置回调
`window.plugins.aMapLocationPlugin.watchPosition(interval, success, fail);`

### 关闭定时获取定位
`window.plugins.aMapLocationPlugin.clearWatch(watchID, success, fail);`

## callback function have a params

### success callback params properties
	#### locationType
	#### latitude
	#### longitude
	#### accuracy
	#### altitude
	#### address
	#### country
	#### province
	#### city
	#### district
	#### street
	#### locationDetail

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


