import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String placeholder;
  const CustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      CachedNetworkImage(
        imageUrl:image,
        fit: BoxFit.contain,
        placeholder: (context, url) => Image.asset(Images.placeholder,fit: BoxFit.cover,),
        errorWidget: (context, url, error) => Image.asset(Images.placeholder, fit: BoxFit.cover,width: width,),
      );


    FadeInImage.assetNetwork(
      placeholder: Images.placeholder, image: image, fit: BoxFit.contain,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder, height: height,
        width: width, fit: BoxFit.cover,
      ),
    );
  }
}
