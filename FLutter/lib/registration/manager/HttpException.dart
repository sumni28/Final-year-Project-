class HttpException implements Exception{
  String errorMessage;
  HttpException({
    required this.errorMessage
  });

  String toString(){
    return errorMessage;
  }

}