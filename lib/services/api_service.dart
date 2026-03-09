import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vehicle_app/model/vehicle_model.dart';

class ApiService{
  Future <VehicleModel> fetchVehicles () async {
    final response = await http.get(
      Uri.parse("https://www.wantapi.com/vehicles.php"),
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);

      return VehicleModel.fromJson(data);
    } else {
      throw Exception("Failed to load vehicles data.");
    }
  }
}