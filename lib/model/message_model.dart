class TreatmentModel {
  dynamic body, time, sender, receiver;


  TreatmentModel({
    this.body,
    this.time,
    this.sender,
    this.receiver,
  });

  TreatmentModel.fromJson(map) {
    body = map['body'];
    time = map['time'];
    sender = map['sender'];
    receiver = map['receiver'];
  }

  toJson() {
    return {
      'body': body,
      'time': time,
      'sender': sender,
      'receiver': receiver,
    };
  }
}
