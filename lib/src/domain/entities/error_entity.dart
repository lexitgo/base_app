class ErrorBase {
  String? message;
  StackTrace? stack;
  ErrorBase({this.message, this.stack});
}

class ErrorNoSession extends ErrorBase {
  ErrorNoSession() : super();
}

class ErrorNoSession2Test extends ErrorBase {
  ErrorNoSession2Test({String? message, StackTrace? stack}) : super(message: message,stack: stack);
}