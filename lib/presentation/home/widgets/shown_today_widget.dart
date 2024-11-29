import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/core/widgets/main_container.dart';
import 'package:cinema/presentation/movie/view/movie.dart';
import 'package:flutter/material.dart';

class ShownTodayWidget extends StatelessWidget {
  const ShownTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/4nj3EEnUf.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/8e4lyfUch.jpg',
      'https://webgate.24guru.by/uploads/events/thumbs/300x430/35UvWgSRV.jpg'
    ];
    return MainContainer(
        title: 'Сегодня',
        child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MoviePage(
                          imageUrl: images[index],
                          title: 'Веном. Последний танец')));
                },
                child: Image.network(
                  images[index],
                  height: 320,
                ),
              ),
            );
          },
          options: CarouselOptions(
              autoPlay: true, height: 320, viewportFraction: 0.68),
        ));
  }
}
