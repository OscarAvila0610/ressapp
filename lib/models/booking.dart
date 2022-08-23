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
    _Aerolinea aerolinea;
    int awb;
    _Contenedor tipoCarga;
    _Destino origen;
    _Destino destino;
    _Contenedor contenedor;
    int alto;
    int ancho;
    int largo;
    int pesoFisico;
    int pesoVolumetrico;
    DateTime fechaSolicitud;
    DateTime fechaSalida;
    bool aprobacion;
    bool cancelada;
    _Contenedor usuario;

    factory Reserva.fromJson(String str) => Reserva.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Reserva.fromMap(Map<String, dynamic> json) => Reserva(
        id: json["_id"],
        aerolinea: _Aerolinea.fromMap(json["aerolinea"]),
        awb: json["awb"],
        tipoCarga: _Contenedor.fromMap(json["tipoCarga"]),
        origen: _Destino.fromMap(json["origen"]),
        destino: _Destino.fromMap(json["destino"]),
        contenedor: _Contenedor.fromMap(json["contenedor"]),
        alto: json["alto"],
        ancho: json["ancho"],
        largo: json["largo"],
        pesoFisico: json["pesoFisico"],
        pesoVolumetrico: json["pesoVolumetrico"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        fechaSalida: DateTime.parse(json["fechaSalida"]),
        aprobacion: json["aprobacion"],
        cancelada: json["cancelada"],
        usuario: _Contenedor.fromMap(json["usuario"]),
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

class _Aerolinea {
    _Aerolinea({
        required this.id,
        required this.prefijo,
    });

    String id;
    int prefijo;

    factory _Aerolinea.fromJson(String str) => _Aerolinea.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory _Aerolinea.fromMap(Map<String, dynamic> json) => _Aerolinea(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}

class _Contenedor {
    _Contenedor({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory _Contenedor.fromJson(String str) => _Contenedor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory _Contenedor.fromMap(Map<String, dynamic> json) => _Contenedor(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}

class _Destino {
    _Destino({
        required this.id,
        required this.prefijo,
    });

    String id;
    String prefijo;

    factory _Destino.fromJson(String str) => _Destino.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory _Destino.fromMap(Map<String, dynamic> json) => _Destino(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}