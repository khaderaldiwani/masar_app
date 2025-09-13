import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/reset_password/cubit/reset_password_state.dart';
import 'package:masar/shared/components/components/setting_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/auth/changePassword_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
   static ResetPasswordCubit get(BuildContext context)=>BlocProvider.of(context);
  late GlobalKey<FormState> formState;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  
  StatusRequest statusRequest = StatusRequest.none;
  ChangepasswordData changepasswordData = ChangepasswordData(Api());

  @override
   resetApi(BuildContext context) async {

      if (formState.currentState!.validate()) {
      if (password.text != confirmPassword.text) {
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
                      desc: "حقل كلمة السر و تأكيدها غير متطابقان" 
                     
                    ).show(); 
            return;
      }
      statusRequest = StatusRequest.loading;
      emit(ResetPasswordLoadingState());
      String username=CachHelper.getString(key: "username")!;
      String code=CachHelper.getString(key: "code")!;
      var response = await changepasswordData.postData(
          username,code,password.text);
      statusRequest = handlingResponse(response);

      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          
         Navigator.pushNamed(
                          context,
                          AppRoute.successResetPassword,
         );
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
                      ? "لم تكتمل خطوة التحقق من OTP"
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
    emit(ResetPasswordFnishState());
  }


  reset(BuildContext context){
    if (formState.currentState!.validate()) {
      if (password.text != confirmPassword.text) {
         AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      dialogType: DialogType.error,
                        width: 350,
                      animType: AnimType.bottomSlide,
                      dialogBackgroundColor: AppColor.thirdColor,
                      showCloseIcon: true,
                      title: "خطأ",
                      desc: "حقل كلمة السر و تأكيدها غير متطابقان" 
                     
                    ).show(); 
            return;
      }
      
      Navigator.pushNamed(
                          context,
                          AppRoute.successResetPassword,
                        );
    }
  }
  bool obscure1=true;
  changeObscure1(){
      obscure1 = !obscure1;
      emit(ResetPasswordChangeObscure1());                      
  }
  bool obscure2=true;
  changeObscure2(){
      obscure2 = !obscure2;
      emit(ResetPasswordChangeObscure2());                      
  }
  init(){
    formState=GlobalKey();
    password=TextEditingController();
    confirmPassword=TextEditingController();

  }

}
