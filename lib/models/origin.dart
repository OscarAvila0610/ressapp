import 'dart:convert';

class Origene {
    Origene({
        required this.id,
        required this.prefijo,
        required this.pais,
        required this.nombre,
        required this.usuario,
    });

    String id;
    String prefijo;
    String pais;
    String nombre;
    _Usuario usuario;

    factory Origene.fromJson(String str) => Origene.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Origene.fromMap(Map<String, dynamic> json) => Origene(
        id: json["_id"],
        prefijo: json["prefijo"],
        pais: json["pais"],
        nombre: json["nombre"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
        "pais": pais,
        "nombre": nombre,
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
