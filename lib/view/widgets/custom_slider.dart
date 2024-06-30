import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../view_model/live_controller.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    double slideVal = liveViewModel.liveStreamingModel.getAuthor!.getXp! * (1/5000);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8.0),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: CustomSliderThumbImage(
              thumbImage: const AssetImage(
                  'assets/png/best.png'),
            ),
            thumbColor: Colors.transparent,
            // Make the default thumb color transparent
            activeTrackColor: const Color(0xffBD8DF4),
            inactiveTrackColor: const Color(0xffBD8DF4).withOpacity(0.3),
            trackHeight: 10.0,
            // Set the desired height here
            overlayColor: Colors.transparent,
          ),
          child: Slider(
            value: slideVal,
            onChanged: (val) {
              setState(() {
                slideVal = val;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Text(
                "Lv.${liveViewModel.liveStreamingModel.getAuthor!.getLevel}",
                style: TextStyle(color: Colors.white.withOpacity(.6)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  "EXP ${(slideVal * 5000).toStringAsFixed(2)}/5000",
                  style: TextStyle(color: Colors.white.withOpacity(.6)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomSliderThumbImage extends SliderComponentShape {
  final ImageProvider thumbImage;

  CustomSliderThumbImage({required this.thumbImage});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(40.0, 40.0); // Size of the image
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final ImageStream imageStream =
    thumbImage.resolve(const ImageConfiguration());
    final ImageStreamListener listener =
    ImageStreamListener((ImageInfo info, bool synchronousCall) {
      final double imageWidth = info.image.width.toDouble();
      final double imageHeight = info.image.height.toDouble();
      final Rect imageRect =
      Rect.fromCenter(center: center, width: 30.0, height: 30.0);
      final Rect srcRect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);
      canvas.drawImageRect(info.image, srcRect, imageRect, Paint());
    });

    imageStream.addListener(listener);
  }
}

class CustomSubcriberWidget extends StatefulWidget {
  String? image;
  String? txt;

  Function()? onTap;
  bool color;

  CustomSubcriberWidget(
      {this.image, this.txt, required this.color, this.onTap});

  @override
  State<CustomSubcriberWidget> createState() => _CustomSubcriberWidgetState();
}

class _CustomSubcriberWidgetState extends State<CustomSubcriberWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.color == true
                  ? const Color(0xff494848)
                  : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Image.asset(widget.image!),
                const SizedBox(width: 10),
                Text(
                  widget.txt.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
