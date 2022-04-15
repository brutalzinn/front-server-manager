class Server {
  String? host;
  String? serverName;
  String? apiKey;

  Server(this.host, this.serverName, this.apiKey);

  Server.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    serverName = json['server_name'];
    apiKey = json['api_key'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['host'] = host;
    data['server_name'] = serverName;
    data['api_key'] = apiKey;

    return data;
  }

  @override
  String toString() {
    return '{ ${host}, ${serverName}, ${apiKey} }';
  }
}