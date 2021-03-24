import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:aldera/singleton/dio.dart';
import 'package:aldera/utils/language.dart';

class CustomCarouselSlider extends StatefulWidget {
  // List<BannerModel> bannersList;

  CustomCarouselSlider(/*this.bannersList*/);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _current = 0;
  List<Widget> images;
  // String src = "https://cdn.vox-cdn.com/thumbor/73nhsZwI55BVgH8-rapmIhkvbUk=/0x0:4047x3035/1200x675/filters:focal(1700x1194:2346x1840)/cdn.vox-cdn.com/uploads/chorus_image/image/64046617/20150915-_Upland_Burger_3.0.0.1489236245.0.jpg";
  // String src1 = "https://cdn.sanity.io/images/czqk28jt/prod_bk/f4dc27eb7337f7cbd12d3ccd840e6a031fcba622-360x270.jpg";

  @override
  Widget build(BuildContext context) {
    init();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        imageContainer(),
        PositionedDirectional(
            bottom: 18.h,
            child: points()),
      ],
    );
  }

  Widget imageContainer() {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 10.w),
      //   height: 170.h,
      child: CarouselSlider(
        options: CarouselOptions(
            height: 214.h,
            // aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: _current,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
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
          height: 5.h,
          width: 24.w,
          decoration: BoxDecoration(
            color: _current == index ? secondaryColor : white.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(3.sp)),
            border: Border.all(color: borderPrimaryColor, width: 0.5.w)
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
      // for (int i = 0; i < widget.bannersList.length; i++)
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 0.w, end: 16.w, top: 0.h, bottom: 0.h
          ),
          child: InkWell(
            onTap: () async {
              // if(widget.bannersList[i].url != null){
              //   if (await canLaunch(widget.bannersList[i].url)) {
              //   await launch(widget.bannersList[i].url);
              // } else {
              // showAlertString(
              //   context, ERROR, getTranslated(context, "thereBugTriedLater"), 1);
              // }
              // }else{
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ProductDetails(null,
              //           productId: int.parse(widget.bannersList[i].productId.toString()),),
              //       ),
              //     );
              // }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
              child: Image.network(
                "widget.bannersList[i].image",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 214.h,
              ),
            ),
          ),
        ),
    ];
  }
}
