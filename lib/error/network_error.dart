part of 'error.dart';

class NetworkError implements Exception {
  const NetworkError();
}

class InvalidStatusCodeNetworkError implements NetworkError {}

class DecodeNetworkError implements NetworkError {}
