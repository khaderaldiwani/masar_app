import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class LoginData {
  Api api;
LoginData(this.api);
  postData(String username,String password,String role_id,String device_token)async{
   var response=await api.postDataLogin(LinkApi.login, {
    "username":username,
    "password":password,
    "role_id":role_id,
    "device_token":device_token
   }); 

   return response.fold((l)=>l, (r)=>r);
  }
}