class Stats {
  String? server;
  String? memoryUsed;
  String? totalMem;
  double? diskPercent;
  double? cpuPercent;

  Stats(
      {this.server,
      this.memoryUsed,
      this.totalMem,
      this.diskPercent,
      this.cpuPercent});

  Stats.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    memoryUsed = json['memory_used'];
    totalMem = json['total_mem'];
    diskPercent = json['disk_percent'];
    cpuPercent = json['cpu_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = server;
    data['memory_used'] = memoryUsed;
    data['total_mem'] = totalMem;
    data['disk_percent'] = diskPercent;
    data['cpu_percent'] = cpuPercent;
    return data;
  }
}