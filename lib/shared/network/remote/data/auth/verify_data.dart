import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class VerifyData {
  Api api;
VerifyData(this.api);
  postData(String username,String code)async{
   var response=await api.postDataLogin(LinkApi.verify, {
    "username":username,
    "code":code,
    
    
   }); 

   return response.fold((l)=>l, (r)=>r);
  }
}