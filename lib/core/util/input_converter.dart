import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final value = int.parse(str);
      if (value < 0) throw const FormatException(); // Ensure no negatives
      return Right(value);
    } on FormatException {
      return const Left(InvalidInputFailure('invalid input'));
    }
  }
}
