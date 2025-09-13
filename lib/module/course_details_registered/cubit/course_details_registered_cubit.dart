import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/Leaderboard/leaderboard.dart';
import 'package:masar/module/Poll_&%20_Review/poll_%20&_review.dart';
import 'package:masar/module/Questions/questions.dart';
import 'package:masar/module/about_course_details/about_course_details.dart';
import 'package:masar/module/course_details_registered/cubit/course_details_registered_state.dart';
import 'package:masar/module/marks/marks.dart';
import 'package:masar/module/notification_course/notification_course.dart';
import 'package:masar/module/receipts_course/receipts_course.dart';
import 'package:masar/module/review_course_details/review_course_details.dart';

class CourseDetailsRegisteredCubit extends Cubit<CourseDetailsRegisteredState> {
  CourseDetailsRegisteredCubit() : super(CourseDetailsRegisteredInitial());
  static CourseDetailsRegisteredCubit get(BuildContext context)=>BlocProvider.of(context);
  late  List<String> tabs;
  
  List<Widget> pagestabs=[Marks(),NotificationCourse(),ReceiptsCourse(),Questions(),PollAndReview(),Leaderboard()];
int currentIndexTap=0;
  final ScrollController scrollController = ScrollController();
  // أضف مفاتيح لكل تاب
List<GlobalKey> tabKeys = [];

// أنشئ المفاتيح عند تحميل التابات
void initTabs(List<String> tabs) {
  tabKeys = List.generate(tabs.length, (_) => GlobalKey());
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

  emit(CourseDetailsRegisteredChangeIndexTap());
}

// void changeCurrentIndexTap(int index,double width){
// currentIndexTap=index;
// scrollController.animateTo(index*width, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

// emit(CourseDetailsRegisteredChangeIndexTap());
// }
  bool expanded = false;
  
void showText(){
 expanded = !expanded;
 emit(CourseDetailsRegisteredShowMore());
}
 void init(){
  tabs=['علامات','اشعارات','ايصالات ','أسئلة','استطلاع و مراجعة','لوحة الصدارة'];
initTabs(tabs);  
}
}
