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


# com-amap-location

## Description
	this is a plugin get location info by use GaoDe Map API,it only used in china.


## Installation

    cordova plugin add com-amap-location

## Properties

window.xunsoft.getCurrentPosition(success,fail);

callback function have a params

### success callback params properties
	#### locationType
	#### latitude
	#### longitude
	#### accuracy
	#### altitude
	#### address
	### country
	#### province
	#### city
	#### district
	#### street
	#### locationDetail

### fail callback params properties
	#### code
	#### message

### example
	window.xunsoft.getCurrentPosition(function(response){
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


