// To parse this JSON data, do
//
//     final mobil = mobilFromMap(jsonString);

import 'dart:convert';

Mobil mobilFromMap(String str) => Mobil.fromMap(json.decode(str));

String mobilToMap(Mobil data) => json.encode(data.toMap());

class Mobil {
  Mobil({
    this.id,
    this.mobil,
    this.jumlah,
  });

  int id;
  String mobil;
  int jumlah;

  factory Mobil.fromMap(Map<String, dynamic> json) => Mobil(
    id: json["Id"] == null ? null : json["Id"],
    mobil: json["Mobil"] == null ? null : json["Mobil"],
    jumlah: json["Jumlah"] == null ? null : json["Jumlah"],
  );

  Map<String, dynamic> toMap() => {
    "Id": id == null ? null : id,
    "Mobil": mobil == null ? null : mobil,
    "Jumlah": jumlah == null ? null : jumlah,
  };
}
