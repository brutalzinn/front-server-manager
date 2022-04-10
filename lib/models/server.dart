class Server {
  String? server;
  String? host;

  Server({this.server, this.host});

  Server.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = server;
    data['host'] = host;
    return data;
  }
}