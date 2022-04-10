class Server {
  String? host;
  String? serverName;

  Server(this.host, this.serverName);

  Server.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    serverName = json['server_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['server_name'] = this.serverName;
    return data;
  }
}