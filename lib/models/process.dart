class ProcessModel {
  String? name;
  int? pid;
  String? username;
  String? memory;

  ProcessModel({this.name, this.pid, this.username, this.memory});

  ProcessModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pid = json['pid'];
    username = json['username'];
    memory = json['memory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['pid'] = pid;
    data['username'] = username;
    data['memory'] = memory;
    return data;
  }
// gambiarra sem elegância.

   static List<ProcessModel> toList(dynamic json)  {
    if(json == null) return [];
    var list = json as List;
    return list.map((i)=>ProcessModel.fromJson(i)).toList();
  }
}