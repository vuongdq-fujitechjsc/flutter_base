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

  bool isValidUsername() {
    if (this == null) {
      return false;
    }
    if (RegExp(r'^(?=.*[a-zA-Z0-9]).{7,14}')
        .hasMatch(this)) {
      return true;
    }
    return false;
  }

  bool isValidPassword() {
    if (this == null) {
      return false;
    }
    if (RegExp(r'^(?=.*[a-zA-Z0-9]).{8,14}')
        .hasMatch(this)) {
      return true;
    }
    return false;
  }
}
