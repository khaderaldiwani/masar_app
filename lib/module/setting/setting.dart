import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/module/setting/cubit/setting_cubit.dart';
import 'package:masar/module/setting/cubit/setting_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import '../../shared/components/components/setting_component.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        SettingCubit cubit=SettingCubit.get(context)..initInfo();
       
        return HandlingDataRequst(
          statusRequest: cubit. statusRequest,
           widget: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            buildProfilItem(file:cubit.xfile,cubit: cubit,onPressed: ()async{
             AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      dialogType: DialogType.noHeader,
                        width: 350,
                      animType: AnimType.bottomSlide,
                      dialogBackgroundColor: AppColor.thirdColor,
                      showCloseIcon: true,
                     body:buildDialog(onTapFirst: () {
                      cubit.chooseImageFromGallery();
                            Navigator.pop(context);
                          
                     }, onTapSecond: (){
                             cubit.chooseImage();
                            Navigator.pop(context);
                     }
                     )
                    ).show(); 
            
            }),
            SizedBox(height: 10),
            
            Expanded(
              child: Container(
                width: double.infinity,
                // height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: AppColor.white,
                ),
              
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CustomListTile(
                        title: "اشعارات",
                        leading: Icons.notifications_active,
                        leadingColor: Colors.amberAccent,
                        trailing: Icons.arrow_forward_ios_rounded),
                    customDivider(),
                    CustomListTileSwitch(
                        title: "تغيير الثيم",
                        leading: Icons.brightness_6_rounded,
                        leadingColor: Colors.yellow,
                        trailing: Switch(value: CachHelper.getBool(key: "isDark") ?? true, onChanged: (value) {
                          cubit.changeThemeMode();
                          print("value=$value");
                          print("cubit.isDark=${SettingCubit.isDark}");
                        },)),
                    customDivider(),
                    CustomListTile(
                        title: "فريق المطورين",
                        leading: Icons.developer_mode_sharp,
                        leadingColor: AppColor.blue,
                        trailing: Icons.arrow_forward_ios_rounded),
                    customDivider(),
                    CustomListTile(
                        title: "الشكاوى",
                        leading: Icons.assignment_add,
                        leadingColor: Colors.blue,
                        trailing: Icons.arrow_forward_ios_rounded),
                    customDivider(),
                    CustomListTile(
                        title: "اقتراحات",
                        leading: Icons.settings_suggest,
                        leadingColor: AppColor.secaodColor,
                        trailing: Icons.arrow_forward_ios_rounded),
                    customDivider(),
                    CustomListTile(
                        title: "تسجيل الخروج",
                        leading: Icons.logout,
                        leadingColor: Colors.red,
                        textColor: Colors.red,
                        trailing: Icons.arrow_forward_ios_rounded,
                        onTap: (){
                          AwesomeDialog(
                        context: context,
                        headerAnimationLoop: true,
                        dialogType: DialogType.noHeader,
                          width: 350,
                        animType: AnimType.bottomSlide,
                        dialogBackgroundColor: AppColor.thirdColor,
                        showCloseIcon: true,
                      body: buildDialogLogout(
                        onTapFirst: (){
                      cubit.logout(context);
                       Navigator.of(context).pop();   
              
                      }, 
                      onTapSecond: (){
                     
                       
                       Navigator.of(context).pop();   
                      })
              
                      ).show();
                        }
                        ),
                  ],
                ),
              ),
            )
          ],
        )
      
           );
         
      },
    );
  }
}


class CameraCapturePage extends StatefulWidget {
  @override
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  XFile? _imageFile; // المتغير الذي سيحمل الصورة
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _imageFile = photo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("التقاط صورة")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_imageFile != null)
            Image.file(
              File(_imageFile!.path),
              height: 300,
            )
          else
            Text("لم يتم التقاط صورة بعد"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _takePhoto,
            child: Text("فتح الكاميرا"),
          ),
        ],
      ),
    );
  }
}
