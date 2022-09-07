
import 'dart:convert';

class KgsByExporter {
    KgsByExporter({
        required this.totaleskgs,
    });

    List<Totaleskg> totaleskgs;

    factory KgsByExporter.fromJson(String str) => KgsByExporter.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory KgsByExporter.fromMap(Map<String, dynamic> json) => KgsByExporter(
        totaleskgs: List<Totaleskg>.from(json["totaleskgs"].map((x) => Totaleskg.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "totaleskgs": List<dynamic>.from(totaleskgs.map((x) => x.toMap())),
    };
}

class Totaleskg {
    Totaleskg({
        required this.id,
        required this.totalVolumen,
    });

    String id;
    int totalVolumen;

    factory Totaleskg.fromJson(String str) => Totaleskg.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Totaleskg.fromMap(Map<String, dynamic> json) => Totaleskg(
        id: json["_id"],
        totalVolumen: json["totalVolumen"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "totalVolumen": totalVolumen,
    };
}

