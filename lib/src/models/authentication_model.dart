class AuthenticationModel {
  AuthenticationModel({
    required String accessToken,
    required int expiresIn,
  })  : _accessToken = accessToken,
        _expiresIn = expiresIn;

  final String? _accessToken;
  final int? _expiresIn;

  String? get accessToken => _accessToken;
  int? get expiresIn => _expiresIn;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      accessToken: json["accessToken"] ?? "",
      expiresIn: json["expiresIn"] ?? 0,
    );
  }

  @override
  String toString() {
    return "$_accessToken, $_expiresIn";
  }
}
