part of 'nav_cubit.dart';

 class NavState extends Equatable {
  final HomeNavItem navItem;
    final int index;

  const NavState({required this.navItem, required this.index});

  @override
  List<Object> get props => [ navItem, index];
}

