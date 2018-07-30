import 'dart:async';

import 'package:angular/angular.dart';
import 'dart:html';
//import 'package:angular_components/angular_components.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [],
  providers: const [],
)
class AppComponent implements OnInit {

  @override
  void ngOnInit() {
    new Future.delayed(const Duration(milliseconds: 400), () => querySelector(".section").classes.add("active"));
  }
}
