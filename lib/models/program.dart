class Program {
  final String id;
  final String title;
  final String category;
  final String duration;
  final String badge; // e.g. "Bestseller", "New", "Popular", ""
  final double rating;
  final int reviews;
  final String instructor;
  final String instructorTitle;
  final String lessons;
  final String pace;
  final String hoursPerWeek;
  final String overview;
  final List<String> syllabus;
  final double progress; // 0.0 - 1.0, only relevant for "Continue Learning"

  const Program({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    this.badge = '',
    this.rating = 4.5,
    this.reviews = 120,
    this.instructor = 'Dr. Sarah Chen',
    this.instructorTitle = 'Senior UX Lead @ Google',
    this.lessons = '24 Lessons',
    this.pace = 'Self-paced',
    this.hoursPerWeek = '4.5h / week',
    this.overview =
        'A comprehensive, hands-on program designed to take you from fundamentals '
        'to real-world application through guided projects and mentor feedback.',
    this.syllabus = const [
      'Module 1 — Foundations',
      'Module 2 — Core Concepts',
      'Module 3 — Applied Project',
      'Module 4 — Capstone & Review',
    ],
    this.progress = 0.0,
  });
}

/// Mock catalog used across the prototype.
final List<Program> mockPrograms = [
  const Program(
    id: 'p1',
    title: 'Product Design Mastery',
    category: 'Design',
    duration: '12 weeks',
    badge: 'Bestseller',
    rating: 4.8,
    reviews: 342,
  ),
  const Program(
    id: 'p2',
    title: 'Python for Data Science',
    category: 'Engineering',
    duration: '8 weeks',
    badge: 'New',
    rating: 4.6,
    reviews: 198,
    instructor: 'Marcus Lee',
    instructorTitle: 'Data Science Lead @ Stripe',
  ),
  const Program(
    id: 'p3',
    title: 'Digital Marketing Pro',
    category: 'Marketing',
    duration: '6 weeks',
    badge: 'Popular',
    rating: 4.5,
    reviews: 256,
    instructor: 'Amara Obi',
    instructorTitle: 'Growth Marketing Director',
  ),
  const Program(
    id: 'p4',
    title: 'Leadership & Management',
    category: 'Business',
    duration: '10 weeks',
    rating: 4.7,
    reviews: 175,
    instructor: 'James Whitfield',
    instructorTitle: 'Executive Coach',
  ),
  const Program(
    id: 'p5',
    title: 'UX Research Fundamentals',
    category: 'Design',
    duration: '5 weeks',
    rating: 4.4,
    reviews: 89,
    progress: 0.84,
  ),
  const Program(
    id: 'p6',
    title: 'Data Analysis Bootcamp',
    category: 'Engineering',
    duration: '9 weeks',
    rating: 4.6,
    reviews: 210,
    progress: 0.64,
  ),
];

List<Program> get continueLearningPrograms =>
    mockPrograms.where((p) => p.progress > 0).toList();
