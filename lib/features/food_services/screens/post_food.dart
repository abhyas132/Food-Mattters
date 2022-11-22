import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PostFood extends ConsumerStatefulWidget {
  static const String routeName = '/post-food';
  // final User pushedBy;
  // final bool isAvailable;
  // final List<String> food;
  // final num foodQuantity;
  // final String foodType;
  // final num foodLife;
  // final String photo;
  const PostFood({super.key});
  static TextStyle txtStyle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  @override
  ConsumerState<PostFood> createState() => _PostFoodState();
}

class _PostFoodState extends ConsumerState<PostFood> {
  int _quantityValue = 25;
  int _consumptionHours = 3;
  final List<String> _addedItemList = ['Constant'];
  final _foodItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(
          "Share Food",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade200,
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    elevation: 10,
                    child: GestureDetector(
                        child: const CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      radius: 32,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 45,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Meal Type :',
                  style: PostFood.txtStyle,
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amber,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Veg',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amber,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Non-Veg',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Food Quantity : (Person)',
              style: PostFood.txtStyle,
            ),
            const SizedBox(height: 10),
            Slider(
              value: _quantityValue.toDouble(),
              min: 10.0,
              max: 100.0,
              divisions: 10,
              activeColor: Colors.green,
              inactiveColor: Colors.orange,
              label: _quantityValue.toString(),
              onChanged: (double newValue) {
                setState(() {
                  _quantityValue = newValue.round();
                });
              },
            ),
            const SizedBox(height: 10),
            Text(
              'To be consumed within :(hrs)',
              style: PostFood.txtStyle,
            ),
            const SizedBox(height: 15),
            Slider(
              value: _consumptionHours.toDouble(),
              min: 1.0,
              max: 10.0,
              divisions: 10,
              activeColor: Colors.green,
              inactiveColor: Colors.orange,
              label: _consumptionHours.toString(),
              onChanged: (double newValue) {
                setState(() {
                  _consumptionHours = newValue.round();
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.lightGreen.shade300),
              // child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _addedItemList.length,
              //     itemBuilder: ((context, index) {
              //       return null;
              //     })),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: _foodItemController,
                      decoration: const InputDecoration(
                          hintText: 'Enter food item',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                ),
                Expanded(
                    child: Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: InkWell(
                    onTap: (() => {}),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color.fromARGB(255, 29, 201, 192)),
                      child: const Center(
                        child: Text('Add food'),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () => {
                            //make hhtp post request
                          },
                      child: Text(
                        'POST',
                        style: PostFood.txtStyle,
                      )),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
