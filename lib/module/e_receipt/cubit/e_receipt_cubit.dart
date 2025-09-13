import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/receipt_details_model.dart';
import 'package:masar/module/e_receipt/cubit/e_receipt_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/receipt_details_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class EReceiptCubit extends Cubit<EReceiptState> {
  final String receiptID;

  EReceiptCubit({required this.receiptID}) : super(EReceiptInitial()){
print("required this.$receiptID");
  getData();
  }

static EReceiptCubit get(BuildContext context)=>BlocProvider.of(context);
  StatusRequest statusRequest = StatusRequest.none;
  ReceiptDetailsData receiptDetailsData = ReceiptDetailsData(Api());
  
  Map temp={
        "id": 8,
        "first_name": "محمد",
        "last_name": "ياسين",
        "phone": "0998877665",
        "type": "دورة",
        "name": "اللغة الإنكليزية",
        "transaction_id": 8,
        "amount": 400,
        "date": "2025-08-23T00:00:00.000000Z",
        "status": "مدفوع"
    };
  ReceiptDetailsModel receiptDetails=ReceiptDetailsModel()  ;
  
   getData() async {
      
   statusRequest = StatusRequest.loading;
   emit(EReceiptSuccessState());
     String token=CachHelper.getString(key: "token")!;
   
     var response = await receiptDetailsData.getData(token,receiptID);
     statusRequest = handlingResponse(response);
    print(response);

        Map receiptsResponse = temp;//response['data'];    
        receiptDetails= ReceiptDetailsModel.fromJson(Map<String, dynamic>.from(receiptsResponse));
    
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        
       // listReceiptDetauls = [];
        ///////////////////
        Map receiptsResponse = response['data'];
        receiptDetails= ReceiptDetailsModel.fromJson(Map<String, dynamic>.from(receiptsResponse));
     //   listReceiptDetauls.addAll(receiptsResponse.map((e) => ReceiptDetailsModel.fromJson(e)));
       //////////////
      
      } 
      else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
     emit(EReceiptFinishState());
   }
  


}
