String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Escriba su correo';
  }
  final hasMatch = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email);
  if (!hasMatch) {
    return 'Correo electrónico inválido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null) {
    return 'Escriba su contraseña';
  }
  if (password.length < 6) {
    return 'Mínimo 6 caracteres';
  }
  return null;
}

String? usernameValidator(String? username) {
  if (username == null) {
    return 'Escriba su nombre de usuario';
  }
  if (username.length < 5) {
    return 'Mínimo 5 caracteres';
  }
  if (username.length > 12) {
    return 'Máximo 12 caracteres';
  }
  final hasMatch = RegExp(r"^[a-zA-Z0-9]+$").hasMatch(username);
  if (!hasMatch) {
    return 'Sólo puede contener letras y números';
  }
  return null;
}

String? usernameSearchValidator(String? username) {
  if (username == null || username.isEmpty) {
    return 'Escriba un nombre de usuario';
  }
  if (username.length > 12) {
    return 'Máximo 12 caracteres';
  }
  final hasMatch = RegExp(r"^[a-zA-Z0-9]+$").hasMatch(username);
  if (!hasMatch) {
    return 'Sólo puede contener letras y números';
  }
  return null;
}
