import 'dart:convert';

class Role {
    Role({
        required this.id,
        required this.rol,
    });

    String id;
    String rol;

    factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["_id"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "rol": rol,
    };
}