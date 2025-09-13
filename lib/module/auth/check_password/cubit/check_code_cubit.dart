
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/check_password/cubit/check_code_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/auth/verify_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class CheckCodeCubit extends Cubit<CheckCodeState> {
  
  CheckCodeCubit() : super(CheckCodeInitial());
  static CheckCodeCubit get(BuildContext context)=> BlocProvider.of(context);
  late GlobalKey<FormState> formState;
  late TextEditingController number;
  late int secondsRemaining=60;
  late bool canResend=false;
  Timer? _timer;

 StatusRequest statusRequest = StatusRequest.none;
  VerifyData verifyData = VerifyData(Api());

  @override
   CheckCodeApi(BuildContext context,String code) async {
      
      statusRequest = StatusRequest.loading;
      emit(VerifyLoadingState());
      String username=CachHelper.getString(key: "username")!;
      var response = await verifyData.postData(
          username,code);
      statusRequest = handlingResponse(response);

      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          CachHelper.putString(
              key: "code", value: code);
         Navigator.pushNamed(context, AppRoute.resetPassword);
          
        } else {
//          statusRequest = StatusRequest.failure;
          AwesomeDialog(
            titleTextStyle:   
                       TextStyle(color: AppColor.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),          
                  descTextStyle: TextStyle(color: AppColor.black,fontSize: 16,),
                  context: context,
                  headerAnimationLoop: true,
                  dialogType: DialogType.warning,
                  width: 350,
                  animType: AnimType.bottomSlide,
                  dialogBackgroundColor: AppColor.thirdColor,
                  showCloseIcon: true,
                  title: "تحذير",
                  desc: response['status_code'] == 422
                      ?"رمز التحقق غير صحيح أو انتهت صلاحيته"// "كلمة المرور لمرة واحدة مقدمة غير صحيحة أو انتهت صلاحيتها"
                      :  "يوجد خطأ ما أعد المحاولة"
                    )
              .show();
        }
      } else {
        AwesomeDialog(
          titleTextStyle:   
                       TextStyle(color: AppColor.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),          
                  descTextStyle: TextStyle(color: AppColor.black,fontSize: 16,),
                context: context,
                headerAnimationLoop: true,
                dialogType: DialogType.error,
                width: 350,
                animType: AnimType.bottomSlide,
                dialogBackgroundColor: AppColor.thirdColor,
                showCloseIcon: true,
                title: "خطأ",
                desc: "حدث خطأ ما")
            .show();
      }
    
    emit(VerifyFnishState());
  }

  CheckCode(BuildContext context ,String code){
        Navigator.pushNamed(context, AppRoute.resetPassword);
                          
   
  } 
  reSendCode(){
   
  }
    void startCountdown() {
secondsRemaining= 60;
canResend= false;
emit(state);
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final newSeconds = secondsRemaining - 1;

      if (newSeconds > 0) {
      secondsRemaining= newSeconds;
       canResend= false;
       emit(CheckCodeTimerdownState());
      } else {
        timer.cancel();
        //emit(CountdownState(secondsRemaining: 0, canResend: true));
        secondsRemaining= 0;
        canResend= true;
        emit(CheckCodeTimerdownState());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
 
  init(){
    formState=GlobalKey();
    number=TextEditingController();
   startCountdown();
  }
}

