import 'package:cached_network_image/cached_network_image.dart';
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
      'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/I/81GQyDDemfL.jpg',
      'https://upload.wikimedia.org/wikipedia/ru/thumb/c/cc/Extraction_2_%28film%2C_2023%29.jpg/1200px-Extraction_2_%28film%2C_2023%29.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjIzMzAzMjQyM15BMl5BanBnXkFtZTcwNzM2NjcyOQ@@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjMyOTM4MDMxNV5BMl5BanBnXkFtZTcwNjIyNzExOA@@._V1_FMjpg_UX1000_.jpg'
    ];
    return MainContainer(
      title: 'Premiere',
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: images[index],
                height: 150,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Image(image: imageProvider);
                },
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
