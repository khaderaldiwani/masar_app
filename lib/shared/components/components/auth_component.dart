import 'package:flutter/material.dart';
import 'package:masar/shared/components/constant/app_color.dart';



Widget CustomBodyAuth ({required String text}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColor.grey,
        fontSize: 18,
      ),
    );  
}

  Widget customTitleAuth({required String text}) {

    return Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColor.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            );
  }

  Widget customTextThinkAuth({required String textOne,required String textTwo}) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: textOne, //"Don\'t have an account? ",
          style: TextStyle(
            color: AppColor.grey,
            fontSize: 17,
            // fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: textTwo, //"SIGN UP",
          style: TextStyle(
            color: AppColor.blue,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ])),
    );
  }



  Widget customForgetPass({required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        "هل نسيت كلمة السر ؟",
        textAlign: TextAlign.end,
        style: TextStyle(
          color: AppColor.primaryColor,
          fontSize: 17,
        ),
      ),
    );
  
  }


  Widget customFieldAuth({
    required IconData prefixIcon,
    required TextEditingController controller,
    required String? Function(String?)? validator,
   IconData? suffixIcon,
   void Function()? onPressedSuffex,
  required String hintText,
   bool? obscureText,
   TextInputType? keyboardType
  }) {
    return TextFormField(
              validator:validator ,
              obscureText:obscureText ?? false ,
              controller: controller,
              keyboardType:keyboardType ,
              style: TextStyle(color: AppColor.black,fontSize: 16),
              decoration: InputDecoration(
                   
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  prefixIcon:  Icon(prefixIcon,color: AppColor.black,),
                  suffixIcon:obscureText!=null? IconButton(onPressed:onPressedSuffex , icon: Icon(obscureText==true? Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,color:AppColor.black)) :null,
                  fillColor:AppColor.white  ,//AppColor.greyLight
                  filled: true,
                  
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: AppColor.grey,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10))
                  ),
            );
  }

Widget customButtonAuth({required String text,required void Function() onPressed}) {
    return MaterialButton(
      height: 40,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColor.primaryColor,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
