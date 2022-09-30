import 'dart:convert';

class Tipo {
    Tipo({
        required this.id,
        required this.prefijo,
        required this.nombre,
        required this.peligroso,
        required this.usuario,
    });

    String id;
    String prefijo;
    String nombre;
    bool peligroso;
    _Usuario usuario;

    factory Tipo.fromJson(String str) => Tipo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tipo.fromMap(Map<String, dynamic> json) => Tipo(
        id: json["_id"],
        prefijo: json["prefijo"],
        nombre: json["nombre"],
        peligroso: json["peligroso"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
        "nombre": nombre,
        "peligroso": peligroso,
        "usuario": usuario.toMap(),
    };
}

class _Usuario {
    _Usuario({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    String toJson() => json.encode(toMap());

    factory _Usuario.fromMap(Map<String, dynamic> json) => _Usuario(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}