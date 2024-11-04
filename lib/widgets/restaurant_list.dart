import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/restaurant_provider.dart';
import '../widgets/restaurant_card.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    // Accede al provider
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return restaurantProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: restaurantProvider.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantProvider.restaurants[index];
              return RestaurantCard(
                  restaurant: restaurant); // Usa el widget `RestaurantCard`
            },
          );
  }
}
