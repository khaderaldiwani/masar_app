import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class AllReceiptsData {
  Api api;
AllReceiptsData(this.api);
  getData(String token,String studentID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.allReceipts}${studentID}/receipts",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}