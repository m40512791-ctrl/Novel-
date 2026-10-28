import 'package:flutter/material.dart';

void main() => runApp(const NovelReaderApp());

class NovelReaderApp extends StatelessWidget {
  const NovelReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF8B5CF6);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NovelVerse',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        scaffoldBackgroundColor: const Color(0xFF0D0E13),
        cardTheme: const CardThemeData(
          color: Color(0xFF171923),
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  final pages = const [
    HomePage(),
    DiscoverPage(),
    LibraryPage(),
    CreatorPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: selected, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => setState(() => selected = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Discover'),
          NavigationDestination(icon: Icon(Icons.library_books_outlined), selectedIcon: Icon(Icons.library_books), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Creator'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        Row(children: [
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('NOVELVERSE', style: TextStyle(fontSize: 12, letterSpacing: 3, color: Color(0xFFB9A4FF), fontWeight: FontWeight.w800)),
            SizedBox(height: 7),
            Text('Your next world\\nstarts here.', style: TextStyle(fontSize: 29, height: 1.08, fontWeight: FontWeight.w800)),
          ])),
          IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
        ]),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: 'Search novels, authors, narrators…',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFF171923),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Continue reading', action: 'See all'),
        const SizedBox(height: 12),
        const ContinueCard(),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Explore your next obsession', action: 'View all'),
        const SizedBox(height: 12),
        const Wrap(spacing: 8, runSpacing: 8, children: [
          GenreChip(label: 'Fantasy', icon: Icons.auto_awesome),
          GenreChip(label: 'Action', icon: Icons.bolt),
          GenreChip(label: 'Mystery', icon: Icons.visibility),
          GenreChip(label: 'Romance', icon: Icons.favorite_border),
          GenreChip(label: 'Cultivation', icon: Icons.waves),
        ]),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Popular this week', action: 'Explore'),
        const SizedBox(height: 12),
        const NovelCard(title: 'The Ashen Crown', subtitle: 'Fantasy • 84 chapters', tag: 'NEW AUDIO'),
        const SizedBox(height: 10),
        const NovelCard(title: 'Echoes of the Immortal', subtitle: 'Cultivation • 216 chapters', tag: 'MULTI-LANGUAGE'),
        const SizedBox(height: 10),
        const NovelCard(title: 'A Thousand Silent Stars', subtitle: 'Sci-fi • 32 chapters', tag: 'EDITOR’S PICK'),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String action;
  const SectionTitle({super.key, required this.title, required this.action});
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w750))),
    Text(action, style: const TextStyle(color: Color(0xFFB9A4FF), fontSize: 12, fontWeight: FontWeight.w700)),
  ]);
}

class ContinueCard extends StatelessWidget {
  const ContinueCard({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(colors: [Color(0xFF30264C), Color(0xFF191B29)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      border: Border.all(color: Colors.white.withOpacity(.07)),
    ),
    child: Row(children: [
      Container(width: 76, height: 100, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: const LinearGradient(colors: [Color(0xFF6D4CC3), Color(0xFF171923)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ), child: const Icon(Icons.auto_stories_rounded, size: 36, color: Colors.white70)),
      const SizedBox(width: 14),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('PICK UP WHERE YOU LEFT OFF', style: TextStyle(fontSize: 9, letterSpacing: 1.3, color: Color(0xFFD2C4FF), fontWeight: FontWeight.w800)),
        SizedBox(height: 7),
        Text('The Ashen Crown', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        SizedBox(height: 5),
        Text('Chapter 12 • 68% read', style: TextStyle(color: Colors.white60, fontSize: 12)),
        SizedBox(height: 12),
        LinearProgressIndicator(value: .68, minHeight: 4, borderRadius: BorderRadius.all(Radius.circular(8))),
      ])),
    ]),
  );
}

class GenreChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const GenreChip({super.key, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) => ActionChip(
    avatar: Icon(icon, size: 16),
    label: Text(label),
    onPressed: () {},
    backgroundColor: const Color(0xFF171923),
    side: BorderSide(color: Colors.white.withOpacity(.06)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
  );
}

class NovelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  const NovelCard({super.key, required this.title, required this.subtitle, required this.tag});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Container(width: 62, height: 78, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [Color(0xFF49396B), Color(0xFF202331)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ), child: const Icon(Icons.menu_book_rounded, size: 28, color: Colors.white70)),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(tag, style: const TextStyle(fontSize: 9, letterSpacing: 1.1, color: Color(0xFFB9A4FF), fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w750)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.white60)),
        ])),
        const Icon(Icons.chevron_right, color: Colors.white38),
      ]),
    ),
  );
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(
    icon: Icons.explore_outlined,
    title: 'Discover',
    subtitle: 'Find novels by genre, language, author, or audiobook availability.',
    bullets: ['Advanced search', 'Genre filters', 'Language editions', 'Trending audiobooks'],
  );
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(
    icon: Icons.library_books_outlined,
    title: 'My Library',
    subtitle: 'Your private imports, reading progress, favorites, and downloads.',
    bullets: ['Continue reading', 'Downloaded books', 'Bookmarks & notes', 'Listening history'],
  );
}

class CreatorPage extends StatelessWidget {
  const CreatorPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(
    icon: Icons.auto_awesome,
    title: 'Creator Studio',
    subtitle: 'Create translations and multilingual audiobook editions.',
    bullets: ['Import a novel', 'Voice-over your novel', 'Upload chapter audio', 'Manage drafts & publishing'],
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(
    icon: Icons.person_outline,
    title: 'Your profile',
    subtitle: 'Account, preferences, downloads, privacy, and app settings.',
    bullets: ['Reading & audio preferences', 'Appearance & accessibility', 'Privacy & security', 'Help & support'],
  );
}

class SimplePage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> bullets;
  const SimplePage({super.key, required this.icon, required this.title, required this.subtitle, required this.bullets});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
    children: [
      Icon(icon, size: 42, color: const Color(0xFFB9A4FF)),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Text(subtitle, style: const TextStyle(color: Colors.white60, height: 1.5)),
      const SizedBox(height: 22),
      ...bullets.map((item) => Card(
        child: ListTile(
          leading: const Icon(Icons.check_circle_outline, color: Color(0xFFB9A4FF)),
          title: Text(item),
          trailing: const Icon(Icons.chevron_right, color: Colors.white38),
          onTap: () {},
        ),
      )),
      const SizedBox(height: 20),
      const Text('Starter UI • Functional integrations are added in later milestones.',
        style: TextStyle(fontSize: 11, color: Colors.white38)),
    ],
  );
}
