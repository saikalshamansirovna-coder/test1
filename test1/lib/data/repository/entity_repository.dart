import '../../core/network/api_client.dart';
import '../models/entity.dart';

class PageResult<T> {
  PageResult(this.items, this.hasNext);
  final List<T> items;
  final bool hasNext;
}

/// Model-слой MVVM: получает и парсит данные API.
class EntityRepository<T extends Entity> {
  EntityRepository(this.endpoint, this.parser, {ApiClient? client}) : _client = client ?? ApiClient();
  final String endpoint;
  final T Function(Map<String, dynamic>) parser;
  final ApiClient _client;

  Future<PageResult<T>> fetch(int page) async {
    final json = await _client.get(endpoint, page);
    final items = (json['results'] as List).map((e) => parser(e as Map<String, dynamic>)).toList();
    return PageResult(items, json['info']['next'] != null);
  }
}
