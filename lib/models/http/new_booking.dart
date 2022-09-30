
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
        required this.exportador,
        required this.descripcion,
        required this.id,
    });

    _NumberPrefix aerolinea;
    int awb;
    _ByName tipoCarga;
    _StringPrefix origen;
    _StringPrefix destino;
    _ByName contenedor;
    int alto;
    int ancho;
    int largo;
    int pesoFisico;
    int pesoVolumetrico;
    DateTime fechaSolicitud;
    DateTime fechaSalida;
    bool aprobacion;
    bool cancelada;
    _ByName usuario;
    _ByName exportador;
    String descripcion;
    String id;

    factory NewBooking.fromJson(String str) => NewBooking.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewBooking.fromMap(Map<String, dynamic> json) => NewBooking(
        aerolinea: _NumberPrefix.fromMap(json["aerolinea"]),
        awb: json["awb"],
        tipoCarga: _ByName.fromMap(json["tipoCarga"]),
        origen: _StringPrefix.fromMap(json["origen"]),
        destino: _StringPrefix.fromMap(json["destino"]),
        contenedor: _ByName.fromMap(json["contenedor"]),
        alto: json["alto"],
        ancho: json["ancho"],
        largo: json["largo"],
        pesoFisico: json["pesoFisico"],
        pesoVolumetrico: json["pesoVolumetrico"],
        fechaSolicitud: DateTime.parse(json["fechaSolicitud"]),
        fechaSalida: DateTime.parse(json["fechaSalida"]),
        aprobacion: json["aprobacion"],
        cancelada: json["cancelada"],
        usuario: _ByName.fromMap(json["usuario"]),
        exportador: _ByName.fromMap(json["exportador"]),
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
        "exportador": exportador.toMap(),
        "descripcion": descripcion,
        "_id": id,
    };
}

class _NumberPrefix {
    _NumberPrefix({
        required this.id,
        required this.prefijo,
    });

    String id;
    int prefijo;


    String toJson() => json.encode(toMap());

    factory _NumberPrefix.fromMap(Map<String, dynamic> json) => _NumberPrefix(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}

class _ByName {
    _ByName({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;


    String toJson() => json.encode(toMap());

    factory _ByName.fromMap(Map<String, dynamic> json) => _ByName(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}

class _StringPrefix {
    _StringPrefix({
        required this.id,
        required this.prefijo,
    });

    String id;
    String prefijo;


    String toJson() => json.encode(toMap());

    factory _StringPrefix.fromMap(Map<String, dynamic> json) => _StringPrefix(
        id: json["_id"],
        prefijo: json["prefijo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "prefijo": prefijo,
    };
}
