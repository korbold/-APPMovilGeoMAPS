import 'dart:convert';

import 'package:busmart/api_url.dart';
import 'package:busmart/features/home/data/datasources/data_local.dart';
import 'package:busmart/features/home/data/datasources/data_remote.dart';
import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:busmart/features/home/domain/repositories/home_domain_repository.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;

class HomeDataRepositoryIMPL implements HomeDomainRepositoryINTERFACE {
  final _homeDataRemote = HomeDataRemoteImpl();
  final _homeDataLocal = HomeDataLocalImplementation();

  @override
  Future<List<RoutesModel>> getRoutesEntities() async {
    final token = await _homeDataLocal.loadToken();

    return await _homeDataRemote.getRoutesEntities(token);
  }

  @override
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${ModeAppRun.apiGoogleMaps}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    print("====================>>>>>>>>${values}");

    return values["routes"][0]["overview_polyline"]["points"];
  }
}

class Routes {
  final List<List<double>> route;
  final List<List<double>> stopBus;
  final String name;

  Routes({this.route, this.stopBus, this.name});
}

final dataRoute = [
  Routes(route: [
    [-0.1240896, -78.4857576],
    [-0.1244115, -78.4853164],
    [-0.1260835, -78.4859751],
    [-0.1262565, -78.485493],
    [-0.1273891, -78.4859201],
    [-0.1275883, -78.4854541],
    [-0.1287443, -78.4859174],
    [-0.1285404, -78.48693],
  ], stopBus: [
    [-0.1275883, -78.4854541],
    [-0.1287443, -78.4859174]
  ], name: 'Ruta 1'),
  Routes(route: [
    [-0.21650023620044578, -78.50477938432573],
    [-0.21570814923666148, -78.504263826914],
    [-0.2148526344110877, -78.50374564280565],
    [-0.21301453365774137, -78.5027212023754],
    [-0.21111235894362324, -78.50174567878938],
    [-0.2101767516818711, -78.5012886407355],
    [-0.20927253533361068, -78.50085868780077],
    [-0.20841551304120287, -78.5004607719539],
    [-0.20762148794941027, -78.50009984516407],
    [-0.20690626320526917, -78.49978085940096],
    [-0.20628564195943966, -78.49950876663328],
    [-0.20577542736070598, -78.49928851883028],
    [-0.20539142256049558, -78.49912506796154],
    [-0.20514943070618585, -78.49902336599634],
    [-0.20508662811822376, -78.49899721834294],
    [-0.20506525494529626, -78.49898836490381],
    [-0.19809843714006092, -78.49596057302313],
    [-0.20212566973687274, -78.48658323700538]
  ], stopBus: [
    [-0.21301453365774137, -78.5027212023754],
    [-0.20508662811822376, -78.49899721834294]
  ], name: 'Ruta 2')
];
