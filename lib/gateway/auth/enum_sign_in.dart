enum EnumSignInType {
  email,
  apple,
  google,
  line,
}

extension EnumSignInEx on EnumSignInType {

  int get type {
    switch (this) {
      case EnumSignInType.email:
        return 0;
      case EnumSignInType.apple:
        return 1;
      case EnumSignInType.google:
        return 2;
      case EnumSignInType.line:
        return 3;
    }
  }

  String get authType {
    const String firebaseAuth = 'firebase';
    const String lineAuth = 'line';

    switch (this) {
      case EnumSignInType.email:
        return firebaseAuth;
      case EnumSignInType.apple:
        return firebaseAuth;
      case EnumSignInType.google:
        return firebaseAuth;
      case EnumSignInType.line:
        return lineAuth;
    }
  }

  String get providerData {
    switch (this) {
      case EnumSignInType.email:
        return 'password';
      case EnumSignInType.apple:
        return 'apple.com';
      case EnumSignInType.google:
        return 'google.com';
      case EnumSignInType.line:
        return 'linecorp.com';
    }
  }

  String get label {
    switch (this) {
      case EnumSignInType.email:
        return 'メールアドレス';
      case EnumSignInType.apple:
        return 'Apple';
      case EnumSignInType.google:
        return 'Google';
      case EnumSignInType.line:
        return 'LINE';
    }
  }

}
