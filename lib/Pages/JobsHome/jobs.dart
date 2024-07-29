import 'package:plumber/components/welcomeCard.dart';
import 'package:flutter/material.dart';

class JobSelection extends StatefulWidget {
  const JobSelection({super.key});

  @override
  State<JobSelection> createState() => _JobSelectionState();
}

class _JobSelectionState extends State<JobSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeCard(
                titleEN: 'FIND JOBS',
                onTap: '/findJobs',
                image: AssetImage('assets/find jobs.jpg'),
                title: 'රැකියාවක් සොයා ගැනීම',
                subtitle:
                    'ඔබගේ සුදුසුකම්වලට වඩාත් සරිලන රැකියාවක් සොයා ගැනීමට පිවිසෙන්න'),
            WelcomeCard(
                titleEN: 'POST JOBS',
                onTap: '/postJobHome',
                image: AssetImage('assets/job post.jpg'),
                title: 'රැකියාවක් ලබාදීම',
                subtitle:
                    'ඔබගේ සේවා ස්ථානය සඳහා සේවකයින් සොයා ගැනීමට පිවිසෙන්න'),
          ],
        ),
      ),
    );
  }
}
