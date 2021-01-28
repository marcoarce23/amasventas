import 'package:amasventas/src/crosscutting/Const.dart';
import 'package:amasventas/src/crosscutting/Preference.dart';
import 'package:amasventas/src/page/home/HomePage.dart';
import 'package:amasventas/src/style/Style.dart';
import 'package:amasventas/src/theme/Theme.dart';
import 'package:amasventas/src/widget/general/GeneralWidget.dart';
import 'package:amasventas/src/widget/gfWidget/GfWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class IntroPage extends StatefulWidget {
  static final String routeName = 'IntroPage';
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final prefs = new Preferense();
  final int _numPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    prefs.lastPage = IntroPage.routeName;
    super.initState();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.themeDefault : Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //    backgroundBasic(context),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () => navegation(
                    context,
                    //   VentaGastoPage(),
                    HomePage(),
                  ),
                  child: Text(
                    'Iniciar',
                    style: TextStyle(
                      color: AppTheme.themeDefault,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 500.0,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: NetworkImage(IMAGE_SCREEN3),
                              height: 180.0,
                              fit: BoxFit.fill,
                            ),

                            // Image(
                            //   image: NetworkImage(IMAGE_ORGANIZATION),
                            //   height: 180.0,
                            //   fit: BoxFit.fill,
                            // ),
                          ),

                          Shimmer.fromColors(
                            baseColor: AppTheme.themeDefault,
                            highlightColor: Colors.green,
                            child: AutoSizeText(
                              'GANA MUCHO FORMANDO PARTE DE LA FAMILIA AMASZONAS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          sizedBox(0, 15.0),
                          //    Expanded(
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 20.0),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child:
                                  avatarCircle(IMAGE_LOGON, 25.0),
                                  //  ),
                                  sizedBox(10, 15.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox(0, 15.0),
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 15.0),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child: FaIcon(
                                  //       FontAwesomeIcons.playstation,
                                  //       color: AppTheme.themeWhite,
                                  //       size: 35.0),
                                  // ),
                                  avatarCircle(IMAGE_LOGON, 25.0),

                                  sizedBox(10, 15.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox(0, 11.0),
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 11.0),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child: FaIcon(
                                  //       FontAwesomeIcons.playstation,
                                  //       color: AppTheme.themeWhite,
                                  //       size: 35.0),
                                  // ),
                                  avatarCircle(IMAGE_LOGON, 25.0),
                                  sizedBox(10, 10.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //  ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: NetworkImage(IMAGE_SCREEN2),
                              height: 180.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          sizedBox(0, 10.0),
                          Shimmer.fromColors(
                            baseColor: AppTheme.themeDefault,
                            highlightColor: AppTheme.themeWhite,
                            child: AutoSizeText(
                              'DISFRUTA DE LO ULTIMO DE AMASZVENTAS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          sizedBox(0, 10.0),

                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 10.0),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child: FaIcon(
                                  //       FontAwesomeIcons.playstation,
                                  //       color: AppTheme.themeWhite,
                                  //       size: 35.0),
                                  // ),
                                  avatarCircle(IMAGE_LOGON, 25.0),
                                  sizedBox(10, 10.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox(0, 10.0),
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 10),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child: FaIcon(
                                  //       FontAwesomeIcons.playstation,
                                  //       color: AppTheme.themeWhite,
                                  //       size: 35.0),
                                  // ),
                                  avatarCircle(IMAGE_LOGON, 25.0),
                                  sizedBox(10, 10.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox(0, 11.0),
                              Row(
                                children: <Widget>[
                                  sizedBox(0, 10.0),
                                  // Shimmer.fromColors(
                                  //   baseColor: AppTheme.themeWhite,
                                  //   highlightColor: AppTheme.themePurple,
                                  //   child: FaIcon(
                                  //       FontAwesomeIcons.playstation,
                                  //       color: AppTheme.themeWhite,
                                  //       size: 35.0),
                                  // ),
                                  avatarCircle(IMAGE_LOGON, 25.0),
                                  sizedBox(10, 10.0),
                                  Expanded(
                                    child: AutoSizeText(
                                      'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                      style: kSubtitleStyle,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: NetworkImage(IMAGE_SCREEN3),
                              height: 180.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          sizedBox(0, 5.0),
                          Shimmer.fromColors(
                            baseColor: AppTheme.themeDefault,
                            highlightColor: AppTheme.themeWhite,
                            child: AutoSizeText(
                              'AUTO CHECK-IN, ATENCIÓN DE PRIMERA CALIDAD Y MUCHO MAS..',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          sizedBox(0, 12.0),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeWhite,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeWhite,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_LOGON, 25.0),
                                    sizedBox(10.0, 0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                        style: kSubtitleStyle,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 12.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeWhite,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeWhite,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_LOGON, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                        style: kSubtitleStyle,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox(0, 12.0),
                                Row(
                                  children: <Widget>[
                                    sizedBox(0, 10.0),
                                    // Shimmer.fromColors(
                                    //   baseColor: AppTheme.themeWhite,
                                    //   highlightColor: AppTheme.themePurple,
                                    //   child: FaIcon(
                                    //       FontAwesomeIcons.playstation,
                                    //       color: AppTheme.themeWhite,
                                    //       size: 35.0),
                                    // ),
                                    avatarCircle(IMAGE_LOGON, 25.0),
                                    sizedBox(10, 10.0),
                                    Expanded(
                                      child: AutoSizeText(
                                        'Compra anticipada. Para rutas nacionales al menos 10 días, en las rutas internacionales por lo menos 30 días.',
                                        style: kSubtitleStyle,
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Siguiente',
                                style: TextStyle(
                                  color: AppTheme.themeDefault,
                                  fontSize: 22.0,
                                ),
                              ),
                              sizedBox(0, 10.0),
                              Icon(
                                Icons.arrow_forward,
                                color: AppTheme.themeDefault,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(''),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              color: AppTheme.themeGreen,
              child: GestureDetector(
                onTap: () => navegation(
                  context,
                  // VentaGastoPage(),
                  HomePage(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Comenzar',
                          style: TextStyle(
                            color: AppTheme.themeWhite,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sizedBox(10.0, 0),
                        avatarCircle(IMAGE_LOGON, 15),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
