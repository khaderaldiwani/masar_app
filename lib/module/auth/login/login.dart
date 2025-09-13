import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/enter_password/enter_password.dart';
import 'package:masar/module/auth/login/cubit/login_cubit.dart';
import 'package:masar/module/auth/login/cubit/login_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/auth_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/function/function.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => LoginCubit()..init(),
      child:    BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        LoginCubit cubit=LoginCubit.get(context);
        return Scaffold(
          body:HandlingDataRequst(
            statusRequest: cubit.statusRequest,
             widget: Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(20),
            child: Form(
              key:cubit.formState ,
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  logo(),
                  const SizedBox(height: 30),
                  customTitleAuth(text: "تسجيل الدخول"),
                  const SizedBox(height: 40),
                  const SizedBox(height: 5),
                  customFieldAuth(
                    validator: (val) {
                      return valid(val!, 80, 2);
                      
                    },
                    controller:cubit.userName ,
                    prefixIcon: Icons.person_outlined,
              
                    hintText: "اسم المستخدم",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 5),
                  customFieldAuth(
                    controller: cubit.password,
                    validator: (val) {
                    return valid(val!, 16, 8);
                      },
                    prefixIcon: Icons.lock_outline_rounded,
                    hintText: "كلمة المرور",
                    onPressedSuffex: (){
                          cubit.changeObscure();
                    },
                    suffixIcon: Icons.remove_red_eye_outlined,
                    obscureText: cubit.obscure,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                          value:cubit.active,
                          onChanged: (val) {
                            cubit.changeRemamber(val!);
                          }),
                      Text(
                        "ذكرني",
                        style: TextStyle(color: AppColor.black),
                      ),
                      Spacer(),
                      customForgetPass(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const EnterPassword()));
                        } 
                        ),
                    ],
                  ),

                  const SizedBox(height: 60),
                  customButtonAuth(
                      onPressed: () {

                        cubit.loginApi(context);
                      },
                      text: "تسجيل الدخول"
                      ),
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
