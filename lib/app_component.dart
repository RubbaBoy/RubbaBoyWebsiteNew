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
    var lastChecked = -1;
    var scrolled = true;

    new Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (scrolled) {
        void activate(Element element) {
          var section = element.getAttribute('section');
          querySelectorAll('.seek-node').forEach((element) => element.classes.remove('active'));
          getSection(section).classes.add('active');
          getSection(section, queryClass: '.section-container').classes.add('active');
        }

        if (window.pageYOffset == 0) {
          activate(querySelector('.section-container'));
        } else {
          for (var element in querySelectorAll('.section-container').reversed) {
            var yOffset = element.documentOffset.y;
            var height = element.clientHeight;
            var middle = yOffset - (height * 0.75);

            if (middle <= window.pageYOffset) {
              activate(element);
              break;
            }
          }
        }

        scrolled = false;
      }
    });

    document.onScroll.listen((event) {
      var current = new DateTime.now().millisecondsSinceEpoch;
      if (lastChecked == -1 || lastChecked - current > 100) {
        scrolled = true;
      }
    });
  }

  void seekTo(MouseEvent event) {
    Element target = event.currentTarget;
    Element sectionToScrollTo = getSection(target.getAttribute('section'), queryClass: '.section-container');
    var yOffset = sectionToScrollTo.documentOffset.y;
    var height = sectionToScrollTo.clientHeight;
    var middle = yOffset - (height * 0.75);
    window.scrollTo(middle, middle);
  }

  Element getSection(String section, {String queryClass: '.seek-node'}) {
    return querySelectorAll(queryClass).firstWhere((element) {
      return element.getAttribute('section') == section;
    });
  }
}
