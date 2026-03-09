import 'package:flutter/material.dart';
import 'package:vehicle_app/model/vehicle_model.dart';

class VehicleDetailScreen extends StatefulWidget {
  final Data item;
  final Set<int> cartIds;

  const VehicleDetailScreen({
    super.key,
    required this.item,
    required this.cartIds,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  bool get isInCart => widget.cartIds.contains(widget.item.id);

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final specs = item.specs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.item.id ?? 0,
                child: Image.network(
                  item.image ?? "",
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.make ?? "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.year?.toString() ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    Text(
                      item.model ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      item.price != null
                          ? "${item.currency ?? ""} ${item.price}"
                          : "N/A",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      item.description ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 24),

                    Text(
                      "Specifications",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    if (specs != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _specRow("Engine", specs.engine),
                            _divider(),
                            _specRow("Transmission", specs.transmission),
                            _divider(),
                            _specRow("Fuel Type", specs.fuelType),
                            _divider(),
                            _specRow("Mileage", specs.mileage),
                            _divider(),
                            _specRow("0-60 mph", specs.s060mph),
                            _divider(),
                            _specRow("Horsepower", specs.horsepower),
                            _divider(),
                            _specRow("Towing", specs.towing),
                          ],
                        ),
                      ),

                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (isInCart) {
                              widget.cartIds.remove(item.id);
                            } else {
                              widget.cartIds.add(item.id!);
                            }
                          });
                        },
                        icon: Icon(
                          isInCart
                              ? Icons.check
                              : Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          isInCart ? "Added to favorites" : "Add to favorites",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isInCart ? Colors.green : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
          Text(
            value ?? "N/A",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.black12);
  }
}