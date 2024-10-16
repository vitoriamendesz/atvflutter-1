import "dart:convert";
import "package:http/http.dart" as http;
import "package:mobile/service/abstract_service.dart";

class TransacoesService extends AbstractService {
  @override
  String recurso() {
    return 'transacoes';
  }
}
