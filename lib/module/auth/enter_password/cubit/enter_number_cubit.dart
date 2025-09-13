
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/enter_password/cubit/enter_number_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/auth/forgetPassword_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class EnterNumberCubit extends Cubit<EnterNumberState> {
  EnterNumberCubit() : super(EnterNumberInitial());
  static EnterNumberCubit get(BuildContext context)=>BlocProvider.of(context);
  late GlobalKey<FormState> formState;
  late TextEditingController username;
  
  StatusRequest statusRequest = StatusRequest.none;
  ForgetpasswordData forgetpasswordData = ForgetpasswordData(Api());

  @override
  sendApi(BuildContext context) async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      emit(ForgetpasswordLoadingState());
      var response = await forgetpasswordData.postData(
          username.text);
      statusRequest = handlingResponse(response);

      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          CachHelper.putString(
              key: "username", value: username.text);
         Navigator.pushNamed(
                          context,
                          AppRoute.checkPassword,
      );
          
        } else {
         // statusRequest = StatusRequest.failure;

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
                      ? "اسم المستخدم غير صحيح"
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
    }
    emit(ForgetpasswordFnishLoginState());
  }

  send(BuildContext context){
    if (formState.currentState!.validate()) {
      
      Navigator.pushNamed(
                          context,
                          AppRoute.checkPassword,
      );
    }
  }
 
  init(){
    formState=GlobalKey();
    username=TextEditingController();
  
  }
}
