import 'package:masar/shared/network/remote/status_requst.dart';

handlingResponse(response){

if(response is StatusRequest){
return response;
}else
{
return StatusRequest.success;
}

}