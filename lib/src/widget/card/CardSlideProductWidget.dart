import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;
//import 'package:amasventas/src/model/entity/EntityMap/CardSlideProduct.dart';

/*
class Shoe {
  final String name;
  final String image;
  final double price;
  final Color color;

  const Shoe({
    this.name,
    this.image,
    this.price,
    this.color,
  });
}

const shoes = [
  const Shoe(
      name: 'NIKE EPICT-REACT',
      price: 130.00,
      image: 'images/shoes/1.png',
      color: Color(0xFF5574b9)),
  const Shoe(
      name: 'NIKE AIR-MAX',
      price: 130.00,
      image: 'images/shoes/2.png',
      color: Color(0xFF52b8c3)),
  const Shoe(
      name: 'NIKE AIR-270',
      price: 150.00,
      image: 'images/shoes/3.png',
      color: Color(0xFFE3AD9B)),
  const Shoe(
      name: 'NIKE EPICT-REACTII',
      price: 160.00,
      image: 'images/shoes/4.png',
      color: Color(0xFF444547)),
];

*/

class CardSlideProductWidget extends StatefulWidget {
  // List<CardSlideProduct> listCardProduct = new List<CardSlideProduct>();

  // CardSlideProductWidget(@required List<CardSlideProduct> listCard) {
  //   this.listCardProduct = listCard;
  // }

  @override
  _CardSlideProductWidgetState createState() => _CardSlideProductWidgetState();
}

class _CardSlideProductWidgetState extends State<CardSlideProductWidget> {
  final _pageController = PageController(viewportFraction: 0.78);
  final _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = _pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const marginCenter = EdgeInsets.symmetric(horizontal: 50, vertical: 15);
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: -10,
          height: size.height * 0.50,
          child: PageView.builder(
              controller: _pageController,
              itemCount: 1,//widget.listCardProduct.length,
              itemBuilder: (context, index) {
                final t = (index - _pageNotifier.value);
                final rotationY = lerpDouble(0, 90, t);
                final translationX = lerpDouble(0, -50, t);
                final scale = lerpDouble(0, -0.2, t);
                final translationXShoes = lerpDouble(0, 150, t);
                final rotationShoe = lerpDouble(0, -45, t);
                final transform = Matrix4.identity();
                transform.translate(translationX);
                transform.setEntry(3, 2, 0.001);
                transform.scale(1 - scale);
                transform.rotateY(vector.radians(rotationY));

                final transformShoe = Matrix4.identity();
                transformShoe.translate(translationXShoes);
                transformShoe.rotateZ(vector.radians(rotationShoe));
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: transform,
                          child: Stack(
                            children: [
                              /*Hero(
                                tag:
                                    'hero_background_${widget.listCardProduct[index].nameProduct}',
                                child: 
                                */
                              Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: marginCenter,
                                color: Colors.red,
                                child: const SizedBox.expand(),
                              ),

                              //  ),
                              Container(
                                margin: marginCenter,
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(''),
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(''),
                                    Spacer(),
                                    /*Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: transformShoe,
                            child:
                                /*Hero(
                              tag:
                                  'hero_image_${widget.listCardProduct[index].nameProduct}',
                              child: */
                                Image.network(
                              '',
                            ),
                            //),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
