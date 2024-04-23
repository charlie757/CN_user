import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
class YoutubeVideoWidget extends StatelessWidget {
  final String? url;
  const YoutubeVideoWidget({Key? key, required this.url}) : super(key: key);

 String extractVideoId(){
    RegExp regExp = RegExp(r"(?<=v=)[a-zA-Z0-9_-]+");
    Match? match = regExp.firstMatch(url!);
    String? videoId = match?.group(0);

// Using split
    List<String> parts = url!.split('=');
    String? videoUrl = parts.length > 1 ? parts[1] : null;
    return videoUrl.toString();
  }
  
  @override
  Widget build(BuildContext context) {
   String url1 = extractVideoId();
   print("url....$url");
   print("url1.....$url1");
    // https://www.youtube.com/embed/ESsdOAZ3WI0
    double width = MediaQuery.of(context).size.width;
    return url!.isNotEmpty ?
    Container(height: width/1.55,width:width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: WebView(
          initialUrl:url,
          javascriptMode: JavascriptMode.unrestricted,
        ),) :
    const SizedBox.shrink();
  }
}
