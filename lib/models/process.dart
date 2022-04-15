class Process {
  String? name;
  int? pid;
  String? username;
  String? memory;

  Process({this.name, this.pid, this.username, this.memory});

  Process.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pid = json['pid'];
    username = json['username'];
    memory = json['memory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['pid'] = pid;
    data['username'] = username;
    data['memory'] = memory;
    return data;
  }
}