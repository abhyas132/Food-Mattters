import 'package:flutter/material.dart';
import 'package:foods_matters/models/food_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Posts extends StatelessWidget {
  Food food;
  Posts(this.food);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RowText('Quantity :', '${food.foodQuantity}'),
            RowText('Food life :', '${food.foodLife}'),
            RowText('Deliver To :', '${food.addressString}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Item List : ',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<dynamic>(
                  alignment: Alignment.topCenter,
                  iconSize: 0,
                  elevation: 0,
                  hint: Text("items",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      )),
                  items: food.food.map((dynamic value) {
                    return DropdownMenuItem<dynamic>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  String heading, content;
  RowText(this.heading, this.content);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            heading,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
