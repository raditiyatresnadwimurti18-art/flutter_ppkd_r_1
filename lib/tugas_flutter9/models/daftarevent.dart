// To parse this JSON data, do
//
//     final daftarEvent = daftarEventFromJson(jsonString);

import 'dart:convert';

List<DaftarEvent> daftarEventFromJson(String str) => List<DaftarEvent>.from(
  json.decode(str).map((x) => DaftarEvent.fromJson(x)),
);

String daftarEventToJson(List<DaftarEvent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DaftarEvent {
  String? event;
  String? gambar;
  String? kuota;

  DaftarEvent({this.event, this.gambar, this.kuota});

  factory DaftarEvent.fromJson(Map<String, dynamic> json) => DaftarEvent(
    event: json["event"],
    gambar: json["gambar"],
    kuota: json["kuota"],
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "gambar": gambar,
    "kuota": kuota,
  };
}
