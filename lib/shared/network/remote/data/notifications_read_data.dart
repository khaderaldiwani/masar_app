import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class NotificationsReadData {
  Api api;
NotificationsReadData(this.api);
  postData(String token)async{
   var response=await api.postDataWithToken(LinkApi.notificationsRead,{},token
   ); 

   return response.fold((l)=>l, (r)=>r);
  }
}