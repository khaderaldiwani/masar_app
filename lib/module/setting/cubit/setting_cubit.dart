import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/module/setting/cubit/setting_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/auth/logout_data.dart';
import 'package:masar/shared/network/remote/data/setting_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  static SettingCubit get(BuildContext context) => BlocProvider.of(context);
  static bool isDark = false;
 String? first_name ;
 
 String? last_name ;
 
 String? phone;
 
  changeThemeMode() {
    isDark = !isDark;
    CachHelper.putBool(key: "isDark", value: isDark);
    AppColor.intiColor(isDark);
    emit(SettingChangeModeState());
  }

  ImagePicker imagePicker = ImagePicker();
  File? file;
  XFile? xfile;
  Future<void> chooseImage() async {
    XFile? _xfile = await imagePicker.pickImage(source: ImageSource.camera);
    if (_xfile != null) {
      xfile = _xfile;
      file=File(xfile!.path);
      await  changeProfileImage(file!);                   
      emit(SettingChooseImageState());
    }
  }

  Future<void> chooseImageFromGallery() async {
    XFile? _xfile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (_xfile != null) {
      xfile = _xfile;
       file=File(xfile!.path);
    await changeProfileImage(file!);
      emit(SettingChooseImageState());
    }
  }

  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestImage = StatusRequest.none;
  LogoutData logoutData = LogoutData(Api());

  logout(BuildContext context) async {
    //CachHelper.putString(key: "step", value: "1");
    
    statusRequest = StatusRequest.loading;
    emit(SettingSuccessLogoutState());
    String deviceToken = CachHelper.getString(key: "deviceToken")!;

    String token = CachHelper.getString(key: "token")!;

    var response = await logoutData.Logout("5", deviceToken, token);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        CachHelper.putString(key: "step", value: "1");
        String id = CachHelper.getString(key: "id")!;

        FirebaseMessaging.instance.unsubscribeFromTopic("students");
        FirebaseMessaging.instance.unsubscribeFromTopic(id);

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.login,
          (route) => false,
        );
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    emit(SettingFnishLogoutState());
  }
SettingData settingData = SettingData(Api());

  changeProfileImage(File file) async {
    statusRequestImage = StatusRequest.loading;
    emit(SettingSuccessLogoutState());
    String token = CachHelper.getString(key: "token")!;

   
    var response = await settingData.postData(file, token);
    print(response);
    statusRequestImage = handlingResponse(response);
    
    if (statusRequestImage == StatusRequest.success) {
      if (response['success'] == true) {
       print("تمت العملية بنجاح");
        CachHelper.putString(
              key: "image", value: response['data']['image']);
          
      } else {
        statusRequest = StatusRequest.failure;
        print("response['success'] == false");
      }
    } else {
      print("statusRequest = StatusRequest.failure");
      statusRequest = StatusRequest.failure;
    }
    emit(SettingFnishLogoutState());
  }

void initInfo(){
  first_name =CachHelper.getString(key:"first_name")!;
 
 last_name =CachHelper.getString(key:"last_name")!;
 
  phone=CachHelper.getString(key:"phone")!;
}
  void init() {
//   isDark=false;
 
  }
}
