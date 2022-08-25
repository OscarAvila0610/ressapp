
import 'dart:convert';

class NewBooking {
    NewBooking({
        required this.aerolinea,
        required this.awb,
        required this.tipoCarga,
        required this.origen,
        required this.destino,
        required this.contenedor,
        required this.alto,
        required this.ancho,
        required this.largo,
        required this.pesoFisico,
        required this.pesoVolumetrico,
        required this.fechaSolicitud,
        required this.fechaSalida,
        required this.aprobacion,
        required this.cancelada,
        required this.usuario,
        required this.descripcion,
        required this.id,
    });

    PorNombre aerolinea;
    int awb;
    PorNombre tipoCarga;
    PorPrefijo origen;
    PorPrefijo destino;
    PorNombre contenedor;
    int alto;
    int ancho;
    int largo;
    int pesoFisico;
    int pesoVolumetrico;
    DateTime fechaSolicitud;
    DateTime fechaSalida;
    bool aprobacion;
    bool cancelada;
    PorNombre usuario;
    String descripcion;
    String id;

    factory NewBooking.fromJson(String str) => NewBooking.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewBooking.fromMap(Map<String, dynamic> json) => NewBooking(
        aerolinea: PorNombre.fromMap(json["aerolinea"]),
        awb: json["awb"],
        tipoCarga: PorNombre.fromMap(json["tipoCarga"]),
        origen: PorPrefijo.fromMap(json["origen"]),
        destino: PorPrefijo.fromMap(json["destino"]),
        contenedor: PorNombre.fromMap(json["contenedor"]),
        alto: json["alto"],
        ancho: json["ancho"],
        largo: json["largo"],
        pesoFisico: json["pesoFisico"],
        pesoVolumetrico: json["pesoVolumetrico"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        fechaSalida: DateTime.parse(json["fechaSalida"]),
        aprobacion: json["aprobacion"],
        cancelada: json["cancelada"],
        usuario: PorNombre.fromMap(json["usuario"]),
        descripcion: json["descripcion"],
        id: json["_id"],
    );

    Map<String, dynamic> toMap() => {
        "aerolinea": aerolinea.toMap(),
        "awb": awb,
        "tipoCarga": tipoCarga.toMap(),
        "origen": origen.toMap(),
        "destino": destino.toMap(),
        "contenedor": contenedor.toMap(),
        "alto": alto,
        "ancho": ancho,
        "largo": largo,
        "pesoFisico": pesoFisico,
        "pesoVolumetrico": pesoVolumetrico,
        "fechaSolicitud": fechaSolicitud.toIso8601String(),
        "fechaSalida": fechaSalida.toIso8601String(),
        "aprobacion": aprobacion,
        "cancelada": cancelada,
        "usuario": usuario.toMap(),
        "descripcion": descripcion,
        "_id": id,
    };
}

class PorNombre {
    PorNombre({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory PorNombre.fromJson(String str) => PorNombre.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PorNombre.fromMap(Map<String, dynamic> json) => PorNombre(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}

class PorPrefijo {
    PorPrefijo({
        required this.id,
        required this.prefijo,
    });

    String id;
    String prefijo;

    factory PorPrefijo.fromJson(String str) => PorPrefijo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PorPrefijo.fromMap(Map<String, dynamic> json) => PorPrefijo(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}
