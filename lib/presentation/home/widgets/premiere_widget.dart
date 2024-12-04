import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/presentation/core/widgets/main_container.dart';
import 'package:flutter/material.dart';

class PremiereWidget extends StatelessWidget {
  const PremiereWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/9dvWruFMk.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/3f3P6fp1R.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/9dvKYfJL1.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/8S589MjHS.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/9TEz29zjV.jpg'
    ];
    return MainContainer(
      title: 'Premiere',
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              child: Image.network(
                images[index],
                height: 150,
              ),
            ),
          );
        },
        options: CarouselOptions(
            autoPlay: true,
            height: 150,
            viewportFraction: 0.35,
            autoPlayInterval: const Duration(seconds: 5)),
      ),
    );
  }
}
