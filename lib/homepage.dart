import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  Duration duration = Duration(seconds: 10);

  AnimationController animationController;
  Animation<Offset> animation;
  Animation curveAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    curveAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCirc,
    );

    animation = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset(0, 0))
        .animate(curveAnimation);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        animationController.forward();
      } else if( status == AnimationStatus.completed){
        animationController.forward();
      }
    });
 animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            height: screenHeight * 0.12,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildBarItem(icon: Icons.home, index: 0, onTap: () {}),
                buildBarItem(icon: Icons.favorite, index: 1, onTap: () {}),
                buildBarItem(icon: Icons.person, index: 2, onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBarItem({IconData icon, int index, Function onTap}) {
    return Align(
      alignment:
          index == currentIndex ? Alignment.bottomCenter : Alignment.center,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          index == currentIndex
              ? Container(
                  height: 70,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                )
              : Text(''),
          index == currentIndex
              ? Positioned(
                bottom: 0,
                child: SlideTransition(
                  position: animation,
                  child: Container(
                      height: 5,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                ),
              )
              : Text(''),
          IconButton(
            onPressed: () {
              setState(() {
                currentIndex = index;
                animationController.reset();
                onTap();
              });
            },
            icon: Icon(
              icon,
              size: 35,
              color: index == currentIndex ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
