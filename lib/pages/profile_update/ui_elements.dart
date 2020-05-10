import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

typedef void Validator(String value);
typedef void SetNextFocus(int index, BuildContext context);

class PageInput extends StatelessWidget {
  final Key key;
  final InputArguments inputArguments;

  PageInput({
    this.key,
    this.inputArguments,
  }) : super(key: key);

  void _updateController() {
    inputArguments.toUpdate[inputArguments.updateKey] =
        inputArguments.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CustomPaint(
                size: Size(30, 30),
                painter: CirclePoint(),
              ),
            ),
            Expanded(
              flex: 12,
              child: TextFormField(
                validator: inputArguments.validator,
                focusNode: inputArguments.focusNode,
                controller: inputArguments.controller,
                onTap: () {
                  //print("Tapped");
                },
                textInputAction: inputArguments.isLast
                    ? TextInputAction.done
                    : TextInputAction.next,
                onFieldSubmitted: (value) {
                  throw Exception("What Happened");
                  inputArguments.setNextFocus(inputArguments.index, context);
                },
                onEditingComplete: () {
                  throw Exception("What Happened");
                },
                onChanged: (String value) {
                  _updateController();
                },
                decoration: InputDecoration(
                    hintText: inputArguments.hintText,
                    helperText: inputArguments.helperText,
                    hintStyle: Theme.of(context).textTheme.subtitle2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InputArguments {
  int index;
  Validator validator;
  SetNextFocus setNextFocus;
  TextEditingController controller;
  FocusNode focusNode;
  bool isExpanded;
  String hintText;
  String helperText;
  bool isLast;
  Map<String, dynamic> toUpdate;
  String updateKey;

  InputArguments(
      {this.index,
      this.validator,
      this.setNextFocus,
      this.controller,
      this.focusNode,
      this.isExpanded,
      this.hintText,
      this.helperText,
      this.isLast: false,
      this.toUpdate,
      this.updateKey});
}

class PageInputGroup extends StatelessWidget {
  final String groupName;
  final List<InputArguments> args;

  PageInputGroup({this.groupName, this.args});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 5),
                        blurRadius: 10)
                  ]),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    groupName,
                    style: Theme.of(context).textTheme.headline5,
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Show This Card",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  PageSwitch()
                ],
              )),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 40, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _enumInputs(args),
            ),
          )
        ],
      ),
    );
  }

  List<PageInput> _enumInputs(List<InputArguments> args) {
    return args.map((InputArguments arg) {
      return PageInput(
        key: ValueKey(arg.index),
        inputArguments: arg,
      );
    }).toList();
  }
}

class UserBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: CustomPaint(
        painter: UserBannerBackgroundPaint(context: context),
        child: Center(
          child: Container(padding: EdgeInsets.all(10), child: UserImage()),
        ),
      ),
    );
  }
}

class UserImage extends StatefulWidget {
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animationController.status == AnimationStatus.dismissed) {
          animationController.forward();
        }
        if (animationController.status == AnimationStatus.completed) {
          animationController.reverse();
        }
      },
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.white,
          ),
          Positioned(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: AttachedIcon(
                      animation: animationController,
                      iconData: Icons.camera_alt)),
            ),
            bottom: -10,
            left: -10,
          ),
          Positioned(
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: AttachedIcon(
                      animation: animationController,
                      iconData: Icons.file_upload)),
            ),
            top: -10,
            left: -10,
          ),
        ],
      ),
    );
  }
}

class AttachedIcon extends StatelessWidget {
  final Animation<double> animation;
  final IconData iconData;

  AttachedIcon({@required this.animation, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          iconData,
          size: 30,
        ),
      ),
    );
  }
}

class PageSwitch extends StatefulWidget {
  @override
  _PageSwitchState createState() => _PageSwitchState();
}

class _PageSwitchState extends State<PageSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = false;
    animController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutCirc);
    animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          setState(() {
            isOn = false;
          });
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          isOn = true;
          break;
        default:
          break;
      }
    });
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isOn ? animController.reverse() : animController.forward();
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: 17,
        width: 40,
        child: CustomPaint(
          painter: SwitchBorderPainter(isOn: isOn, pos: animation.value),
        ),
      ),
    );
  }
}

class SwitchBorderPainter extends CustomPainter {
  final bool isOn;
  final double pos;

  SwitchBorderPainter({this.isOn, this.pos});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.color = isOn ? Colors.white : Colors.grey;
    paint.strokeWidth = 1;
    double startPosX = 3 / 20 * size.height + 7 / 20 * size.height;
    double endPosX = size.width - (3 / 20 * size.height + 7 / 20 * size.height);

    double currentPosx = startPosX + (endPosX - startPosX) * pos;

    RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(size.height / 2));

    canvas.drawRRect(rrect, paint);

    paint.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(currentPosx, size.height / 2), 7 / 20 * size.height, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CirclePoint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey[300];
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    canvas.drawLine(
        Offset(size.width / 2, -20), Offset(size.width / 2, 80), paint);
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 6, paint);
    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class UserBannerBackgroundPaint extends CustomPainter {
  final BuildContext context;
  UserBannerBackgroundPaint({@required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.fill;
    Path path = new Path()
      ..lineTo(0, 6 / 10 * size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, 6 / 10 * size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
