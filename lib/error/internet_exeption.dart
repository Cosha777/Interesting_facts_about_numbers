class InternetException implements Exception{
  final String? message;

  InternetException(this.message);

  @override
  String toString() => message ?? "Чтото с инетом";

}