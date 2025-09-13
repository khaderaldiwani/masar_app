import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class NotificationsData {
  Api api;
NotificationsData(this.api);
  getData(String token)async{
   var response=await api.getDataWithToken(LinkApi.notifications,token
   ); 

   return response.fold((l)=>l, (r)=>r);
  }
}