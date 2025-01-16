class AuthenticationModel {
  AuthenticationModel({
    required String usuTxNome,
    required String usuNrId,
    required String token,
  })  : _usuTxNome = usuTxNome,
        _usuNrId = usuNrId,
        _token = token;

  final String? _usuTxNome;
  final String? _usuNrId;
  final String? _token;

  String? get usuTxNome => _usuTxNome;
  String? get usuNrId => _usuNrId;
  String? get token => _token;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      usuTxNome: json["usuTxNome"],
      usuNrId: json["usuNrId"],
      token: json["token"] ?? "",
    );
  }

  @override
  String toString() {
    return "$_token, $_usuNrId, $_token";
  }
}
