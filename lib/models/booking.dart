import 'dart:convert';

class Reserva {
    Reserva({
        required this.id,
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
    });

    String id;
    Aerolinea aerolinea;
    int awb;
    Contenedor tipoCarga;
    Destino origen;
    Destino destino;
    Contenedor contenedor;
    int alto;
    int ancho;
    int largo;
    int pesoFisico;
    int pesoVolumetrico;
    DateTime fechaSolicitud;
    DateTime fechaSalida;
    bool aprobacion;
    bool cancelada;
    Contenedor usuario;

    factory Reserva.fromJson(String str) => Reserva.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Reserva.fromMap(Map<String, dynamic> json) => Reserva(
        id: json["_id"],
        aerolinea: Aerolinea.fromMap(json["aerolinea"]),
        awb: json["awb"],
        tipoCarga: Contenedor.fromMap(json["tipoCarga"]),
        origen: Destino.fromMap(json["origen"]),
        destino: Destino.fromMap(json["destino"]),
        contenedor: Contenedor.fromMap(json["contenedor"]),
        alto: json["alto"],
        ancho: json["ancho"],
        largo: json["largo"],
        pesoFisico: json["pesoFisico"],
        pesoVolumetrico: json["pesoVolumetrico"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        fechaSalida: DateTime.parse(json["fechaSalida"]),
        aprobacion: json["aprobacion"],
        cancelada: json["cancelada"],
        usuario: Contenedor.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
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
    };
}

class Aerolinea {
    Aerolinea({
        required this.id,
        required this.prefijo,
    });

    String id;
    int prefijo;

    factory Aerolinea.fromJson(String str) => Aerolinea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Aerolinea.fromMap(Map<String, dynamic> json) => Aerolinea(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}

class Contenedor {
    Contenedor({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory Contenedor.fromJson(String str) => Contenedor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Contenedor.fromMap(Map<String, dynamic> json) => Contenedor(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}

class Destino {
    Destino({
        required this.id,
        required this.prefijo,
    });

    String id;
    String prefijo;

    factory Destino.fromJson(String str) => Destino.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Destino.fromMap(Map<String, dynamic> json) => Destino(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}