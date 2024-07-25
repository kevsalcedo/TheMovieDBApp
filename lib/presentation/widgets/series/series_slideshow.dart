import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:flutter/material.dart';

class SeriesSlideshow extends StatelessWidget {
  final List<Serie> series;

  const SeriesSlideshow({
    super.key,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.85,
        scale: 0.90,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary, color: colors.secondary),
        ),
        itemCount: series.length,
        itemBuilder: (context, index) => _Slide(serie: series[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Serie serie;
  const _Slide({required this.serie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            serie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
