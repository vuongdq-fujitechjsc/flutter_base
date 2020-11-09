extension MyString on String {
  bool isEmptyTrim() {
    if (this == null) {
      return true;
    }

    if (this.trim().isEmpty) {
      return true;
    }

    return false;
  }

  bool get isTrimNotEmpty => !isEmptyTrim();
}
