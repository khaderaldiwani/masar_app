import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class AllCoursesData {
  Api api;
AllCoursesData(this.api);
  getData(String token)async{
   var response=await api.getDataWithToken(
    "${LinkApi.search}",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}