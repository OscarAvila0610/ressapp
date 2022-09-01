
import 'dart:convert';

import 'package:ress_app/models/role.dart';

class RoleResponse {
    RoleResponse({
        required this.total,
        required this.roles,
    });

    int total;
    List<Role> roles;

    factory RoleResponse.fromJson(String str) => RoleResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RoleResponse.fromMap(Map<String, dynamic> json) => RoleResponse(
        total: json["total"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
    };
}


