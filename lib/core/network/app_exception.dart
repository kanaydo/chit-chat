class ApiException {
  String message;
  ApiException({this.message});
  @override
  String toString() {
    return message;
  }
}

class FatalException {
  String message;
  FatalException({this.message});
  @override
  String toString() {
    return message;
  }
}