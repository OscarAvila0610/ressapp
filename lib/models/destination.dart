import 'dart:convert';

class Destino {
  Destino({
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

  factory Destino.fromJson(String str) => Destino.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Destino.fromMap(Map<String, dynamic> json) => Destino(
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

  @override
  String toString() {
    return 'Destino: $nombre';
  }
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
