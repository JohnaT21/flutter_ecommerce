bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

String? emailValidator(String? content) {
  if (content == null) {
    return "Unknown error";
  } else if (content.isEmpty) {
    return "Email cannot be empty";
  } else if (!isValidEmail(content)) {
    return "Invalid email";
  } else {
    return null;
  }
}

String? passwordValidator(String? content) {
  final pattern = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9]).+$');

  if (content == null) {
    return "Unknown error";
  } else if (content.isEmpty) {
    return "Password cannot be empty";
  } else if (content.length < 6) {
    return "Password cannot be less than 6 characters";
  } else if (!pattern.hasMatch(content)) {
    return "Password must contain at least one letter and one number";
  } else {
    return null;
  }
}

String? phoneValidator(String? content) {
  if (content == null) {
    return "Unknown error";
  } else if (content.isEmpty) {
    return "Phone number cannot be empty";
  } else if (content.length < 9) {
    return "Invalid phone number";
  } else {
    return null;
  }
}

String? nameValidator(String? content) {
  if (content == null) {
    return "Unknown error";
  } else if (content.isEmpty) {
    return "Name cannot be empty";
  } else {
    return null;
  }
}

String? requiredValidator(String? content) {
  if (content == null) {
    return "Unknown error";
  } else if (content.isEmpty) {
    return "Required*";
  } else {
    return null;
  }
}
