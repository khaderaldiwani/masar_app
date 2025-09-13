
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/success_reset_password/cubit/success_reset_password_state.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class SuccessResetPasswordCubit extends Cubit<SuccessResetPasswordState> {
  SuccessResetPasswordCubit() : super(SuccessResetPasswordInitial());
  static SuccessResetPasswordCubit get(BuildContext context)=>BlocProvider.of(context);
  goToLogin(BuildContext context){
    Timer(const Duration(seconds: 4), () {
    Navigator.pushNamedAndRemoveUntil(context, AppRoute.login, (route) => false,); 
    });
    emit(SuccessResetPasswordGoToLogin());
  }
  init(BuildContext context){
    goToLogin(context);
  }
}
