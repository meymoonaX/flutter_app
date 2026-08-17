import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/program.dart';

class ProgramDetailsScreen extends StatefulWidget {
  final Program program;
  const ProgramDetailsScreen({super.key, required this.program});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _enrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _enroll() {
    setState(() => _enrolled = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Enrolled in ${widget.program.title}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.program;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.cream,
            foregroundColor: AppColors.ink,
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.card,
                alignment: Alignment.center,
                child: const Icon(Icons.image_outlined, size: 48, color: AppColors.muted),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (p.badge.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.ink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(p.badge,
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text('${p.duration} · ⭐ ${p.rating} (${p.reviews})',
                          style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(p.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.ink,
                        child: Text(p.instructor.substring(0, 1),
                            style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.instructor, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(p.instructorTitle, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.ink,
                    unselectedLabelColor: AppColors.muted,
                    indicatorColor: AppColors.ink,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Syllabus'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: TabBarView(
              controller: _tabController,
              children: [
                _OverviewTab(program: p),
                _SyllabusTab(program: p),
                const _ReviewsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: ElevatedButton(
            onPressed: _enrolled ? null : _enroll,
            child: Text(_enrolled ? 'ENROLLED ✓' : 'ENROLL NOW'),
          ),
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  final Program program;
  const _OverviewTab({required this.program});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(program.overview, style: const TextStyle(height: 1.5, color: AppColors.ink)),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: [
              _InfoTile(icon: Icons.workspace_premium_outlined, label: 'Certificate'),
              _InfoTile(icon: Icons.timelapse, label: program.pace),
              _InfoTile(icon: Icons.menu_book_outlined, label: program.lessons),
              _InfoTile(icon: Icons.schedule, label: program.hoursPerWeek),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.ink),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _SyllabusTab extends StatelessWidget {
  final Program program;
  const _SyllabusTab({required this.program});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: program.syllabus.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.outline),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.card,
              child: Text('${i + 1}', style: const TextStyle(fontSize: 12, color: AppColors.ink)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(program.syllabus[i])),
          ],
        ),
      ),
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab();

  @override
  Widget build(BuildContext context) {
    final reviews = [
      ('Priya S.', 5.0, 'Clear structure and genuinely useful projects.'),
      ('Daniel K.', 4.0, 'Great pacing, would love more live sessions.'),
      ('Wei L.', 5.0, 'Helped me land a new role within weeks of finishing.'),
    ];
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final (name, rating, text) = reviews[i];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.outline),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('⭐ $rating', style: const TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              Text(text, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
            ],
          ),
        );
      },
    );
  }
}
