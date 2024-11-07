import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CacheImage extends StatelessWidget {
  String? imageUrl;
  double radius;
  bool banner;
  CacheImage({super.key, this.imageUrl, this.banner = false, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: banner ? BoxFit.fill : BoxFit.cover,
        imageUrl: imageUrl ??
            'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png',
        errorWidget: (context, url, error) => Container(
          color: Colors.amber,
        ),
        placeholder: (context, url) {
          return Container(color: Colors.amber);
        },
      ),
    );
  }
}
