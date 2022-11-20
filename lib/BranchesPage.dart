import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'Branches.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({Key? key}) : super(key: key);
  @override
  _BranchesPageState createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  Completer<GoogleMapController> _controller = Completer();
  void onComplete(GoogleMapController controller){
    _controller.complete();
  }

  Set<Marker> branchesList={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPoints();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onComplete,
      markers: branchesList,
      initialCameraPosition: CameraPosition(
          target: LatLng(32.605599,54.165450),
          zoom: 5
      ),
    );
  }

  void fetchPoints() async{
    var url = Uri.parse("http://welearnacademy.ir/flutter/branches.json");
    Response response = await get(url) ;
    setState(() {
      var branchJson = json.decode(utf8.decode(response.bodyBytes));
      for(var i in branchJson){
        var branch=Branches(i['shop_name'],i['id'],i['tel'],i['lat'],i['lng'],i['manager']);
        Marker marker=Marker(
          markerId: MarkerId(branch.shopId.toString()),
          position: LatLng(branch.latitude,branch.longitude),
          infoWindow: InfoWindow(
            title: branch.shopName,
            snippet: branch.manager
          )
        );
        branchesList.add(marker);
      }
    });
  }

}
