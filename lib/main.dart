//////////////////////////////////////////////
///     All rights is preserved
///           Authors
///     Nurtay Maksat
///     Kairbiev Alibi
//////////////////////////////////////////////

//////////////////////////////////////////////
/// GIT - Flow
///   Installation
///     [1] brew install git-flow
///   Configuration
///     [1] git flow init -d
///     [2] git push origin master
///     [3] git push origin develop
///   Instructions
///     [1] --- when going to develop feature create branch
///         git flow feature start name-of-new-feature
///     [2] --- in order to load our branch to github
///         git checkout develop
///         git flow feature publish name-of-new-feature
///               or
///         git push origin feature/name-of-new-feature
///     [3]  --- when you make and finish some changes
///          git add -A
///          git commit -m "The full description what a gavno ty napisal"
///          --- go to step [2] to load to github
///     [4]  --- below a command when you finish your feature send PULL REQUEST
///          --- In gitHUB web site just press send pull request button
///     [5]  --- After reviewing PULL REQUEST merge it
///          git flow feature finish name-of-new-feature
///          git push origin develop
///          --- alternatively you can do it on website interface
/////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wmn_plus/navigation/navigation.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(App());
}
