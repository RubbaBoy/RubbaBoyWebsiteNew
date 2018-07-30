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
  directives: const [CORE_DIRECTIVES],
  providers: const [],
)
class AppComponent implements OnInit {

  var experiences = [
    {
      'name': 'Java',
      'description': 'I have been using Java for over 4 years. I am very expierenced in the Spigot/Bukkit APIs, with many projects and collaborations under my belt.'
    },
    {
      'name': 'PHP',
      'description': 'I have been using PHP for around 3 years. I have several private and public projects integrated with several other technologies as well.'
    },
    {
      'name': 'JavaScript',
      'description': 'I have a around 4 years in JavaScript knowledge, having used many large libraries in many projects, often in combination with other technologies.'
    },
    {
      'name': 'HTML',
      'description': 'HTML has been the base of my web projects for the 4 years I\'ve been developing for the web.'
    },
    {
      'name': 'CSS',
      'description': 'CSS, being the only turing complete styling language for the web, has deminished my reputation as a creator by making my websites look significantly worse for the past 4 years.'
    },
    {
      'name': 'Dart',
      'description': 'I have been learning Dart for several months now, primarily using AngularDart, with plans to use Flutter in the near future.'
    },
    {
      'name': 'Brainfuck',
      'description': 'I\'ve been programming with Brainfuck for around 2 years on and off when I get the chance to, helping me pass the time away from home.'
    },
    {
      'name': 'SQL',
      'description': 'SQL, though not a language, has been vital for many of my projects for the past 2 years, primarily using MySQL and SQLite.'
    },
  ];

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
            var middle = yOffset - (height * 1);

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
    var middle = yOffset - (height * 1);
    window.scrollTo(middle, middle);
  }

  Element getSection(String section, {String queryClass: '.seek-node'}) {
    return querySelectorAll(queryClass).firstWhere((element) {
      return element.getAttribute('section') == section;
    });
  }
}
