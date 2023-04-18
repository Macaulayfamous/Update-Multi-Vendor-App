import 'package:flutter/material.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/popular_widget.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/recent_item.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/reuseAbleText_Widget.dart';

import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:maclay_multi_store/views/buyers/nav_screens/widgets/customAppBarWidget.dart';

import 'widgets/best_selling_products.dart';
import 'widgets/trending_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarWidget(),
          BannerWidget(),
          CategoryText(),
          ReuseAbleTextWidget(
            title: 'Best Selling Products',
          ),
          BestSellingProducts(),
          ReuseAbleTextWidget(
            title: ' Trending Products',
          ),
          TrendingProductsWidget(),
          ReuseAbleTextWidget(
            title: 'Popular Product',
          ),
          PopularItemWidget(),
          ReuseAbleTextWidget(
            title: 'Featured Product',
          ),
          RecentItem(),
        ],
      ),
    );
  }
}
