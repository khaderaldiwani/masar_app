class LinkApi {
//server  
//192.168.43.74
static const String server="http://192.168.43.108:8000/api";//http://10.0.2.2:8000/api
//192.168.43.108//my mobil
static const String images="http://192.168.43.108:8000";
//192.168.20.18//xzone
//test
//static const String test="$server/test.php";

//Auth
static const String login="$server/auth/login";
static const String logout="$server/auth/logout";
static const String forgetPassword="$server/auth/forget-password";
static const String verify="$server/auth/verify";
static const String changePassword="$server/auth/change-password";
//home
static const String home="$server/student/home-page";
//allTeacher
static const String allTeacher="$server/student/teachers";
//search
static const String search="$server/student/courses";
//notification
static const String notifications="$server/student/notifications";
static const String notificationsRead="$server/student/notifications/read";
//setting
static const String settingImage="$server/student/profile-image";
//allCategories
static const String allCategories="$server/student/categories";
static const String courses="$server/student/categories/";
//receipts
static const String allReceipts="$server/student/";
static const String ReceiptDetails="$server/student/receipts/";

///////////courseDetails
//courseDetails
static const String courseDetails="$server/student/courses/";//1

//questions
static const String craeteQuestions="$server/student/courses/questions";
static const String updateQuestions="$server/student/courses/questions/";
static const String DeleteQuestions="$server/student/courses/questions/";
static const String allQuestions="$server/student/courses/";
//answer
static const String createAnswer="$server/student/courses/answers";
static const String updateAnswer="$server/student/courses/answers/";
static const String deleteAnswer="$server/student/courses/answers/";
//rating
static const String getCourcesFeedback="$server/student/courses/";
static const String createFeedback="$server/student/feedbacks";
//اعلامات announcements
static const String announcements="$server/student/courses/";//1/announcements
//علامات assessments
static const String assessments="$server/student/courses/";//1/assessments
//attendances حضور و غياب
static const String attendances="$server/student/courses/";//1/attendances
//courses/1/receipts
static const String receiptsCourses="$server/student/courses/";///1/receipts

////////////MyCourses

//upcoming
static const String myCoursesUpcoming="$server/student/my-courses/upcoming";
//Ongoing
static const String myCoursesOngoing="$server/student/my-courses/ongoing";
//Completed
static const String myCoursesCompleted="$server/student/my-courses/completed";
///////////studentProfile
//profile
static const String studentProfile="$server/student/profile";
//courses
static const String coursesStudentProfile="$server/student/profile/courses";

/////////////teacher
//Profile
static const String teacherProfile="$server/student/teachers/";//1/profile
//feedbackTeaher
static const String teacherFeedback="$server/student/teachers/";
//TeaherCourses
static const String teacherCourses="$server/student/teachers/";//1/courses
///////favorit
//create
static const createFavorite ="$server/student/favorites";
//delete
static const deleteFavorite ="$server/student/favorites/";//1

//getall
static const getallFavorite ="$server/student/favorites";

}