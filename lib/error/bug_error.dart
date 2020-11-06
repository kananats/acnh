part of 'error.dart';

class BugError implements Exception {
  const BugError();
}

class NoBugError implements BugError {}
