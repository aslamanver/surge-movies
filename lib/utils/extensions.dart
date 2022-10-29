import 'package:surge_movies/data/network/network_exceptions.dart';

extension ExceptionReader on Exception {
  String getUserMessage() {
    if (this is NetworkException) {
      return 'Connection error! please check your internet connection.';
    } else if (this is APIException) {
      return 'Something went wrong with the server, please try again .';
    } else {
      return 'Whoop! Something went wrong.';
    }
  }
}

bool asBool(dynamic value) {
  if (value is int) {
    return value == 1;
  } else {
    return value as bool;
  }
}
