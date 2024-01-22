import 'package:my_project/constant/massege.dart';

validInput(String val, int min, int max) {
  if (val.isEmpty) {
    return messageInput;
  }

  if (val.length < min) {
    return "$messageInputMin $min";
  }

  if (val.length > max) {
    return "$messageInputMax $max";
  }
}
