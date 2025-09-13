import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/auth/enter_password/cubit/enter_number_cubit.dart';
import 'package:masar/module/auth/enter_password/cubit/enter_number_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/auth_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/function/function.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => EnterNumberCubit()..init(),
      child:    BlocConsumer<EnterNumberCubit, EnterNumberState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        EnterNumberCubit cubit=EnterNumberCubit.get(context);
        return Scaffold(
          body: HandlingDataRequst(
            statusRequest: cubit.statusRequest,
             widget: Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(20),
            child: Form(
              key:cubit.formState ,
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Text("مسار",style: TextStyle(color: AppColor.primaryColor,fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  const SizedBox(height: 100),
                  customTitleAuth(text: "استرجاع كلمة المرور"),
                  const SizedBox(height: 5),
                  defaultSmaleTitle(title: "أدخل اسم المستخدم الخاص بك لتتمكن من استرجاع كلمة المرور",color: AppColor.greyapp),
                  const SizedBox(height: 60),
                                    
                  customFieldAuth(
                    validator: (val) {
                      return valid(val!, 80, 2);
                      
                    },
                    controller:cubit.username ,
                    prefixIcon: Icons.person_outlined,
                    keyboardType: TextInputType.text,
                    hintText: "أدخل اسم المستخدم",
                  ),
                  
                  const SizedBox(height: 20),
                  customButtonAuth(
                      onPressed: () {

                        cubit.sendApi(context);
                      },
                      text: "ارسال" 
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
