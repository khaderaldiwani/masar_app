import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class LogoutData {
  Api api;
LogoutData(this.api);
  Logout(String role_id,String device_token,token)async{
   var response=await api.postDataWithToken(LinkApi.logout, {
    
    "role_id":role_id,
    "device_token":device_token
   },
    token
   ); 

   return response.fold((l)=>l, (r)=>r);
  }
}