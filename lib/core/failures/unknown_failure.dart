import 'package:todo/core/failures/failure.dart';

class UnknownFailure implements Failure {
  @override
  String getErrorMessage() {
    return "Encountered unknown error.";
  }
}
