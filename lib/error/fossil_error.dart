part of 'error.dart';

class FossilError implements Exception {
  const FossilError();
}

class NoFossilError implements FossilError {}
