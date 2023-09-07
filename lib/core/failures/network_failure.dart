import 'package:todo/core/failures/failure.dart';

class NetworkFailure implements Failure {
  @override
  String getErrorMessage() {
    return "Network error occured";
  }
}
