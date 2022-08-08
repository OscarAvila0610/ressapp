import 'dart:convert';

class Exportadore {
    Exportadore({
        required this.id,
        required this.nombre,
        required this.direccion,
        required this.telefono,
        required this.codigoIata,
        required this.usuario,
    });

    String id;
    String nombre;
    String direccion;
    int telefono;
    int codigoIata;
    _Usuario usuario;

    factory Exportadore.fromJson(String str) => Exportadore.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Exportadore.fromMap(Map<String, dynamic> json) => Exportadore(
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        codigoIata: json["codigoIata"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "codigoIata": codigoIata,
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

    factory _Usuario.fromJson(String str) => _Usuario.fromMap(json.decode(str));

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