import 'dart:convert';

class Aerolinea {
    Aerolinea({
        required this.id,
        required this.prefijo,
        required this.nombre,
        required this.estacion,
        required this.usuario,
    });

    String id;
    int prefijo;
    String nombre;
    String estacion;
    _Usuario usuario;

    factory Aerolinea.fromJson(String str) => Aerolinea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Aerolinea.fromMap(Map<String, dynamic> json) => Aerolinea(
        id: json["_id"],
        prefijo: json["prefijo"],
        nombre: json["nombre"],
        estacion: json["estacion"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
        "nombre": nombre,
        "estacion": estacion,
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