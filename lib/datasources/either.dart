sealed class Either<L extends Exception, R> {}

class Failure<L extends Exception, R> extends Either<L, R> {
  final L exception;
  Failure(this.exception);
}

class Success<L extends Exception, R> extends Either<L, R> {
  final R value;
  Success(this.value);
}
