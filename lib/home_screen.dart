import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/program.dart';
import '../widgets/bottom_nav.dart';
import 'program_list_screen.dart';
import 'program_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final continuing = continueLearningPrograms;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Good morning,\n', style: TextStyle(fontSize: 13, color: AppColors.muted)),
              TextSpan(
                text: 'Alex Rivera',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppColors.ink,
              child: const Text('AR', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          TextField(
            readOnly: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProgramListScreen()),
            ),
            decoration: const InputDecoration(
              hintText: 'Search programs, internships...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Featured Program',
                    style: TextStyle(color: AppColors.muted, fontSize: 12)),
                const SizedBox(height: 6),
                const Text('Product Design Mastery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.ink,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgramDetailsScreen(program: mockPrograms.first),
                    ),
                  ),
                  child: const Text('View details →'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Continue Learning',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...continuing.map((p) => _ContinueCard(program: p)),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final Program program;
  const _ContinueCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProgramDetailsScreen(program: program)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.play_arrow_rounded, color: AppColors.ink),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(program.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: program.progress,
                      minHeight: 5,
                      backgroundColor: AppColors.outline,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${(program.progress * 100).round()}% complete',
                      style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
