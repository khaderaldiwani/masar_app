import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/success_reset_password/cubit/success_reset_password_cubit.dart';
import 'package:masar/module/auth/success_reset_password/cubit/success_reset_password_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_images.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => SuccessResetPasswordCubit()..init(context),
      child:    BlocConsumer<SuccessResetPasswordCubit, SuccessResetPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
      body:Container(
        decoration: BoxDecoration(
 
        ),
        child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.success2),height: 300,width: 350,),
          //  Icon(Icons.flutter_dash, size: 100, color: Colors.white),
            //SizedBox(height: 20),
            Text(
              "تمت استعادة كلمة المرور بنجاح",
              style: TextStyle(fontSize: 25, color: AppColor.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ) 
        ) 
      
    );
 },
    )
    );
    

  }
}
