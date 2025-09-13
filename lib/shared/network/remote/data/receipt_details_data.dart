import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class ReceiptDetailsData {
  Api api;
ReceiptDetailsData(this.api);
  getData(String token,String receiptID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.ReceiptDetails}${receiptID}",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}