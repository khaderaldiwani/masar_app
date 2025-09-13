import 'package:masar/link_api.dart';
import 'package:masar/shared/network/remote/http_helper.dart';

class QuestionsAnswerData {
  Api api;
QuestionsAnswerData(this.api);
  getAllQuestions(String token,String courseID)async{

   var response=await api.getDataWithToken(
    "${LinkApi.allQuestions}${courseID}/qna",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  createQuestions(String token,String course_id,String body)async{

   var response=await api.postDataWithToken(
    "${LinkApi.craeteQuestions}",{
     "course_id":course_id,
     "body":body,

    },
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }

  updateQuestions(String token,String questionsID,String updateQuestionsText)async{

   var response=await api.putDataWithToken(
    "${LinkApi.updateQuestions}${questionsID}",{
      "body": updateQuestionsText
    },
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  deleteQuestions(String token,String questionsID)async{

   var response=await api.deleteDataWithToken(
    "${LinkApi.DeleteQuestions}${questionsID}",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  createAnswer(String token,String question_id,String body)async{

   var response=await api.postDataWithToken(
    "${LinkApi.createAnswer}",{
     "question_id":question_id,
     "body":body,

    },
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }

  updateAnswer(String token,String answerID,String updateAnswerText)async{

   var response=await api.putDataWithToken(
    "${LinkApi.updateAnswer}${answerID}",{
      "body": updateAnswerText
    },
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
  deleteAnswer(String token,String answerID)async{

   var response=await api.deleteDataWithToken(
    "${LinkApi.deleteAnswer}${answerID}",
    token
    ); 

   return response.fold((l)=>l, (r)=>r);
  }
}