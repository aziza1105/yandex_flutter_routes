import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: (RouteDrawerPage()));
  }
}

class RouteDrawerPage extends StatefulWidget {
  const RouteDrawerPage({super.key});

  @override
  State<RouteDrawerPage> createState() => _RouteDrawerPageState();
}

class _RouteDrawerPageState extends State<RouteDrawerPage> {
  Point source = const Point(latitude: 41.2858305, longitude: 69.2035464);
  Point destination = const Point(
      latitude: 41.292398593572, longitude:  69.22521959670615);
  var route = const PolylineMapObject(
    mapId: MapObjectId("route"),
    polyline: Polyline(points: []),
  );

  YandexMapController? mapController;

  Future<void> getRoute() async {
    final routeRequest = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
            point: source,
            requestPointType: RequestPointType.wayPoint,
          ),
          RequestPoint(
              point: destination, requestPointType: RequestPointType.wayPoint)
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));
    print(routeRequest.session);

    final result = await routeRequest.result;
    print('Length: $result.routes?.length ');
    print(result.routes?.first);
    route = PolylineMapObject(
        mapId: const MapObjectId("route"),
        strokeColor: Colors.red,
        strokeWidth: 3,
        polyline: Polyline(points: result.routes?.first.geometry ?? []));
    result.routes?.map((route) {
      print(route);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: [
          CircleMapObject(
            mapId: const MapObjectId('source'),
            fillColor: Colors.blue.withOpacity(.3),
            strokeColor: Colors.blue,
            circle: Circle(center: source, radius: 20),
          ),
          PlacemarkMapObject(
              mapId: const MapObjectId('destination'),
              point: destination,
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage('aziza.jpg'),
                scale: .05,
              ))),
          route,
        ],
        onCameraPositionChanged: (cameraPosition, reason, finished) {},
        onMapCreated: (controller) async {
          mapController = controller;
          await controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: source, zoom: 12),
            ),
          );
          await getRoute();
        },
      ),
    );
  }
}
