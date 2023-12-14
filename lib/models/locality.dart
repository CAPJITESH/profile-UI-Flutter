// city_locality_model.dart

class CityLocality {
  final String name;

  CityLocality({required this.name});
}

List<CityLocality> generateLocalitiesForCity(String cityName, int numberOfLocalities) {
  List<CityLocality> localities = [];
  for (int i = 1; i <= numberOfLocalities; i++) {
    localities.add(CityLocality(name: '$cityName$i'));
  }
  return localities;
}
