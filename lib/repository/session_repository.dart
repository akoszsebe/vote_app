class SessionRepository {
  static final SessionRepository _singleton = new SessionRepository._internal();

  String _salt;
  String _authToken;

  factory SessionRepository() {
    return _singleton;
  }

  SessionRepository._internal();

  String getSalt() => _salt;

  void setSalt(salt) => this._salt = salt;

  String getAuthToken() => _authToken;

  void setAuthToken(authToken) => this._authToken = authToken;
}
