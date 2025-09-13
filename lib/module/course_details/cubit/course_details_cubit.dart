import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/announcements_model.dart';
import 'package:masar/model/assessments_model.dart';
import 'package:masar/model/attendances_model.dart';
import 'package:masar/model/course_details_model.dart';
import 'package:masar/model/feedback_model.dart';
import 'package:masar/model/question_model.dart';
import 'package:masar/model/receipt_Model.dart';
import 'package:masar/module/Poll_&%20_Review/poll_%20&_review.dart';
import 'package:masar/module/Questions/questions.dart';
import 'package:masar/module/about_course_details/about_course_details.dart';
import 'package:masar/module/attendances/attendances.dart';
import 'package:masar/module/course_details/cubit/course_details_state.dart';
import 'package:masar/module/marks/marks.dart';
import 'package:masar/module/notification_course/notification_course.dart';
import 'package:masar/module/receipts_course/receipts_course.dart';
import 'package:masar/module/review_course_details/review_course_details.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/course_details_data.dart';
import 'package:masar/shared/network/remote/data/favorite_data.dart';
import 'package:masar/shared/network/remote/data/questions_answer_data.dart';
import 'package:masar/shared/network/remote/data/review_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final String courceID;
  final bool isRedisteredval;
  CourseDetailsCubit({required this.courceID,required this.isRedisteredval }) : super(CourseDetailsInitial()) {
    //   print("courceID $courceID");
init();
 getDataCourseDetails();
 

  }
  static CourseDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final formKeyCtreateReply = GlobalKey<FormState>();
  final commentCtrl = TextEditingController();
  final formKeyEdit = GlobalKey<FormState>();
  final formKeyEditAns = GlobalKey<FormState>();
  final controllerEditQues = TextEditingController();
  final controllerEditAns = TextEditingController();
  final controllercreateReply = TextEditingController();
   bool registered = false;
   List<String> tabs=[];
   List<Widget> pagestabs=[];
   List<void Function()> functabs=[] ;
  int currentIndexTap = 0;
  bool expanded = false;
  bool isView = false;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerListview = ScrollController();
  
  isRedistered() {
    registered=isRedisteredval;
  //  registered=true;//تجريب
    if (registered) {
      
      tabs = [
        'علامات',
        'اعلامات',
        'ايصالات ',
        'مجتمع',
        'استطلاع و مراجعة',
        'الحضور و الغياب',
        
        
      ];

      functabs = [
        initMarks,
        initAnnouncements,
        initReceipts,
        question,
        getReviewCourse,
        initAttendances,
        
      ];
      pagestabs = [
        const Marks(),
        const NotificationCourse(),
        const ReceiptsCourse(),
        const Questions(),
        const PollAndReview(),
        const Attendances(),
        
      ];

      initTabs(tabs);
    } 
    else {
      tabs = ['نبذة', 'مراجعات'];
        functabs = [
        initAbout,
        initReview,    
      ];
    
      pagestabs = [const AboutCourseDetails(), const ReviewCourseDetails()];
      initTabs(tabs);
    }

    changeCurrentIndexTap(0);
  }
  List<GlobalKey> tabKeys = [];

  void initTabs(List<String> tabs) {
    tabKeys = List.generate(tabs.length, (_) => GlobalKey());
  }

  void initLeaderboard() {}
 

  void initAbout() {

  }
  void initReview() {
getReviewCourse();
  }
 

  void changeCurrentIndexTap(int index) {
    currentIndexTap = index;

    // نحصل على Context الخاص بالتاب المطلوب
    final contextTab = tabKeys[index].currentContext;
    if (contextTab != null) {
      Scrollable.ensureVisible(
        contextTab,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5, // يجعله في وسط الشاشة
      );
    }
    
    emit(CourseDetailsChangeIndexTap());
    functabs[currentIndexTap]();
  }

 
  late double number;

  void showText() {
    expanded = !expanded;
    emit(CourseDetailsShowMore());
  }
  //لتوسيع و تصغير النص
///////////////
// late   List<bool> expandedListQues;
  
//   void initExpandedListQues(int itemCount) {
//     expandedListQues = List.generate(itemCount, (_) => false);
//   }
//   void toggleTextQues(int index) {
//     expandedListQues[index] = !expandedListQues[index];
//     emit(CourseDetailsShowMore());
//   }
/////////////
///////////////
// late   List<bool> expandedListAnn;
  
