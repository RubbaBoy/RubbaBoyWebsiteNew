import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES],
  providers: const [],
)
class AppComponent implements OnInit {
  var expanded = [];

  @override
  void ngOnInit() {
    var lastChecked = -1;
    var scrolled = true;

    querySelectorAll('a.seek-node')
        .onClick
        .listen((event) => smoothScrolling(event, offset: -50, duration: 1000));

    Future.delayed(Duration(milliseconds: 350),
            () => querySelector('.links-bar').classes.add('animations'))
        .then((ignored) => Future.delayed(Duration(milliseconds: 250),
            () => querySelector('body').classes.add('loaded')))
        .then((ignored) => Future.delayed(Duration(milliseconds: 1500),
            () => querySelector('.links-bar').classes.add('ready')));

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (scrolled) {
        void activate(Element element) {
          var section = element.getAttribute('section');
          querySelectorAll('.seek-node')
              .forEach((element) => element.classes.remove('active'));
          getSection(section).classes.add('active');
          getSection(section, queryClass: '.section-container')
              .classes
              .add('active');
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

  void onHoverProject(MouseEvent event) {
    var div = getProjectCard(event.target);
    div
        .querySelectorAll('.special-button')
        .forEach((special) => special.classes.add('active'));
  }

  void onLeaveProject(MouseEvent event) {
    var div = getProjectCard(event.target);
    div
        .querySelectorAll('.special-button')
        .forEach((special) => special.classes.remove('active'));
  }

  Element getSection(String section, {String queryClass: '.seek-node'}) {
    return querySelectorAll(queryClass)
        .firstWhere((element) => element.getAttribute('section') == section);
  }

  void smoothScrolling(MouseEvent click, {int offset: 0, int duration: 500}) {
    click.preventDefault();
    AnchorElement link = click.target;
    var anchor = link.getAttribute('section');
    int targetPosition =
        getSection(anchor, queryClass: '.section-container').documentOffset.y;

    targetPosition += offset;

    var totalFrames = (duration / (1000 / 60)).round().toDouble();
    var currentFrame = 0;
    var currentPosition = window.scrollY.toDouble();
    var distanceBetween = targetPosition - currentPosition;
    double addXFrame = 1 / totalFrames;
    double xFrame = 0;

    void animation(num frame) {
      if (totalFrames >= currentFrame) {
        window.scrollTo(
            0,
            currentPosition +
                easeInOutExpo(xFrame += addXFrame) * distanceBetween);

        currentFrame++;
        window.animationFrame.then(animation);
      }
    }

    window.animationFrame.then(animation);
  }

  double easeInOutExpo(x) {
    return x == 0
        ? 0
        : x == 1
            ? 1
            : x < 0.5
                ? pow(2, 20 * x - 10) / 2
                : (2 - pow(2, -20 * x + 10)) / 2;
  }

  var experiences = [
    {
      'name': 'Java',
      'description':
          'I have been using Java for over 5 years. I am familiar with many large libraries/frameworks, and have led teams and done many collaborations over the years'
    },
    {
      'name': 'PHP',
      'description':
          'I have been using PHP on-and-off for around 4 years. I have several private and public projects integrated with several other technologies as well.'
    },
    {
      'name': 'JavaScript',
      'description':
          'I have a around 5 years in JavaScript knowledge, having used many large libraries in many projects, often in combination with other technologies.'
    },
    {
      'name': 'HTML',
      'description':
          'HTML has been the base of my web projects for the 5 years I\'ve been developing for the web.'
    },
    {
      'name': 'CSS',
      'description':
          'CSS, being the only turing complete styling language for the web, has deminished my reputation as a creator by making my websites look significantly worse for the past 5 years.'
    },
    {
      'name': 'Dart',
      'description':
          'I have been learning Dart for several months now, primarily using AngularDart and Flutter.'
    },
    {
      'name': 'Brainfuck',
      'description':
          'I\'ve been programming with Brainfuck for around 5 years on and off when I get the chance to.'
    },
    {
      'name': 'SQL',
      'description':
          'SQL, though not a language, has been vital for many of my projects for the past 4 years.'
    },
  ];

  var projects = [
    {
      'name': 'Craftathon',
      'description':
          'Craftathon is an annual weekend long charity event in Minecraft where we have raised \$7,599 so far. I am the Lead Developer for this, NOT the Organizer, which belongs to another member of our awesome team, Mistri.',
      'github': null,
      'release': 'https://craftathon.org/'
    },
    {
      'name': 'MS Paint IDE',
      'description':
          'Replace your current IDE - Syntax highlighting and code compiling for MS Paint using a custom OCR to read text from your MS Paint images. This has been my biggest personal project, consisting of 11 separate repositories.',
      'github': 'https://github.com/MSPaintIDE/MSPaintIDE/',
      'release': 'https://ms-paint-i.de/'
    },
    {
      'name': 'NewOCR',
      'description':
          'A custom OCR without using Neural Networks in Java. This was a huge project involving a lot of research, featuring thorough documentation.',
      'github': 'https://github.com/RubbaBoy/NewOCR',
      'release':
          'https://search.maven.org/artifact/com.uddernetworks.newocr/NewOCR/'
    },
    {
      'name': 'ChatFilter',
      'description':
          'A fast and advanced chat filter made for Craftathon. Full specs and brnachmarking are available.',
      'github': 'https://github.com/RubbaBoy/ChatFilter',
      'release': null
    },
    {
      'name': 'HolySheet',
      'description':
          'Store any file of any size for free in Google Sheets, with a clean webapp, Desktop app, and CLI. Scaleable with Kubernetes and Docker.',
      'github': 'https://github.com/HolySheet',
      'release': 'https://holysheet.net/'
    },
    {
      'name': 'EmojIDE',
      'description':
          'A working and reactive IDE in Discord emojis, featuring emoji management across 41 Discord servers. This was made for the r/ProgrammerHumor Hackathon, getting second place.',
      'github': 'https://github.com/RubbaBoy/EmojIDE',
      'release': 'https://www.youtube.com/watch?v=06pMgnB6e6o'
    },
    {
      'name': 'BFJVM',
      'description':
          'A program to compile Brainfuck into JVM classes without the use of any libraries or external tools for compiling.',
      'github': 'https://github.com/RubbaBoy/BFJVM',
      'release': null
    },
    {
      'name': 'MovieBot',
      'description':
          'A Discord bot to convert movies into gifs, syncing them up to audio in a voice channel. For the 2019 Discord Hack Week.',
      'github': 'https://github.com/RubbaBoy/MovieBot',
      'release': null
    },
    {
      'name': 'shitprojects.download',
      'description':
          'A website to create custom subdomains to route to any URL, with link visit counting.',
      'github': null,
      'release': 'https://shitprojects.download/'
    },
    {
      'name': 'CodeFormatter',
      'description':
          'Formats your code (Or whole GitHub repos) by moving all brackets and semicolons to the side in a perfect line to match your perfect code.',
      'github': 'https://github.com/RubbaBoy/CodeFormatter',
      'release': 'https://rubbaboy.me/codeformatter/'
    },
    {
      'name': 'WSS',
      'description':
          'Convert nested CSS into full webpages, with the ability to recreate any webpage in just CSS.',
      'github': 'https://github.com/RubbaBoy/WSS',
      'release': null
    }
  ];
}
