import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:masar/module/auth/check_password/cubit/check_code_cubit.dart';
import 'package:masar/module/auth/check_password/cubit/check_code_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/auth_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/components/shared_component.dart';

class CheckCode extends StatelessWidget {
  const CheckCode({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => CheckCodeCubit()..init(),
      child:    BlocConsumer<CheckCodeCubit, CheckCodeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CheckCodeCubit cubit=CheckCodeCubit.get(context);
        return Scaffold(
          body: HandlingDataRequst(
            statusRequest:cubit. statusRequest,
             widget:      Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Text("مسار",style: TextStyle(color: AppColor.primaryColor,fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                const SizedBox(height: 100),
                customTitleAuth(text: "ادخل رمز التحقق"),
                const SizedBox(height: 5),
                defaultSmaleTitle(title: "تم ارسال رمز التحقق عبر الوتساب إلى الرقمك",color: AppColor.greyapp),
                const SizedBox(height: 40),
                                  
                Directionality(
                  textDirection: TextDirection .ltr,
                  child: OtpTextField(
                          numberOfFields: 6,
                          showFieldAsBox: true,
                          textStyle: TextStyle(color:  AppColor.black,fontSize: 16), 
                          onCodeChanged: (String code) {
                          },
                          fieldWidth: 45,
                          borderRadius: BorderRadius.circular(10),
                          borderWidth: 0,
                          disabledBorderColor: AppColor.thirdColor,
                          filled: true,
                          fillColor: AppColor.thirdColor,
                          onSubmit: (String verificationCode){
                              // showDialog(
                              //     context: context,
                              //     builder: (context){
                              //     return AlertDialog(
                              //     title: Text("Verification Code"),
                              //     content: Text('Code entered is $verificationCode'),
                              //     );
                              //     }
                              // );
                              cubit.CheckCodeApi(context,verificationCode);
                          }, // end onSubmit
                      ),
                ),
                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                defaultSmaleTitle(title: "لم تستقبل رمز بعد؟ ",color: AppColor.greyapp),
                 cubit.canResend?
                   InkWell(
                onTap: (){
            cubit.reSendCode();
            cubit.startCountdown();
                },
                child: defaultBodyTitle(title: "اعادة ارسال",color: AppColor.primaryColor)
                ):
                Row(
                  children: [
                    defaultSmaleTitle(title: "ارسال رمز جديد بعد ",color: AppColor.greyapp),
                    defaultBodyTitle(title: "00:${cubit.secondsRemaining}",color: AppColor.primaryColor),
               
                  ],
                )
                  
                
                
                  ],
                )
              
              ],
            ),
          ),
      
             )
        );
      },
    )
    );
    

  }
}
