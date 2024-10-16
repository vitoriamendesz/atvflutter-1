import "dart:convert";

import "package:http/http.dart" as http;

abstract class AbstractService {
  final String url = "http://localhost:3000";

  String recurso();

  Future<void> getById(int id) async {
    var response = http.get(Uri.parse("$url/${recurso()}"));

    print((await response).body);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    var response = await http.get(Uri.parse("$url/${recurso()}"));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<void> create(Map<String, dynamic> body) async {
    await http.post(
      Uri.parse("$url/${recurso()}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }

  Future<void> update(int id, Map<String, dynamic> body) async {
    await http.put(
      Uri.parse("$url/${recurso()}/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }

  Future<void> delete(int id) async {
    await http.delete(
      Uri.parse("$url/${recurso()}/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
