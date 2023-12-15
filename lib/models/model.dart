class Student {
  String? iD;
  String? name;
  String? gender;
  String? className;
  String? seat;
  String? club;
  String? persona;
  String? crush;
  String? breastSize;
  String? strength;
  String? hairstyle;
  String? color;
  String? eyes;
  String? eyeType;
  String? stockings;
  String? accessory;
  String? scheduleTime;
  String? scheduleDestination;
  String? scheduleAction;
  String? info;

  Student({
    this.iD,
    this.name,
    this.gender,
    this.className,
    this.seat,
    this.club,
    this.persona,
    this.crush,
    this.breastSize,
    this.strength,
    this.hairstyle,
    this.color,
    this.eyes,
    this.eyeType,
    this.stockings,
    this.accessory,
    this.scheduleTime,
    this.scheduleDestination,
    this.scheduleAction,
    this.info,
  });

  Student.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    gender = json['Gender'];
    className = json['Class'];
    seat = json['Seat'];
    club = json['Club'];
    persona = json['Persona'];
    crush = json['Crush'];
    breastSize = json['BreastSize'];
    strength = json['Strength'];
    hairstyle = json['Hairstyle'];
    color = json['Color'];
    eyes = json['Eyes'];
    eyeType = json['EyeType'];
    stockings = json['Stockings'];
    accessory = json['Accessory'];
    scheduleTime = json['ScheduleTime'];
    scheduleDestination = json['ScheduleDestination'];
    scheduleAction = json['ScheduleAction'];
    info = json['Info'];
  }

  // Map<String, dynamic> toJson() {
  //   // ignore: prefer_collection_literals
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['ID'] = iD;
  //   data['Name'] = name;
  //   data['Gender'] = gender;
  //   data['Class'] = className;
  //   data['Seat'] = seat;
  //   data['Club'] = club;
  //   data['Persona'] = persona;
  //   data['Crush'] = crush;
  //   data['BreastSize'] = breastSize;
  //   data['Strength'] = strength;
  //   data['Hairstyle'] = hairstyle;
  //   data['Color'] = color;
  //   data['Eyes'] = eyes;
  //   data['EyeType'] = eyeType;
  //   data['Stockings'] = stockings;
  //   data['Accessory'] = accessory;
  //   data['ScheduleTime'] = scheduleTime;
  //   data['ScheduleDestination'] = scheduleDestination;
  //   data['ScheduleAction'] = scheduleAction;
  //   data['Info'] = info;
  // return data;
  // }
}
