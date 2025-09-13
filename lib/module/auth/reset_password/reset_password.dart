import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:masar/module/auth/reset_password/cubit/reset_password_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/auth_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/function/function.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => ResetPasswordCubit()..init(),
      child:    BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ResetPasswordCubit cubit=ResetPasswordCubit.get(context);
        return Scaffold(
          body: HandlingDataRequst(
            statusRequest: cubit.statusRequest,
             widget:     Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(20),
            child: Form(
              key:cubit.formState ,
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Text("مسار",style: TextStyle(color: AppColor.primaryColor,fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  const SizedBox(height: 100),
                  customTitleAuth(text: "أدخل كلمة المرور الجديدة"),
                  const SizedBox(height: 5),
                  defaultSmaleTitle(title: "يجب أن تكون كلمة المرور 8 أحرف على الأقل",color: AppColor.greyapp),
                  const SizedBox(height: 60),
                  customFieldAuth(
                    controller: cubit.password,
                    validator: (val) {
                    return valid(val!, 16, 8);
                      },
                    prefixIcon: Icons.lock_outline_rounded,
                    hintText: "كلمة المرور الجديدة",
                    onPressedSuffex: (){
                          cubit.changeObscure1();
                    },
                    suffixIcon: Icons.remove_red_eye_outlined,
                    obscureText: cubit.obscure1,
                  ),
                 
                  const SizedBox(
                    height: 20,
                  ),
                  customFieldAuth(
                    controller: cubit.confirmPassword,
                    validator: (val) {
                    return valid(val!, 16, 8);
                      },
                    prefixIcon: Icons.lock_outline_rounded,
                    hintText: "أعد كتابة كلمة المرور",
                    onPressedSuffex: (){
                          cubit.changeObscure2();
                    },
                    suffixIcon: Icons.remove_red_eye_outlined,
                    obscureText: cubit.obscure2,
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 60),
                  customButtonAuth(
                      onPressed: () {

                        cubit.resetApi(context);
                      },
                      text: "متابعة"),
                ],
              ),
            ),
          ),
      
             ) 
        );
      },
    )
    );
    

  }
}
