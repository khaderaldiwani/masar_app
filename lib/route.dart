import 'package:flutter/material.dart';
import 'package:masar/module/all_categories/all_categories.dart';
import 'package:masar/module/all_courses.dart/all_courses.dart';
import 'package:masar/module/all_teachers/all_teachers.dart';
import 'package:masar/module/auth/check_password/check_code.dart';
import 'package:masar/module/auth/enter_password/enter_password.dart';
import 'package:masar/module/auth/reset_password/reset_password.dart';
import 'package:masar/module/auth/success_reset_password/success_reset_password.dart';
import 'package:masar/module/course_details/course_details.dart';
import 'package:masar/module/course_details_registered/course_details_registered.dart';
import 'package:masar/module/courses/courses.dart';
import 'package:masar/module/e_receipt/e_receipt.dart';
import 'package:masar/module/favorite.dart/favorite.dart';
import 'package:masar/module/notification/notification.dart';
import 'package:masar/module/profile/profile.dart';
import 'package:masar/module/profileDetails/profileDetails.dart';
import 'package:masar/module/search/search.dart';
import 'package:masar/module/setting/setting.dart';
import 'package:masar/module/teacher_details/Teacher_profile.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/layout/home_layout/home_layout.dart';
import 'package:masar/module/auth/login/login.dart';
import 'package:masar/module/onboarding/onboarding.dart';
import 'package:masar/module/splash/splash.dart';

Map<String, Widget Function(BuildContext)> routes = {
 "/test":(context)=> CameraCapturePage(),
 //onboarding
 AppRoute.splash:(context)=>const SplashScreen(), 
 AppRoute.onboarding:(context)=>const Onboarding(),
 //auth
 AppRoute.login:(context)=>const Login(),
 AppRoute.enterPassword:(context)=>const EnterPassword(),
 AppRoute.checkPassword:(context)=>const CheckCode(),
 AppRoute.resetPassword:(context)=>const ResetPassword(),
 AppRoute.successResetPassword:(context)=>const SuccessResetPassword(),
 
 //
 AppRoute.homeLayout:(context)=> HomeLayout(),
 AppRoute.profile:(context)=>const Profile(),
 AppRoute.profileDetails:(context)=>const Profiledetails(),
 AppRoute.notification:(context)=> Notifications(),
 AppRoute.favorite:(context)=>const Favorite(),
 AppRoute.search:(context)=>const Search(),
 
 AppRoute.AllTeachers:(context)=>const AllTeachers(),
 AppRoute.TeacherProfile:(context)=>const TeacherProfile(),
 
 AppRoute.AllCategories:(context)=>const AllCategories(),
 AppRoute.AllCourses:(context)=>const AllCourses(),
 AppRoute.courses:(context)=>const Courses(),
 
 AppRoute.eReceipt:(context)=>const EReceipt(),
 AppRoute.courseDetails:(context)=>const CourseDetails(),
 AppRoute.courseDetailsRegistered:(context)=>const CourseDetailsRegistered(),
 

};