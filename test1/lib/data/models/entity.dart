/// Общий интерфейс для карточек: персонаж, локация, эпизод.
abstract class Entity {
  String get name;
  String? get imageUrl;
  String get subtitle;
  String get caption;
}

class Character implements Entity {
  Character.fromJson(Map<String, dynamic> j)
      : name = j['name'],
        imageUrl = j['image'],
        subtitle = '${j['status']} • ${j['species']}',
        caption = j['gender'] ?? '';
  @override final String name;
  @override final String? imageUrl;
  @override final String subtitle;
  @override final String caption;
}

class LocationModel implements Entity {
  LocationModel.fromJson(Map<String, dynamic> j)
      : name = j['name'],
        subtitle = j['type'] ?? '',
        caption = j['dimension'] ?? '';
  @override final String name;
  @override String? get imageUrl => null;
  @override final String subtitle;
  @override final String caption;
}

class Episode implements Entity {
  Episode.fromJson(Map<String, dynamic> j)
      : name = j['name'],
        subtitle = j['episode'] ?? '',
        caption = j['air_date'] ?? '';
  @override final String name;
  @override String? get imageUrl => null;
  @override final String subtitle;
  @override final String caption;
}
