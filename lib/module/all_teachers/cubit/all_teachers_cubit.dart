
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/all_teacher_model.dart';
import 'package:masar/module/all_teachers/cubit/all_teachers_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/all_teacher_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class AllTeachersCubit extends Cubit<AllTeachersState> {
  AllTeachersCubit() : super(AllTeachersInitial());
static AllTeachersCubit get(BuildContext context)=>BlocProvider.of(context);
StatusRequest statusRequest = StatusRequest.none;
 
  AllTeacherData allTeachersData = AllTeacherData(Api());
  
  
  List<AllTeacherModel> listTeacher = [];


 getData() async {
      
if(isClosed) return;
    statusRequest = StatusRequest.loading;
if(!isClosed)  emit(AllTeachersSuccessGetDataState());
    String token=CachHelper.getString(key: "token")!;
    
    var response = await allTeachersData.getData(token);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
   listTeacher = [];
        ///////////////////
        List teacherResponse = response['data'];
        listTeacher.addAll(teacherResponse.map((e) => AllTeacherModel.fromJson(e)));
      //////////////
      if (listTeacher.isEmpty) {
        statusRequest = StatusRequest.failure;
        
      }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
 if(!isClosed)   emit(AllTeachersFinishGetDataState());
  }

}
