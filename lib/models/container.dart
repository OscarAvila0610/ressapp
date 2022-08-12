import 'dart:convert';

class Contenedore {
    Contenedore({
        required this.id,
        required this.nombre,
        required this.uld,
        required this.usuario,
    });

    String id;
    String nombre;
    bool uld;
    _Usuario usuario;

    factory Contenedore.fromJson(String str) => Contenedore.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Contenedore.fromMap(Map<String, dynamic> json) => Contenedore(
        id: json["_id"],
        nombre: json["nombre"],
        uld: json["uld"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "uld": uld,
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