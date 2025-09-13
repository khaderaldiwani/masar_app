import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class SearchData {
  Api api;
SearchData(this.api);
  getData(String token,String? search,String level_id,String time,String orderBy)async{
   var response=await api.getDataWithToken(
    "${LinkApi.search}?search=$search&sort=$orderBy&level_id=$level_id&time=$time",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}