import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class ChangepasswordData {
  Api api;
ChangepasswordData(this.api);
  postData(String username,String code,String password)async{
   var response=await api.postDataLogin(LinkApi.changePassword, {
    "username":username,
    "code":code,
    "password":password,
    
   }); 

   return response.fold((l)=>l, (r)=>r);
  }
}