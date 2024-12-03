import 'dart:ui';

import 'package:flutter/material.dart';

class CinemaSliverAppBar extends StatelessWidget {
  const CinemaSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      pinned: true,
      floating: true,
      toolbarHeight: 30,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Icon(Icons.arrow_back_ios_new, size: 18),
        ),
      ),
      flexibleSpace: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container()),
          )),
    );
  }
}
