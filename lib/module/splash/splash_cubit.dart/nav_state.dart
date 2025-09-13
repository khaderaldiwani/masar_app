import 'package:equatable/equatable.dart';

sealed class NavState extends Equatable{
final String route;
const NavState(this.route);   
  @override
  List<Object?> get props => [route];
}
class NavStateInit extends NavState{
  const NavStateInit(super.route);
}
class NavStateHome extends NavState{
  const NavStateHome(super.route);
  
}