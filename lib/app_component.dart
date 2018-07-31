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
          var test = 0;
          for (var element in querySelectorAll('.section-container').reversed) {
            var yOffset = element.documentOffset.y;
            var middle = yOffset - 120;

            if (test++ == 1) {
              print('$middle <= ${window.pageYOffset}');
            }

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
    var middle = yOffset - 120;
    window.scrollTo(middle, middle);
  }

  Element getSection(String section, {String queryClass: '.seek-node'}) {
    return querySelectorAll(queryClass).firstWhere((element) {
      return element.getAttribute('section') == section;
    });
  }

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

  var projects = [
    {
      'name': 'Craftathon',
      'description': 'Craftathon is an annual weekend long charity event in Minecraft where we raised \$6,455.23 Note: I am the Lead Developer for this, NOT the Organizer, that belongs to another member of our awesome team, Mistri.',
      'github': null,
      'release': 'https://craftathon.org/'
    },
    {
      'name': 'MS Paint IDE',
      'description': 'Replace your current IDE - Syntax highlighting and code compiling for MS Paint using a custom OCR to read text from your MS Paint images.',
      'github': 'https://github.com/RubbaBoy/MSPaintIDE/',
      'release': 'https://ms-paint-i.de/'
    },
    {
      'name': 'Mine Fortress 2',
      'description': 'Mine Fortress 2 is a remake of the popular game Team Fortress 2. It has features never before seen in plugins to this day, with seamless graphics and customizability.',
      'github': 'https://github.com/RubbaBoy/MineFortress2/',
      'release': 'https://www.spigotmc.org/resources/mine-fortress-2.32824/'
    },
    {
      'name': 'shitprojects.download',
      'description': 'A website to create custom subdomains to route to any URL, with link visit counting.',
      'github': null,
      'release': 'https://shitprojects.download/upload'
    },
    {
      'name': 'Tap The Pickle',
      'description': 'Tap The Pickle is an Android app that allows you to tap, rub, shake, or talk to a pickle with hats, faces, skins, and backgrounds, with full Bluetooth support to play with friends.',
      'github': null,
      'release': 'https://play.google.com/store/apps/details?id=tap.the.pickle'
    },
    {
      'name': 'Book Utils',
      'description': 'Book Utils gives you master control over books in your Spigot server, with importing, exporting, modification and more to books.',
      'github': 'https://github.com/RubbaBoy/BookUtils/',
      'release': 'https://www.spigotmc.org/resources/book-utils.42076/'
    },
    {
      'name': 'Config Helper',
      'description': 'Config Helper is a Spigot API to help users create and use configuration files with ease.',
      'github': 'https://github.com/RubbaBoy/ConfigHelper/',
      'release': 'https://www.spigotmc.org/threads/confighelper-api.285688/'
    },
    {
      'name': 'CodeHelp',
      'description': 'CodeHelp is an Intellij plugin for helping out users who often forget how to do specific things.',
      'github': 'https://github.com/RubbaBoy/CodeHelp/',
      'release': 'https://plugins.jetbrains.com/plugin/10228-codehelp'
    }
  ];
}
