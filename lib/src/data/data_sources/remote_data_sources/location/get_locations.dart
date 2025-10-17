import 'package:rick_and_morty/src/core/network/dio_client.dart';
import 'package:rick_and_morty/src/core/utils/constatnts.dart';
import 'package:rick_and_morty/src/data/models/location.dart';

class LocationService extends DioClient {
  Future<List<Location>> getAllLocations() async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
      '${Constants.baseURL}${Constants.locationEndpoint}',
    );

    return List<Location>.from(objects.map((x) => Location.fromJson(x)));
  }

  Future<List<Location>> getListOfLocations(List<int> ids) async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
      '${Constants.baseURL}${Constants.locationEndpoint}/$ids',
    );

    return List<Location>.from(objects.map((x) => Location.fromJson(x)));
  }
}
