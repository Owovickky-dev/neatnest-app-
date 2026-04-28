import 'package:flutter/material.dart';
import 'package:neat_nest/screens/favorite/utilities/favourite_data_holder.dart';

class AllDataScreen extends StatelessWidget {
  const AllDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              mainAxisExtent: 250,
            ),
            itemBuilder: (context, index) {
              return FavouriteDataHolder(index: index);
            },
          ),
        ),
      ],
    );
  }
}
