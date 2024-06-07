import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/marketplace_app_bar.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:sizer/sizer.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MarketplaceAppBar(
      border: Border(
        bottom: BorderSide(
          width: 0.2.h,
          color: const Color.fromRGBO(246, 246, 246, 1),
        ),
      ),
      isSearch: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
