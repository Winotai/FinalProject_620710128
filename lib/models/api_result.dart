class ApiResult {
  final bool success;
  final String? message;
  final dynamic data;

  ApiResult({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
