import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class ForgetpasswordData {
  Api api;
ForgetpasswordData(this.api);
  postData(String username)async{
   var response=await api.postDataLogin(LinkApi.forgetPassword, {
    "username":username,
    
    
   }); 

   return response.fold((l)=>l, (r)=>r);
  }
}