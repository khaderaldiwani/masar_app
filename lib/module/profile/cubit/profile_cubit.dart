import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masar/model/student_profile_model.dart';
import 'package:masar/model/top_courses_model.dart';
import 'package:masar/module/profile/cubit/profile_state.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/studen_profile_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(BuildContext context)=> BlocProvider.of(context);

  // void chooseImageFromGallery() {}

  // void chooseImage() {}
   
  
   ImagePicker imagePicker=ImagePicker();
        XFile?  file;
    Future<void> chooseImage()async{

    XFile?  _file =await imagePicker.pickImage(source: ImageSource.camera);
      if (_file!=null) {
        file=_file;
        emit(ProfileChooseImageState());
      }
    }
    Future<void> chooseImageFromGallery()async{

    XFile?  _file =await imagePicker.pickImage(source: ImageSource.gallery);
      if (_file!=null) {
        file=_file;
        emit(ProfileChooseImageState());
      }
    }
    goToProfileDetails(BuildContext context,StudentProfileModel model){
         Navigator.pushNamed(context, AppRoute.profileDetails,arguments:model);
         emit(ProfileGoToDetails());
                                   
    } 

     StatusRequest statusRequest = StatusRequest.none;
     StudenProfileData studenProfileData = StudenProfileData(Api());

StudentProfileModel studentProfile=StudentProfileModel()  ;
  
  getStudentProfile() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(ProfileSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;
    var response = await studenProfileData.getStudentProfile(token);
    statusRequest = handlingResponse(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        Map profileResponse = response['data'];
        studentProfile= StudentProfileModel.fromJson(Map<String, dynamic>.from(profileResponse));
        
         CachHelper.putString(
              key: "image", value: studentProfile.image==null?"":studentProfile.image!);
   //////////////
        // if (categories.isEmpty) {
        //   statusRequest = StatusRequest.failure;
        // }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(ProfileFinishRequestState());
  }


 List<TopCoursesModel> courses = [];
 StatusRequest statusRequestCourses = StatusRequest.none;
  getCourses() async {
    if (isClosed) return;
    statusRequestCourses = StatusRequest.loading;
    if (!isClosed) emit(ProfileSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;
    var response = await studenProfileData.getCoursesStudent(token);
    statusRequestCourses = handlingResponse(response);
    if (statusRequestCourses == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        courses = [];
           List coursesResponse = response['data'];
        courses.addAll(coursesResponse.map((e) => TopCoursesModel.fromJson(e)));
     
   //////////////
        if (courses.isEmpty) {
          statusRequestCourses = StatusRequest.failure;
        }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(ProfileFinishRequestState());
  }
 

  void init()async{
//   isDark=false;
await getStudentProfile();
getCourses();
  }
}
