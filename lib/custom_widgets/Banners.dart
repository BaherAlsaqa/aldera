import 'package:aldera/constants/colors.dart';
import 'package:aldera/models/home/Images.dart';
import 'package:aldera/provider/GeneralProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Banners extends StatefulWidget {
  final List<Images> images;

  Banners({
    this.images,
  });

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int _current = 0;
  // List<String> imagesPath = [];
  List<Widget> images;
  String bannerType;

  @override
  void initState() {
    super.initState();
    // for (int i = 0; i < widget.images.length; i++)
    //   imagesPath.add(widget.images[i].image);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Consumer<GeneralProvider>(
      builder: (context, generalProvider, child) {
        return Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                imageContainer(),
                Container(
                  width: 1.0.sw,
                  height: 257.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      stops: [0.0, 2.0],
                      colors: <Color>[
                        Colors.transparent.withOpacity(0.0),
                        Colors.black.withOpacity(0.7),
                      ], // red to yellow
                    ),
                  ),
                ),
                PositionedDirectional(
                    bottom: 0.h,
                    child: Column(
                      children: [
                        points(),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 1.0.sw,
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(34.sp),
                              topEnd: Radius.circular(34.sp),
                              bottomStart: Radius.circular(0.sp),
                              bottomEnd: Radius.circular(0.sp)
                           ),
                            color: chatBackColor,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        );
      },
    );
  }

  Widget imageContainer() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            height: 257.h,
            viewportFraction: 1,
            initialPage: _current,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: images.length <= 1 ? false : true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeOutQuad,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: images,
      ),
    );
  }

  Widget points() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(images, (index, url) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 3.5.w),
          height: 9.h,
          width: _current == index ? 9.w : 9.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: _current == index? primaryColor: white,
              width: 1.w
            ),
            color: _current == index ? primaryColor : gray3.withOpacity(0.24),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        );
      }),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void init() {
    images = [
      for (int i = 0; i < widget.images.length; i++)
        widget.images[i].image.split(".").last.toLowerCase() == "svg"
            ? SvgPicture.network(widget.images[i].image,
          width: 1.0.sw,
          fit: BoxFit.cover,)
            : Image.network(
                widget.images[i].image,
          width: 1.0.sw,
              fit: BoxFit.cover,),
    ];
  }
}
