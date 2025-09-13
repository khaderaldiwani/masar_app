
sealed class CourseDetailsState  {
}

final class CourseDetailsInitial extends CourseDetailsState {}
final class CourseDetailsChangeIndexTap extends CourseDetailsState {}
final class CourseDetailsShowMore extends CourseDetailsState {}
final class CourseDetailsRegisteredChangeIndexTap extends CourseDetailsState {}
final class CourseDetailsShowReply extends CourseDetailsState {}
final class refreshTextFormFieldState extends CourseDetailsState {}
final class ChangeFavoriteState extends CourseDetailsState {}

//SuccessQuestion
final class CourseDetailsSuccessGetQuestionState extends CourseDetailsState {}
final class CourseDetailsSuccessCreateQuestionState extends CourseDetailsState {}
final class CourseDetailsSuccessUpdateQuestionState extends CourseDetailsState {}
final class CourseDetailsSuccessDeleteQuestionState extends CourseDetailsState {}
//FinishQuestion
final class CourseDetailsFinishGetQuestionState extends CourseDetailsState {}
final class CourseDetailsFinishCreateQuestionState extends CourseDetailsState {}
final class CourseDetailsFinishUpdateQuestionState extends CourseDetailsState {}
final class CourseDetailsFinishDeleteQuestionState extends CourseDetailsState {}
//SuccessAnswer 
final class CourseDetailsSuccessCreateAnswerState extends CourseDetailsState {}
final class CourseDetailsSuccessUpdateAnswerState extends CourseDetailsState {}
final class CourseDetailsSuccessDeleteAnswerState extends CourseDetailsState {}
//FinishAnswer
final class CourseDetailsFinishCreateAnswerState extends CourseDetailsState {}
final class CourseDetailsFinishUpdateAnswerState extends CourseDetailsState {}
final class CourseDetailsFinishDeleteAnswerState extends CourseDetailsState {}
//rating

final class CourseDetailsSuccessRequestState extends CourseDetailsState {}
final class CourseDetailsFinishRequestState extends CourseDetailsState {}
