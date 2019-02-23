import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'dart:html';

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

    querySelectorAll('a.seek-node').onClick.listen((event) {
      smoothScrolling(event, offset: -50, duration: 1000);
    });

    Future.delayed(Duration(milliseconds: 350), () => querySelector('.links-bar').classes.add('animations'))
    .then((ignored) => Future.delayed(Duration(milliseconds: 250), () => querySelector('body').classes.add('loaded')))
    .then((ignored) => Future.delayed(Duration(milliseconds: 1500), () => querySelector('.links-bar').classes.add('ready')));

    Timer.periodic(Duration(milliseconds: 100), (timer) {
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
            var middle = yOffset - window.outerHeight / 2;

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

  DivElement getProjectCard(Element child) {
    if ((child is DivElement) && child.classes.contains('project-card')) {
      return child;
    } else {
      if (child.parent != null) return getProjectCard(child.parent);
    }

    return null;
  }

  var expanded = [];

  void onHoverProject(MouseEvent event) {
    var div = getProjectCard(event.target);
    div.querySelectorAll('.special-button').forEach((special) {
      special.classes.add('active');
    });
  }

  void onLeaveProject(MouseEvent event) {
    var div = getProjectCard(event.target);
    div.querySelectorAll('.special-button').forEach((special) {
      special.classes.remove('active');
    });
  }

  Element getSection(String section, {String queryClass: '.seek-node'}) {
    return querySelectorAll(queryClass).firstWhere((element) {
      return element.getAttribute('section') == section;
    });
  }

  void smoothScrolling(MouseEvent click, {int offset: 0, int duration: 500}) {
    click.preventDefault();
    AnchorElement link = click.target;
    var anchor = link.getAttribute('section');
    int targetPosition = getSection(anchor, queryClass: '.section-container').documentOffset.y;

    targetPosition += offset;

    var totalFrames = (duration / (1000 / 60)).round().toDouble();
    var currentFrame = 0;
    var currentPosition = window.scrollY.toDouble();
    var distanceBetween =  targetPosition - currentPosition;
    double addXFrame = 1 / totalFrames;
    double xFrame = 0;

    void animation(num frame) {
      if (totalFrames >= currentFrame) {

        window.scrollTo(0, currentPosition + easeInOutExpo(xFrame += addXFrame) * distanceBetween);

        currentFrame++;
        window.animationFrame.then(animation);
      }
    }

    window.animationFrame.then(animation);
  }

  double easeInOutExpo(x) {
    return x == 0 ? 0 : x == 1 ? 1 : x < 0.5 ?
    pow(2, 20 * x - 10) / 2 :
    (2 - pow(2, -20 * x + 10)) / 2;
  }

  var experiences = [
    {
      'name': 'Java',
      'description': 'I have been using Java for over 5 years. I am familiar with many large libraries/frameworks, and have led teams and done many collaborations over the years'
    },
    {
      'name': 'PHP',
      'description': 'I have been using PHP for around 4 years. I have several private and public projects integrated with several other technologies as well.'
    },
    {
      'name': 'JavaScript',
      'description': 'I have a around 5 years in JavaScript knowledge, having used many large libraries in many projects, often in combination with other technologies.'
    },
    {
      'name': 'HTML',
      'description': 'HTML has been the base of my web projects for the 5 years I\'ve been developing for the web.'
    },
    {
      'name': 'CSS',
      'description': 'CSS, being the only turing complete styling language for the web, has deminished my reputation as a creator by making my websites look significantly worse for the past 5 years.'
    },
    {
      'name': 'Dart',
      'description': 'I have been learning Dart for several months now, primarily using AngularDart, with plans to use Flutter in the near future.'
    },
    {
      'name': 'Brainfuck',
      'description': 'I\'ve been programming with Brainfuck for around 5 years on and off when I get the chance to.'
    },
    {
      'name': 'SQL',
      'description': 'SQL, though not a language, has been vital for many of my projects for the past 3 years, primarily using MySQL and SQLite.'
    },
  ];

  var projects = [
    {
      'name': 'Craftathon',
      'description': 'Craftathon is an annual weekend long charity event in Minecraft where we have raised \$7,599 so far. I am the Lead Developer for this, NOT the Organizer, which belongs to another member of our awesome team, Mistri.',
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
      'name': 'NewOCR',
      'description': 'A custom OCR without using Machine Learning in Java, using little-used techniques to produce accurate results across many fonts and font sizes.',
      'github': 'https://github.com/RubbaBoy/NewOCR',
      'release': 'https://search.maven.org/artifact/com.uddernetworks.newocr/NewOCR/'
    },
    {
      'name': 'shitprojects.download',
      'description': 'A website to create custom subdomains to route to any URL, with link visit counting.',
      'github': null,
      'release': 'https://shitprojects.download/'
    },
    {
      'name': 'Mine Fortress 2',
      'description': 'Mine Fortress 2 is a remake of the popular game Team Fortress 2. It has features never before seen in plugins to this day, with seamless graphics and customizability.',
      'github': 'https://github.com/RubbaBoy/MineFortress2/',
      'release': 'https://www.spigotmc.org/resources/mine-fortress-2.32824/'
    },
    {
      'name': 'CodeFormatter',
      'description': 'Formats your code (Or whole GitHub repos) by moving all brackets and semicolons to the side in a perfect line to match your perfect code.',
      'github': 'https://github.com/RubbaBoy/CodeFormatter',
      'release': 'https://rubbaboy.me/codeformatter/'
    },
    {
      'name': 'Tap The Pickle',
      'description': 'Tap The Pickle is an Android app that allows you to tap, rub, shake, or talk to a pickle with hats, faces, skins, and backgrounds, with full Bluetooth support to play with friends.',
      'github': null,
      'release': 'https://play.google.com/store/apps/details?id=tap.the.pickle'
    },
    {
      'name': 'MC Book IDE',
      'description': 'MC Book IDE allows you to program Java in Minecraft books, with highlighyting and error displaying features available.',
      'github': 'https://github.com/RubbaBoy/MCBookIDE',
      'release': 'https://www.spigotmc.org/resources/mc-book-ide.50946/'
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
    }
  ];
}
