import 'package:flutter/material.dart';
import 'package:mainalihr/feature/detail_job/presentation/detail_job_screen.dart';
import 'package:mainalihr/feature/get_started/presentation/get_started_screen.dart';
import 'package:mainalihr/feature/home/presentation/home_screen.dart';
import 'package:mainalihr/feature/home/presentation/home_screen2.dart';
import 'package:mainalihr/screen/ClientEnquiry.dart';
import 'package:mainalihr/screen/Education.dart';
import 'package:mainalihr/screen/Experience.dart';
import 'package:mainalihr/screen/JobSeekersScreen.dart';
import 'package:mainalihr/screen/Jobposting.dart';
import 'package:mainalihr/screen/Jobseeker.dart';
import 'package:mainalihr/screen/UploadDocumentView.dart';
import 'package:mainalihr/screen/clientNavigation.dart';
import 'package:mainalihr/screen/home/client/demandidstatus.dart';
import 'package:mainalihr/screen/jobstatus/jobseekerjobstatus.dart';
import 'package:mainalihr/screen/register_page.dart';
import 'package:mainalihr/screen/search/GetSelectedView.dart';
import 'package:mainalihr/screen/search/SearchJobSeeker.dart';
import 'package:mainalihr/screen/search/getPassport.dart';
import 'package:mainalihr/ui/profileui.dart';
import 'package:mainalihr/client_screen/client_registration.dart';

import '/core/route/app_route_name.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.getStarted:
        return MaterialPageRoute(
          builder: (_) => const GetStartedScreen(),
          settings: settings,
        );

      case AppRouteName.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRouteName.detailJob:
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => DetailJobScreen(),
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
      case AppRouteName.jobSeekerNavigation: // Handle the new route
  return MaterialPageRoute(
    builder: (_) => const JobSeekerNavigation(),
    settings: settings,
  );
      case AppRouteName.registerPage: // Handle the new route
  return MaterialPageRoute(
    builder: (_) => const RegisterPage(),
    settings: settings,
  );
   case AppRouteName.CreateJobseekerExperience: // Handle the new route
  return MaterialPageRoute(
    builder: (_) => const CreateJobseekerExperience(),
    settings: settings,
  );
case AppRouteName.CreateJobseekerEducation: // Handle the new route
  final args = settings.arguments as String; // Assuming the argument is a String
  return MaterialPageRoute(
    builder: (_) => const CreateJobseekerEducation(),
    settings: settings,
  );
    case AppRouteName.UploadDocumentView: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const UploadDocumentView(),
    settings: settings,
  );
     case AppRouteName.CreateJobseekerJobposting: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const CreateJobseekerJobposting(),
    settings: settings,
  );
      case AppRouteName.GetAllJobSeekersView: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const GetAllJobSeekersView(),
    settings: settings,
  );
    case AppRouteName.clientNavigation: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const ClientNavigation(),
    settings: settings,
  );
  case AppRouteName.HomeScreen2: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const HomeScreen2(),
    settings: settings,
  );

  case AppRouteName.SearchJobSeeker: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const SearchJobSeeker(),
    settings: settings,
  );
   case AppRouteName.GetSelectedView: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const GetSelectedView(),
    settings: settings,
  );
  case AppRouteName.SelectedApplicantsScreen: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const SelectedApplicantsScreen(),
    settings: settings,
  );
    case AppRouteName.ApplicantDetailsScreen: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const ApplicantDetailsScreen(),
    settings: settings,
  );
    case AppRouteName.ClientDetailsScreen: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const ClientDetailsScreen(),
    settings: settings,
  );
      case AppRouteName.ProfileUI: // Handle the new route
    return MaterialPageRoute(
    builder: (_) => const ProfileUI(),
    settings: settings,
  );
  
  case AppRouteName.ClientForm: // Handle the new route
return MaterialPageRoute(
  builder: (_) => const ClientForm(), // Assuming ClientForm is a stateless widget
  settings: settings,
);
  case AppRouteName.RecordView: // Handle the new route
return MaterialPageRoute(
  builder: (_) => const RecordView(), // Assuming ClientForm is a stateless widget
  settings: settings,
);
    }

    return null;
  }
}
