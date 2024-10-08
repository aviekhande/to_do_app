import 'dart:ffi';

class Tasks {
  String? task;
  String? date;
  String? time;
  String? id;
  bool? done;
  String? priority;
  String? alarm;
  bool? imp;
  String? note;
  List? files;

  Tasks({this.task, this.date, this.time ,required this.id, this.done ,this.priority,this.alarm,this.imp,this.note,this.files});

  Tasks.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    date = json['date'];
    time = json['time'];
    id = json['id'];
    done = json['done'];
    priority = json['priority'];
    alarm = json['alarm'];
    imp = json['imp'];
    note = json['note'];
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    data['id'] = id;
    data['done'] =done;
    data['priority'] = priority;
    data['alarm']= alarm;
    data['imp']=imp;
    data['note']=note;
    data['files'] = files;
    return data;
  }
}
