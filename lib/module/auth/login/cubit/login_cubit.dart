import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/login/cubit/login_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/auth/login_data.dart';
import 'package:masar/shared/network/remote/firebase.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  late GlobalKey<FormState> formState;
  late TextEditingController userName;
  late TextEditingController password;

  bool active = false;
  changeRemamber(bool val) {
    active = val;
    emit(LoginChangeRemamber());
  }

  login(BuildContext context) {
    if (formState.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.homeLayout,
        (route) => false,
      );
    }
  }

  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Api());

  @override
  loginApi(BuildContext context) async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      emit(LoginLoadingState());
      String deviceToken=CachHelper.getString(key: "deviceToken")!;
      var response = await loginData.postData(
          userName.text, password.text, "5", deviceToken);
      statusRequest = handlingResponse(response);

      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          CachHelper.putString(
              key: "id", value: response['data']['user']['id'].toString());
          String id = CachHelper.getString(key: "id")!;
          CachHelper.putString(
              key: "token", value: response['data']['token']);

          //       FirebaseMessaging.instance.subscribeToTopic("users");
          //       FirebaseMessaging.instance.subscribeToTopic(id);
          CachHelper.putString(
              key: "username", value: response['data']['user']['username']);
          CachHelper.putString(
              key: "first_name", value: response['data']['user']['first_name']);
          CachHelper.putString(
              key: "middle_name", value: response['data']['user']['middle_name']);
          CachHelper.putString(
              key: "last_name", value: response['data']['user']['last_name']);
          CachHelper.putString(
              key: "phone", value: response['data']['user']['phone']);
          CachHelper.putString(
              key: "image", value: response['data']['user']['image']==null?"":response['data']['user']['image']);
          CachHelper.putString(
              key: "education_level",
              value: response['data']['user']['education_level']);
          CachHelper.putString(
              key: "birth_date", value: response['data']['user']['birth_date']);
           CachHelper.putString(
              key: "step", value: "2");
            FirebaseMessaging.instance.subscribeToTopic("students");
            FirebaseMessaging.instance.subscribeToTopic(id);
          
            Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoute.homeLayout,
                      (route) => false,
             );
          
        } else {
     //     statusRequest = StatusRequest.failure;

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
                      : response['status_code'] == 401
                          ? "كلمة المرور غير صحيحة"
                          : "يوجد خطأ ما أعد المحاولة")
              .show();
        }
      } else {
        AwesomeDialog(
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
    emit(LoginFnishLoginState());
  }

  bool obscure = true;
  changeObscure() {
    obscure = !obscure;
    emit(LoginChangeObscure());
  }

  init() {
    formState = GlobalKey();
    userName = TextEditingController();
    password = TextEditingController();
    CachHelper.putString(
              key: "step", value: "1");
   initFirebase();
  }

}
