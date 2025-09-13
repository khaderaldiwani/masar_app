
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/receipt_Model.dart';
import 'package:masar/module/receipts/cubit/receipts_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/all_receipts_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class ReceiptsCubit extends Cubit<ReceiptsState> {
  ReceiptsCubit() : super(ReceiptsInitial()){
getData();
  }
  List temp=[
        {
            "id": 1,
            "name": "اللغة العربية",
            "amount": 400,
            "status": "مدفوع"
        },
        {
            "id": 2,
            "name": "اللغة العربية",
            "amount": 400,
            "status": "مدفوع"
        },
        {
            "id": 3,
            "name": "اللغة العربية",
            "amount": 400,
            "status": "غير مدفوع"
        },
        {
            "id": 4,
            "name": "اللغة العربية",
            "amount": 400,
            "status": "غير مدفوع"
        }
    ];

static ReceiptsCubit get(BuildContext context)=>BlocProvider.of(context);
  StatusRequest statusRequestPaid = StatusRequest.none;
  StatusRequest statusRequestNoPaid = StatusRequest.none;
  AllReceiptsData allReceiptsData = AllReceiptsData(Api());
  bool isOngoing=true;
 changeOngoing(bool Ongoing){
isOngoing=Ongoing;
emit(ReceiptsChangeOngoing());
 }
  
  List<ReceiptModel> listReceipts = [];
  List<ReceiptModel> listReceiptsPaymented = [];
  List<ReceiptModel> listReceiptsNoPaymented = [];
  
  getData() async {
       if (isClosed) return; // منع الخطأ
   statusRequestPaid = StatusRequest.loading;
   statusRequestNoPaid = StatusRequest.loading;
  if (!isClosed) emit(ReceiptsSuccessState());
    String token=CachHelper.getString(key: "token")!;
    String studentid=CachHelper.getString(key: "id")!;
    
    var response = await allReceiptsData.getData(token,studentid);
    statusRequestPaid = handlingResponse(response);
    statusRequestNoPaid = handlingResponse(response);
    print(response);
    if (statusRequestPaid == StatusRequest.success) {
      if (response['success'] == true) {
        
          listReceipts = [];
          listReceiptsPaymented = [];
          listReceiptsNoPaymented = [];
        ///////////////////
        List receiptsResponse = response['data'];
        listReceipts.addAll(receiptsResponse.map((e) => ReceiptModel.fromJson(e)));
       //////////////
       for(ReceiptModel model in listReceipts) {
        if (model.status=="مدفوع") {
          listReceiptsPaymented.add(model);
        }else{
          listReceiptsNoPaymented.add(model);
          
        } 

        if (listReceiptsPaymented.isEmpty) {
                 statusRequestPaid = StatusRequest.failure;

       }
        if (listReceiptsNoPaymented.isEmpty) {
                 statusRequestNoPaid= StatusRequest.failure;

       }
       }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
if (!isClosed)    emit(ReceiptsFinishState());
  }
  

}
