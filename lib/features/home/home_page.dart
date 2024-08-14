import 'package:book_bike/features/home/home_features.dart';
import 'package:book_bike/features/home/sections/home_header_w.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeaderWidget(),
            const SizedBox(
              height: 24,
            ),
            Text(
              Ln.i?.homeIfeatures ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runSpacing: 16,
              children: features.map((e) => _buildFeature(e)).toList(),
            )
          ],
        ),
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget _buildFeature(HomeFeature feature) {
    return GestureDetector(
      onTap: feature.onClick,
      child: SizedBox(
        width: 128,
        child: Column(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Card(
                color: feature.color,
                child: Icon(
                  feature.icon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              feature.name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
