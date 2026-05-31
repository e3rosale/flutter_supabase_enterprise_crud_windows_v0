import '../error/failure.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  const Result._({this.data, this.failure});

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;
  String? get error => failure?.message;

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(String error) {
    return Result._(
      failure: Failure(type: FailureType.unknown, message: error),
    );
  }

  factory Result.failureOf(Failure failure) => Result._(failure: failure);
}
