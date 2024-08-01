part of 'locbloc_bloc.dart';
 class LocEvent {
}

class ChangeLang extends LocEvent {
 Locale loc ;
 ChangeLang({required this.loc}); 
}