//   void initExpandedListAnn(int itemCount) {
//     expandedListAnn = List.generate(itemCount, (_) => false);
//   }
//   void toggleTextAnn(int index) {
//     expandedListAnn[index] = !expandedListAnn[index];
//     emit(CourseDetailsShowMore());
//   }
/////////////
// خاص بالأسئلة و الأجوبة لاظهار الردود
///////////
late List<bool> isViewReplyList;
  void initIsViewReplyList(int itemCount) {
    isViewReplyList = List.generate(itemCount, (_) => false);
  }
  void showReply(int index) {
    isViewReplyList[index] = !isViewReplyList[index];
    emit(CourseDetailsShowReply());
  }

//////////
bool isFaforite=false;
changeFavorite(){
  isFaforite=!isFaforite;
  emit(ChangeFavoriteState());
}
CourseDetailsModel courseDetails=CourseDetailsModel()  ;
 StatusRequest statusRequestCourseDetails = StatusRequest.loading;
   getDataCourseDetails() async {
   if (isClosed) return;
   statusRequestCourseDetails = StatusRequest.loading;
 if (!isClosed)  emit(CourseDetailsSuccessRequestState());
     String token=CachHelper.getString(key: "token")!;
   
     var response = await courseDetailsData.getCourseDetails(token,courceID);
     statusRequestCourseDetails = handlingResponse(response);
    print(response);

        
    if (statusRequestCourseDetails == StatusRequest.success) {
      if (response['success'] == true) {
        
       // listReceiptDetauls = [];
        ///////////////////
        Map courseResponse = response['data'];    
        courseDetails= CourseDetailsModel.fromJson(Map<String, dynamic>.from(courseResponse));
        isFaforite=courseDetails.is_favorited!;
             
     //   listReceiptDetauls.addAll(receiptsResponse.map((e) => ReceiptDetailsModel.fromJson(e)));
       //////////////
      
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
  if (!isClosed)  emit(CourseDetailsFinishRequestState());
   }
  
void initAnnouncements()  {
     getAnnouncements();
   
  }

  StatusRequest statusRequest = StatusRequest.none;

  

  QuestionsAnswerData questionsAnswerData = QuestionsAnswerData(Api());
  List<QuestionModel> listQuestions = [];

FavoriteData favoriteData= FavoriteData(Api());
createFavorite() {
  //   statusRequest = StatusRequest.loading;
 //     emit(CourseDetailsSuccessCreateQuestionState());
 if (isClosed) return;
      String token = CachHelper.getString(key: "token")!;
     // var response = 
     // await
       favoriteData.createFavorite(
          token, courceID);
     // statusRequest = handlingResponse(response);
     // print(response);
      // if (statusRequest == StatusRequest.success) {
      //   if (response['success'] == true) {
      //     ///////////////////
      //     await question();
      //     commentCtrl.clear();
      //     scrollControllerListview.animateTo(
      //         scrollControllerListview.position.maxScrollExtent + 80.0,
      //         duration: const Duration(seconds: 1),
      //         curve: Curves.easeIn);
      //     //  Map questionResponse = response['data'];
      //     //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
      //     //   listQuestions.add(receiptDetails);
      //     //   initExpandedList(listQuestions.length);
      //     //////////////
      //   } else {
      //     statusRequest = StatusRequest.failure;
      //   }
      // } else {
      //   statusRequest = StatusRequest.failure;
      // }
     if (!isClosed)  emit(CourseDetailsFinishCreateQuestionState());
    
  }

deleteFavorite() {
  //   statusRequest = StatusRequest.loading;
 //     emit(CourseDetailsSuccessCreateQuestionState());
 if (isClosed) return;
      String token = CachHelper.getString(key: "token")!;
      String studentID = CachHelper.getString(key: "id")!;
     // var response = 
     // await
       favoriteData.deleteFavorite(
          token, courceID,studentID);
     // statusRequest = handlingResponse(response);
     // print(response);
      // if (statusRequest == StatusRequest.success) {
      //   if (response['success'] == true) {
      //     ///////////////////
      //     await question();
      //     commentCtrl.clear();
      //     scrollControllerListview.animateTo(
      //         scrollControllerListview.position.maxScrollExtent + 80.0,
      //         duration: const Duration(seconds: 1),
      //         curve: Curves.easeIn);
      //     //  Map questionResponse = response['data'];
      //     //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
      //     //   listQuestions.add(receiptDetails);
      //     //   initExpandedList(listQuestions.length);
      //     //////////////
      //   } else {
      //     statusRequest = StatusRequest.failure;
      //   }
      // } else {
      //   statusRequest = StatusRequest.failure;
      // }
     if (!isClosed)  emit(CourseDetailsFinishCreateQuestionState());
    
  }

  getQuestions() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
  if (!isClosed)  emit(CourseDetailsSuccessGetQuestionState());
    String token = CachHelper.getString(key: "token")!;
    var response = await questionsAnswerData.getAllQuestions(token, courceID);
    statusRequest = handlingResponse(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        listQuestions = [];
        ///////////////////
        List questionsResponse = response['data'];
        listQuestions
            .addAll(questionsResponse.map((e) => QuestionModel.fromJson(e)));
        //////////////
         initIsViewReplyList(listQuestions.length);
       //  initExpandedListQues(listQuestions.length);
        if (listQuestions.isEmpty) {
        statusRequest = StatusRequest.failure;
          
        }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
    emit(CourseDetailsFinishGetQuestionState());
  }

createQuestion() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      emit(CourseDetailsSuccessCreateQuestionState());
      String token = CachHelper.getString(key: "token")!;

      var response = await questionsAnswerData.createQuestions(
          token, courceID, commentCtrl.text);
      statusRequest = handlingResponse(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          ///////////////////
          await question();
          commentCtrl.clear();
          scrollControllerListview.animateTo(
              scrollControllerListview.position.maxScrollExtent + 80.0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn);
          //  Map questionResponse = response['data'];
          //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
          //   listQuestions.add(receiptDetails);
          //   initExpandedList(listQuestions.length);
          //////////////
        } else {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      emit(CourseDetailsFinishCreateQuestionState());
    }
  }

  createReply(BuildContext context, String question_id, int index) async {
    if (formKeyCtreateReply.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      emit(CourseDetailsSuccessCreateAnswerState());
      String token = CachHelper.getString(key: "token")!;

      var response = await questionsAnswerData.createAnswer(
          token, question_id, controllercreateReply.text);
      statusRequest = handlingResponse(response);
      print(response);
      controllercreateReply.clear();
      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          ///////////////////
           question();
          isViewReplyList[index] = true;
          //  Map questionResponse = response['data'];
          //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
          //   listQuestions.add(receiptDetails);
          //   initExpandedList(listQuestions.length);
          //////////////
        } else {
          statusRequest = StatusRequest.failure;
        }
      } else if (statusRequest == StatusRequest.serverfailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("لا يمكن الرد مرتين على نفس السؤال"),
            duration: Duration(seconds: 4), // تختفي بعد ثانيتين
            //    behavior: SnackBarBehavior.floating, // يطفو فوق العناصر
          ),
        );
        isViewReplyList[index] = true;
      } else {
        statusRequest = StatusRequest.failure;
      }

      emit(CourseDetailsFinishCreateQuestionState());
    }
  }

  updateQuestion(BuildContext context, String questionsID) async {
    if (formKeyEdit.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      emit(CourseDetailsSuccessUpdateQuestionState());
      String token = CachHelper.getString(key: "token")!;

      var response = await questionsAnswerData.updateQuestions(
          token, questionsID, controllerEditQues.text);
      statusRequest = handlingResponse(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم تعديل السؤال بنجاح"),
            ),
          );
           question();
          controllerEditQues.clear();
        } else {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      emit(CourseDetailsFinishCreateQuestionState());
    }
  }

  updateAnswer(BuildContext context, String answerID) async {
    print("object");
    if (formKeyEditAns.currentState!.validate()) {
      print("/////////////////object");
      statusRequest = StatusRequest.loading;
      emit(CourseDetailsSuccessUpdateAnswerState());
      String token = CachHelper.getString(key: "token")!;

      var response = await questionsAnswerData.updateAnswer(
          token, answerID, controllerEditAns.text);
      statusRequest = handlingResponse(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم تعديل الإجابة بنجاح"),
              //     duration: Duration(seconds: 2), // تختفي بعد ثانيتين
              //    behavior: SnackBarBehavior.floating, // يطفو فوق العناصر
            ),
          );
          ///////////////////
           question();
          controllerEditAns.clear();
          //  Map questionResponse = response['data'];
          //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
          //   listQuestions.add(receiptDetails);
          //   initExpandedList(listQuestions.length);
          //////////////
        } else {
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      emit(CourseDetailsFinishUpdateAnswerState());
    }
  }

  deleteQuestion(String questionsID, BuildContext context) async {
    statusRequest = StatusRequest.loading;
    emit(CourseDetailsSuccessDeleteQuestionState());
    String token = CachHelper.getString(key: "token")!;

    var response =
        await questionsAnswerData.deleteQuestions(token, questionsID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم حذف السؤال بنجاح"),
            //     duration: Duration(seconds: 2), // تختفي بعد ثانيتين
            //    behavior: SnackBarBehavior.floating, // يطفو فوق العناصر
          ),
        );
        ///////////////////
         question();
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    emit(CourseDetailsFinishCreateQuestionState());
  }

  deleteAnswer(String answerID, BuildContext context) async {
    statusRequest = StatusRequest.loading;
    emit(CourseDetailsSuccessDeleteQuestionState());
    String token = CachHelper.getString(key: "token")!;

    var response = await questionsAnswerData.deleteAnswer(token, answerID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم حذف الاجابة بنجاح"),
            //     duration: Duration(seconds: 2), // تختفي بعد ثانيتين
            //    behavior: SnackBarBehavior.floating, // يطفو فوق العناصر
          ),
        );
        ///////////////////
         question();
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    emit(CourseDetailsFinishCreateQuestionState());
  }

  Future<void> question() async {
   await  getQuestions();
    

    
  }

  refreshTextFormField() {
    emit(refreshTextFormFieldState());
  }

  StatusRequest statusRequestFeedBack = StatusRequest.none;
  ReviewData reviewData = ReviewData(Api());

  List<FeedBackModel> listReview = [];
  int count = 0;
  int average = 0;

  getReviewCourse() async {
    if(isClosed) return;
    statusRequest = StatusRequest.loading;
   if(!isClosed) emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response = await reviewData.getCourcesFeedback(token, courceID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        listReview = [];
        ///////////////////
        count = response['data']['count'];
        average = response['data']['average'];
        List reviewsResponse = response['data']['feedbacks'];
        listReview
            .addAll(reviewsResponse.map((e) => FeedBackModel.fromJson(e)));
        //////////////
      if (listReview.isEmpty) {
      statusRequest = StatusRequest.failure;
        
      }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
 if(!isClosed)   emit(CourseDetailsFinishRequestState());
  }
StatusRequest statusRequestCreateReview = StatusRequest.none;
  
  createReview(String body, String rating) async {
    
    if(body=="") return 1;
    int result=-1;
    statusRequestCreateReview = StatusRequest.loading;
    emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response =
        await reviewData.createFeedback(token, courceID, body, rating);
    statusRequestCreateReview = handlingResponse(response);
          print(response);
    if (statusRequestCreateReview == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        getReviewCourse();
        //  commentCtrl.clear();
        //                     scrollControllerListview.animateTo(
        //                       scrollControllerListview.position.maxScrollExtent+50.0 ,
        //              duration:const Duration(seconds: 1),
        //               curve:Curves.easeIn
        //               );
        //  Map questionResponse = response['data'];
        //  QuestionModel  receiptDetails= QuestionModel.fromJson(Map<String, dynamic>.from(questionResponse));
        //   listQuestions.add(receiptDetails);
        //   initExpandedList(listQuestions.length);
        //////////////
     result= 0;
      }
      //  else {
      //  // statusRequest = StatusRequest.failure;
      //  return 1;
      // }
    } else 
    if (statusRequest == StatusRequest.serverfailure) {
      result= 2;
    }
     else {
      result= 2;
     }
     
    emit(CourseDetailsFinishRequestState());
  return result;
  }

  ///اعلامات
  CourseDetailsData courseDetailsData = CourseDetailsData(Api());
  List<AnnouncementsModel> listAnnouncements = [];

  List temp = [
    {
      "id": 1,
      "teacher": {
        "id": 1,
        "first_name": "مؤيد",
        "last_name": "العبدالله",
        "image": "${CachHelper.getString(key: "image")!}"
      },
      "body":
          " السلام عليكم يا صارامي مرحبا شو أخبارالسلام عليكم يا صارامي مرحبا شو أخبارالسلام عليكم يا صارامي مرحبا شو أخبارالسلام عليكم يا صارامي مرحبا شو أخبارالسلام عليكم يا صارامي مرحبا شو أخبار",
      "datetime": "2025-09-01T18:05:28.000000Z"
    },
    {
      "id": 12,
      "teacher": {
        "id": 1,
        "first_name": "حضر ",
        "last_name": "الديواني",
        "image": "${CachHelper.getString(key: "image")!}"
      },
      "body": " السلام عليكم يا  أخبارالسلام عليكم يا صارامي مرحبا شو أخبار",
      "datetime": "2025-09-01T18:05:28.000000Z"
    },
  ];
  getAnnouncements() async {
    statusRequest = StatusRequest.loading;
    emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response = await courseDetailsData.getAnnouncements(token, courceID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        listAnnouncements = [];
        ///////////////////

        List announcementsResponse = response['data'];//temp; 
        listAnnouncements.addAll(
            announcementsResponse.map((e) => AnnouncementsModel.fromJson(e)));
        //////////////
     //   initExpandedListAnn(listAnnouncements.length);
     if (listAnnouncements.isEmpty) {
        statusRequest = StatusRequest.failure;
       
     }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
    emit(CourseDetailsFinishRequestState());
  }

  //علامات
  List<AssessmentsModel> listAssessments = [];
  List tempMarks = [
    {
      "id": 3,
      "title": "الوحدة الأولى",
      "type": "شفهي",
      "date": "2025-09-01",
      "max_score": "60.00",
      "grades": [
        {
          "id": 2,
          "student": {
            "id": 1,
            "first_name": "محمد",
            "middle_name": "عبدالله",
            "last_name": "ياسين"
          },
          "score": 100,
          "notes": null
        }
      ]
    }
  ];

  getAssessments() async {
    if(isClosed)return;
    listAssessments = [];
    statusRequest = StatusRequest.loading;
  if(!isClosed)  emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response = await courseDetailsData.getassessments(token, courceID);
    statusRequest = handlingResponse(response);
    
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////

        List assessmentsResponse =response['data']; //tempMarks; //
        listAssessments.addAll(
            assessmentsResponse.map((e) => AssessmentsModel.fromJson(e)));
        //////////////
     if (listAssessments.isEmpty) {
       statusRequest = StatusRequest.failure;
     }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
  if(!isClosed)  emit(CourseDetailsFinishRequestState());
  }

  void initMarks() {
    getAssessments();
  }

  //حضور و غياب
  List<AttendancesModel> listAttendances = [];
  List tempAtt = [
    {
      "id": 1,
      "lecture": {"id": 1, "name": "Meed your uncle"},
      "status": "حاضر",
      "notes": null
    },
    {
      "id": 1,
      "lecture": {"id": 1, "name": "khader your uncle"},
      "status": "غائب",
      "notes": "كثير الحركة"
    },
  ];
  getAttendances() async {
   if (isClosed) return;
    statusRequest = StatusRequest.loading;
   if (!isClosed) emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response = await courseDetailsData.getAttendances(token, courceID);
    statusRequest = handlingResponse(response);
    //print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
     listAttendances = [];
   
        List attendancesResponse = response['data'];//tempAtt; 
        listAttendances.addAll(
            attendancesResponse.map((e) => AttendancesModel.fromJson(e)));
        //////////////
        if (listAttendances.isEmpty) {
        statusRequest = StatusRequest.failure;
       
     }
      } 
      // else {
      //   statusRequest = StatusRequest.failure;
      // }
    } 
    // else {
    //   statusRequest = StatusRequest.failure;
    // }
 if (!isClosed)   emit(CourseDetailsFinishRequestState());
  }

  void initAttendances() {
    getAttendances();
  }

  List<ReceiptModel> listReceiptsCourse = [];
  int total_paid = 0;
  int total_amount = 0;
  int remaining = 0;
  List tempRece = [
    {"id": 8, "name": "اللغة الإنكليزية", "amount": 400, "status": "مدفوع"},
    {"id": 9, "name": "اللغة الإنكليزية", "amount": 400, "status": "غير مدفوع"}
  ];
  getReceiptsCourse() async {
    listReceiptsCourse = [];
    statusRequest = StatusRequest.loading;
    emit(CourseDetailsSuccessRequestState());
    String token = CachHelper.getString(key: "token")!;

    var response = await courseDetailsData.getReceiptsCourses(token, courceID);
    statusRequest = handlingResponse(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        ///////////////////
        total_paid = response['data']['total_paid'];
        total_amount = response['data']['total_amount'];
        remaining = response['data']['remaining'];
        List ReceiptsResponse =  response['data']['receipts'];//tempRece;
        listReceiptsCourse
            .addAll(ReceiptsResponse.map((e) => ReceiptModel.fromJson(e)));
        //////////////
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    emit(CourseDetailsFinishRequestState());
  }

  void initReceipts() {
    getReceiptsCourse();
  }

  void init() {
    isRedistered();
  }
}
