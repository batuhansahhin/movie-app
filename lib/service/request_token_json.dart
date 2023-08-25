class RequestTokenJSON {
  String? requestToken;

  RequestTokenJSON({requestToken});

  RequestTokenJSON.fromJson(Map<String, dynamic> json) {
    requestToken = json['request_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_token'] = requestToken;
    return data;
  }
}
