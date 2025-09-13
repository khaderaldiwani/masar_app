import 'dart:io';

import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class SettingData {
  Api api;
SettingData(this.api);
  postData(File file,String token)async{
   var response=await api.postRequsteWithFileWithToken(LinkApi.settingImage,{},file,token); 

   return response.fold((l)=>l, (r)=>r);
  }
}