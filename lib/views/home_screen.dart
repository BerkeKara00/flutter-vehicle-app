import 'package:flutter/material.dart';
import 'package:vehicle_app/components/vehicle_cart.dart';
import 'package:vehicle_app/model/vehicle_model.dart';
import 'package:vehicle_app/services/api_service.dart';
import 'package:vehicle_app/views/cart_screen.dart';
import 'package:vehicle_app/views/vehicle_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";
  List<Data> allVehicles = [];
  ApiService apiService = ApiService();
  final Set<int> cartIds = {};
  String searchQuery = "";
  String? selectedFuelType;

  @override
  void initState() {
    loadVehicles();
    super.initState();
  }

  Future<void> loadVehicles() async {
    try {
      setState(() {
        isLoading = true;
      });
      VehicleModel resData = await apiService.fetchVehicles();
      setState(() {
        allVehicles = resData.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load vehicles data.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> get fuelTypes {
    final types = allVehicles
        .map((e) => e.specs?.fuelType ?? "")
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    types.sort();
    return types;
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = allVehicles.where((item) {
      final make = item.make ?? "";
      final matchesSearch =
          make.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFuel = selectedFuelType == null ||
          (item.specs?.fuelType ?? "") == selectedFuelType;
      return matchesSearch && matchesFuel;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartScreen(items: allVehicles, cartIds: cartIds),
                        ),
                      );
                    },
                    icon: Icon(Icons.favorite_border_outlined),
                  )
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Discover our latest vehicles.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search vehicles",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=1920",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),

              if (fuelTypes.isNotEmpty)
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // "All" butonu
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFuelType = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: selectedFuelType == null
                                  ? Colors.black
                                  : Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "All",
                                style: TextStyle(
                                  color: selectedFuelType == null
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Dinamik fuel type butonları
                      ...fuelTypes.map((fuel) {
                        final isSelected = selectedFuelType == fuel;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedFuelType = isSelected ? null : fuel;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  fuel,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

              SizedBox(height: 16),

              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage != "")
                Center(child: Text(errorMessage))
              else if (filteredItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "No vehicles found.",
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    ),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VehicleDetailScreen(
                                  item: item, cartIds: cartIds),
                            ),
                          );
                        },
                        child: VehicleCard(item: item),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}