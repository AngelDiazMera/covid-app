import 'package:covserver/widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:covserver/pages/recomendation/widgets/recommendation_page_body.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: SettingsHeader(name: 'Recomendaciones', needGoBack: true),
      ),
      body: RecommendationPageBody(),
    );
  }
}
