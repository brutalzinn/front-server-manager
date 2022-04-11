class Server {
  String? host;
  String? serverName;

  Server(this.host, this.serverName);

  Server.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    serverName = json['server_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['host'] = host;
    data['server_name'] = serverName;
    return data;
  }

    @override
  String toString() {
    return '{ ${host}, ${serverName} }';
  }
}