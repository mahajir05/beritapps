import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

const String messageConnectionFailure = 'messageConnectionFailure';

class ClientFailure extends Failure {
  final int? code;
  final String? errorMessage;
  final Map<String, dynamic>? errors;

  ClientFailure({this.code, this.errorMessage, this.errors});

  @override
  List<Object?> get props => [code, errorMessage, errors];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $code, $errorMessage, $errors}';
  }
}

class ServerFailure extends Failure {
  final int? code;
  final String? errorMessage;

  ServerFailure({this.code, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $code, $errorMessage}';
  }
}

class CacheFailure extends Failure {
  final String errorMessage;

  CacheFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'CacheFailure{errorMessage: $errorMessage}';
  }
}

class ConnectionFailure extends Failure {
  final String errorMessage = messageConnectionFailure;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}

class RequestCancelledFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnknownFailure extends Failure {
  final String errorMessage;

  UnknownFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
