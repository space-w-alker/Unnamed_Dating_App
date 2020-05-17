import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:unnameddatingapp/pages/profile_update/profile_update_controller.dart';
import 'ui_elements.dart';
import '../../statics/constants.dart';
import '../../services/firestore.dart';

class ProfileUpdate extends StatefulWidget {
  final Key key;

  ProfileUpdate({this.key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  List<InputArguments> args;

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: true);
    AppDatabase.createProfile(user);
    args = _getInputArguments(context);
    return Stack(
      children: [
        Form(
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  UserBanner(),
                  PageInputGroup(
                    key: ValueKey(1),
                    groupName: "Personal Info",
                    args: args.getRange(0, 5).toList(),
                  ),
                  PageInputGroup(
                    key: ValueKey(2),
                    groupName: "Taste In Music",
                    args: args.getRange(5, 8).toList(),
                  ),
                  PageInputGroup(
                    key: ValueKey(3),
                    groupName: "Movies You Love",
                    args: args.getRange(8, 11).toList(),
                  ),
                  PageInputGroup(
                    key: ValueKey(4),
                    groupName: "Technology",
                    args: args.getRange(11, 14).toList(),
                  ),
                  PageInputGroup(
                    key: ValueKey(5),
                    groupName: "Extras",
                    args: args.getRange(14, 18).toList(),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          child: PageFloatingButton(
            text: "Save Profile",
            onPressed: () {
              Provider.of<ProfileUpdateController>(context, listen: false).updateProfile(user);
            },
          ),
          bottom: 24,
          right: 24,
        )
      ],
    );
  }

  List<InputArguments> _getInputArguments(BuildContext context) {
    return <InputArguments>[
      InputArguments(
          index: 0,
          hintText: "Name",
          toUpdate: Provider.of<ProfileUpdateController>(context).personal_info,
          updateKey: USER_NAME_FIELD,
          setNextFocus: FocusNext),
      InputArguments(
          index: 1,
          hintText: "Job",
          toUpdate: Provider.of<ProfileUpdateController>(context).personal_info,
          updateKey: USER_JOB_FIELD,
          setNextFocus: FocusNext),
      InputArguments(
          index: 2,
          hintText: "Date Of Birth",
          toUpdate: Provider.of<ProfileUpdateController>(context).personal_info,
          updateKey: USER_DATE_OF_BIRTH,
          setNextFocus: FocusNext),
      InputArguments(
          index: 3,
          hintText: "Height",
          toUpdate: Provider.of<ProfileUpdateController>(context).personal_info,
          updateKey: USER_HEIGHT,
          setNextFocus: FocusNext),
      InputArguments(
          index: 4,
          hintText: "To All",
          helperText: "Say a few choice words to anyone viewing your profile",
          toUpdate: Provider.of<ProfileUpdateController>(context).personal_info,
          updateKey: USER_TO_ALL,
          setNextFocus: FocusNext,
          isLast: true),
      InputArguments(
          index: 5,
          hintText: "Music #1",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .music_taste,
          updateKey: MU_1,
          setNextFocus: FocusNext),
      InputArguments(
          index: 6,
          hintText: "Music #2",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .music_taste,
          updateKey: MU_2,
          setNextFocus: FocusNext),
      InputArguments(
          index: 7,
          hintText: "Music #3",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .music_taste,
          updateKey: MU_3,
          setNextFocus: FocusNext),
      InputArguments(
          index: 8,
          hintText: "Movie #1",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .movies,
          updateKey: MO_1,
          setNextFocus: FocusNext),
      InputArguments(
          index: 9,
          hintText: "Movie #2",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .movies,
          updateKey: MO_2,
          setNextFocus: FocusNext),
      InputArguments(
          index: 10,
          hintText: "Movie #3",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .movies,
          updateKey: MO_3,
          setNextFocus: FocusNext),
      InputArguments(
          index: 11,
          hintText: "OS of Choice",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .tech_life,
          updateKey: OS_OF_CHOICE,
          helperText: "Chose your camp. Windows, Mac or Linux",
          setNextFocus: FocusNext),
      InputArguments(
          index: 12,
          hintText: "Phone of Choice",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .tech_life,
          updateKey: PHONE_OF_CHOICE,
          helperText: "Andorid or iOS",
          setNextFocus: FocusNext),
      InputArguments(
          index: 13,
          hintText: "Gaming Platform",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .tech_life,
          updateKey: GAME_PLATFORM,
          helperText: "Where do you play?"),
      InputArguments(
          index: 14,
          hintText: "Productive Hobby",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .extras,
          updateKey: PRODUCTIVE_HOBBY),
      InputArguments(
          index: 15,
          hintText: "Non-Productive Hobby",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .extras,
          updateKey: NON_PRODUCTIVE_HOBBY),
      InputArguments(
          index: 16,
          hintText: "Favourite Human",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .extras,
          updateKey: FAVOURITE_HUMAN),
      InputArguments(
          index: 17,
          hintText: "Favourite Fictional Character",
          toUpdate: Provider.of<ProfileUpdateController>(context, listen: false)
              .extras,
          updateKey: FAVOURITE_FICTIONAL_CHARACTER),
    ];
  }

  void FocusNext(int index, BuildContext context) {
    args[index].focusNode.unfocus();
    FocusScope.of(context).requestFocus(args[index + 1].focusNode);
  }
}
