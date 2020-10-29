extension StringExtension on String {
  String capitalized() =>
      this.isEmpty ? this : this[0].toUpperCase() + this.substring(1);
}
