class Note {
  int _id;
  String _description;
  String _date;
  String _time;
  int _star;
  String _reminder;

  Note(this._date, this._time, this._star, this._reminder, [this._description]);

  Note.withId(this._id, this._date, this._time, this._star, this._reminder,
      [this._description]);

  int get id => _id;

  String get time => _time;

  String get description => _description;

  int get star => _star;

  String get date => _date;

  String get reminder => _reminder;

  set description(String newDescription) {
    this._description = newDescription;
  }

  set priority(int newStar) {
    this._star = newStar;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set time(String newTime) {
    this._time = newTime;
  }

  set reminder(String newReminder) {
    this._reminder = newReminder;
  }

  set star(int newStar) {
    this._star = newStar;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['description'] = _description;
    map['star'] = _star;
    map['date'] = _date;
    map['time'] = _time;
    map['reminder'] = _reminder;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._description = map['description'];
    this._star = map['star'];
    this._date = map['date'];
    this._time = map['time'];
    this._reminder = map['reminder'];
  }
}
