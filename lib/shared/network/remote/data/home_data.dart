import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class HomeData {
  Api api;
HomeData(this.api);
  getData(String token)async{
   var response=await api.getDataWithToken(LinkApi.home,token); 

   return response.fold((l)=>l, (r)=>r);
  }
}