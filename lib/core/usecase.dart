import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/failure.dart';

abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call({required Params params});
}
