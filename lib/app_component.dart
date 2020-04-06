import 'package:angular/angular.dart';
import 'src/board_component.dart';
// import 'src/board_command.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [BoardComponent],
)
class AppComponent {
  var name = 'Angular';
}
