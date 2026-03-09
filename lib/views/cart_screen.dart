import 'package:flutter/material.dart';
import 'package:vehicle_app/model/vehicle_model.dart';

class CartScreen extends StatefulWidget {
  final List<Data> items;
  final Set<int> cartIds;

  const CartScreen({
    super.key,
    required this.items,
    required this.cartIds
    });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartVehicles = widget.items
    .where((item) => widget.cartIds.contains(item.id))
    .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favourites"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                
                child: cartVehicles.isEmpty ?
                  Center(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey),

                          SizedBox(height: 12),

                          Text("Your favorites list is empty",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        
                        SizedBox(height: 12),

                          Text("Browse vehicles and add your favorites",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],

                      ),)

                : ListView.builder(
                itemCount: cartVehicles.length,
                itemBuilder: (context,index){
                  final item = cartVehicles[index];
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                item.image ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.make ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)
                                ),
                          
                              Text(item.model ?? ""),  
                          
                              Text(item.price != null ? "${item.currency ?? ""} ${item.price}": "N/A",
                                    ),
                                  
                            ],
                          ),
                        ),

                        IconButton(onPressed: (){
                          setState(() {
                            widget.cartIds.remove(item.id);
                          });
                        }, 
                        icon: Icon(Icons.remove_circle_outline)
                        ),
                      ],
                    ),
                  );
                }
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey.shade600),

                    SizedBox(width: 8),

                    Text("Lorem Ipsum is simply dummy text",style: TextStyle(color: Colors.grey.shade600),)
                  ],
                ),
              ),


              SizedBox(height: 10),

              ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8)
                )
              ), 
              child: Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),




            ],
          ),
        ),
      ),

    );
  }
}