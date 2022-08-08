// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class Usuario {
  Usuario({
    required this.nombre,
    required this.correo,
    required this.rol,
    required this.estado,
    required this.exportador,
    required this.uid,
    this.img,
  });

  String nombre;
  String correo;
  String rol;
  bool estado;
  Exportador exportador;
  String uid;
  String? img;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        correo: json["correo"],
        rol: json["rol"],
        estado: json["estado"],
        exportador: Exportador.fromMap(json["exportador"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "correo": correo,
        "rol": rol,
        "estado": estado,
        "exportador": exportador.toMap(),
        "uid": uid,
      };
}

class Exportador {
  Exportador({
    required this.id,
    required this.nombre,
  });

  String id;
  String nombre;

  factory Exportador.fromJson(String str) =>
      Exportador.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Exportador.fromMap(Map<String, dynamic> json) => Exportador(
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
      };
}
