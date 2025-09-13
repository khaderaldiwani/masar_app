import 'package:flutter/material.dart';
import 'package:masar/shared/components/constant/app_color.dart';

Widget buildRowText({required String textOne,required String textTwo, }){
  return Row(
                  children: [
                    Text(textOne,style: TextStyle(color: AppColor.black,fontSize: 16),),
                    Expanded(
                      child: Text(textTwo,
                      style: TextStyle(color: AppColor.blue,fontSize: 17),
                      textAlign: TextAlign.end,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                 );
}
Widget customCardEReceipt({required List<Widget> children}){
  return Container(
            padding: EdgeInsets.all(15),
                decoration:BoxDecoration(
                  color: AppColor.thirdColor,
                  borderRadius: BorderRadius.circular(20)
                  ),
      
            child: Column(
              children:children,
            ),
          );
}
Widget buildRowTextAndButton({required String textOne,required String textButton }){
  return Row(
                children: [
                  Text(
                    textOne,
                    style: TextStyle(color: AppColor.black,fontSize: 16),
                   
                  ),
                  Spacer(),
                  Container(

                      height: 30,
                      width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.secaodColor,
                      borderRadius: BorderRadius.circular(10)
                  
                    ),
                    child: Text(
                      textButton,
                      style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      
                    ),
                  ),
                ],
              );
}