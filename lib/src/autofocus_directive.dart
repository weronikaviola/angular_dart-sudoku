import 'dart:html';
import 'package:angular/angular.dart';

@Directive(
  selector: '[autofocus]',
)

class AutofocusDirective implements OnInit{
  Element el;

  AutofocusDirective(Element el) {
    this.el = el;
  }

  @override
  void ngOnInit() {
    el.focus();
  }
}