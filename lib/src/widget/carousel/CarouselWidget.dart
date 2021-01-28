import 'package:flutter/material.dart';

class CarouselSimpleModel {
  final String imageUrl;
  final String textFromImage;
  CarouselSimpleModel({this.imageUrl, this.textFromImage});
}

class CarouselSimple extends StatefulWidget {
  List<CarouselSimpleModel> listCarousel;
  Color colorBackGround;
  Color colorText;

  @override
  _CarouselSimpleState createState() => _CarouselSimpleState();

  CarouselSimple(List<CarouselSimpleModel> list, Color colorBackGround,
      @required Color colorText) {
    this.listCarousel = list;
    this.colorBackGround = colorBackGround;
    this.colorText = colorText;
  }
}

class _CarouselSimpleState extends State<CarouselSimple> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight =
        screenHeight < 500 ? 460 : screenHeight * 0.7;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: containerHeight * 0.70,
          child: PageView.builder(
              itemCount: widget.listCarousel.length,
              onPageChanged: (int position) {
                setState(() {
                  _currentIndex = position;
                });
              },
              itemBuilder: (BuildContext context, int position) {
                final currentSlide = widget.listCarousel[position];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.43,
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF3C4858).withOpacity(.4),
                              offset: Offset(2.0, 2.0),
                              blurRadius: 10.0),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            currentSlide.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0.1, 1.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: widget.colorBackGround.withOpacity(0.8),
                          ),
                          child: Text(
                            currentSlide.textFromImage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.colorText,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
        Container(
          width: 25,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.listCarousel.length,
              (index) => Indicator(
                active: _currentIndex == index,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  Indicator({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: active
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(.6),
                    offset: Offset(1, 1),
                    blurRadius: 3)
              ]
            : null,
        color: active ? Color(0xFF3C4858) : Color(0xFFC4C4C4),
      ),
    );
  }
}
