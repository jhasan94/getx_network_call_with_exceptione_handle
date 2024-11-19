import 'package:equatable/equatable.dart';
import 'failures.dart';

class ErrorObject extends Equatable {
  const ErrorObject({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  static ErrorObject mapFailureToErrorObject({required FailureEntity failure}) {
    return failure.when(
      serverFailure: () => const ErrorObject(
        title: "error",
        message: 'It seems that the server is not reachable at the moment, try '
            'again later',
      ),
      dataParsingFailure: () => const ErrorObject(
        title: "error",
        message: 'It seems that the app needs to be updated to reflect the , '
            'changed server data structure, if no update is '
            'available on the store please reach out to the developer at dev@sakan.com',
      ),
      noConnectionFailure: () => const ErrorObject(
        title: "error",
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      ),
      clientFailure: () => const ErrorObject(
        title: 'error',
        message: 'It seems that something went wrong, '
            'please try again later.',
      ),
      unknownFailure: () => const ErrorObject(
        title: "error",
        message: 'It seems that something went wrong, '
            'please try again later.',
      ),
      unAuthorizedFailure: () => const ErrorObject(
        title: "error",
        message: 'It seems that you are not logged in',
      ),
      badRequestFailure: (String message) => ErrorObject(
        title: "error",
        message: message,
      ),
    );
  }
}
