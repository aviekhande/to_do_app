class SessionController {
  static SessionController session = SessionController._internal();
  String? userId;
  factory SessionController(){
    return session;
  }
  
  SessionController._internal();
}