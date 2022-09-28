import 'dart:convert';

class ModulesResponse {
    ModulesResponse({
        required this.total,
        required this.modulos,
    });

    int total;
    List<Modulo> modulos;

    factory ModulesResponse.fromJson(String str) => ModulesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModulesResponse.fromMap(Map<String, dynamic> json) => ModulesResponse(
        total: json["total"],
        modulos: List<Modulo>.from(json["modulos"].map((x) => Modulo.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "modulos": List<dynamic>.from(modulos.map((x) => x.toMap())),
    };
}

class Modulo {
    Modulo({
        required this.id,
        required this.nombre,
        required this.ruta,
        required this.icono,
        required this.rol,
    });

    String id;
    String nombre;
    String ruta;
    String icono;
    String rol;

    factory Modulo.fromJson(String str) => Modulo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Modulo.fromMap(Map<String, dynamic> json) => Modulo(
        id: json["_id"],
        nombre: json["nombre"],
        ruta: json["ruta"],
        icono: json["icono"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "ruta": ruta,
        "icono": icono,
        "rol": rol,
    };
}
