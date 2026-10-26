import '../models/course.dart';

final List<Course> coursesList = [
  /// SOFTWARE COURSE #1: Flutter Architecture Masterclass
  Course(
    id: 'flutter-clean-architecture-course',
    title: 'Mastering Flutter Architecture & State Management',
    subtitle: 'From Spaghetti Code to Scalable Production Apps',
    description:
        'A comprehensive, battle-tested curriculum covering clean architecture, robust state management with Bloc and Riverpod, offline data synchronization, and automated testing.',
    category: 'software',
    categoryLabel: 'Flutter & Mobile',
    level: 'Intermediate to Advanced',
    duration: '12 Modules • 14 Hours Video',
    badge: 'Masterclass',
    topics: [
      'Clean Architecture & Separation of Concerns',
      'Bloc vs Riverpod in Enterprise Projects',
      'Offline Caching with SQLite & Hive',
      'Unit, Widget & Integration Testing',
    ],
    features: [
      'Complete production repository included',
      'Lifetime course access & updates',
      'Direct instructor Q&A support',
    ],
    ctaText: 'Explore Syllabus & Watch Intro',
    icon: '📱',
    introVideoUrl: 'https://www.youtube.com/watch?v=fq4N0hgOWzU',
    chapters: [
      CourseChapter(
        id: 'ch-1-architecture',
        title: 'Chapter 1: Clean Architecture Principles',
        description: 'Understand domain-driven design, entities, usecases, and repository abstractions.',
        lessons: [
          CourseLesson(
            id: 'l-1-1',
            title: '1.1 Introduction & The Spaghetti Code Dilemma',
            duration: '12:30',
            videoUrl: 'https://www.youtube.com/watch?v=fq4N0hgOWzU',
            isFreePreview: true,
            notes: 'Deconstruct why traditional setState and god-widgets fail as apps scale.',
          ),
          CourseLesson(
            id: 'l-1-2',
            title: '1.2 Domain Layer: Entities & Pure Dart Usecases',
            duration: '22:15',
            videoUrl: 'https://www.youtube.com/watch?v=76vA9kI1w78',
            isFreePreview: true,
            notes: 'Learn how to keep your business logic completely decoupled from Flutter UI.',
          ),
          CourseLesson(
            id: 'l-1-3',
            title: '1.3 Data Layer: Models, Data Sources & Repositories',
            duration: '19:40',
            videoUrl: 'https://www.youtube.com/watch?v=1xipg02Wu8s',
            isFreePreview: false,
            notes: 'Implement remote and local data source contracts with error handling.',
          ),
        ],
      ),
      CourseChapter(
        id: 'ch-2-state',
        title: 'Chapter 2: Enterprise State Management',
        description: 'Deep dive into BLoC, Cubits, Riverpod, and immutable state models.',
        lessons: [
          CourseLesson(
            id: 'l-2-1',
            title: '2.1 BLoC vs Riverpod in Enterprise Scale',
            duration: '25:10',
            videoUrl: 'https://www.youtube.com/watch?v=OXh5wX1Z8jM',
            isFreePreview: true,
            notes: 'Architecting reactive streams, event transformers, and debouncing.',
          ),
          CourseLesson(
            id: 'l-2-2',
            title: '2.2 Offline Caching & Sync with Hive & SQLite',
            duration: '28:05',
            videoUrl: 'https://www.youtube.com/watch?v=R9C5KM3K82U',
            isFreePreview: false,
            notes: 'Build a bulletproof optimistic UI sync engine with background synchronization.',
          ),
        ],
      ),
      CourseChapter(
        id: 'ch-3-testing',
        title: 'Chapter 3: Automated Testing & CI/CD',
        description: 'Unit testing usecases, mocking repositories, and widget testing.',
        lessons: [
          CourseLesson(
            id: 'l-3-1',
            title: '3.1 Unit Testing Usecases with Mockito & Mocktail',
            duration: '18:45',
            videoUrl: 'https://www.youtube.com/watch?v=wE7khGHVkYY',
            isFreePreview: false,
            notes: 'Write clean, test-driven tests that run in milliseconds.',
          ),
        ],
      ),
    ],
  ),

  /// SOFTWARE COURSE #2: Web Development with Dart & Jaspr
  Course(
    id: 'dart-jaspr-web-mastery',
    title: 'Modern Web Development with Dart & Jaspr',
    subtitle: 'Ultra-Fast, SEO-Optimized Web Apps without JS Bloat',
    description:
        'Learn how to leverage your Dart skills to build high-performance, full-stack and static websites using Jaspr. Covers routing, server-side rendering, and responsive design systems.',
    category: 'software',
    categoryLabel: 'Web & Dart',
    level: 'All Levels',
    duration: '8 Modules • 8 Hours Video',
    badge: 'Trending',
    topics: [
      'Jaspr Core Concepts & Component Tree',
      'Static Site Generation & Client Hydration',
      'Type-safe CSS in Dart & Animations',
      'Deploying to GitHub Pages & Cloud Providers',
    ],
    features: [
      'Full portfolio & web app projects',
      'Performance benchmarking vs React/Vue',
      'Downloadable code snippets',
    ],
    ctaText: 'Explore Web Course & Lectures',
    icon: '⚡',
    introVideoUrl: 'https://www.youtube.com/watch?v=OXh5wX1Z8jM',
    chapters: [
      CourseChapter(
        id: 'jaspr-ch-1',
        title: 'Chapter 1: Getting Started with Jaspr',
        description: 'Set up Jaspr CLI, build first static components, and understand SSR hydration.',
        lessons: [
          CourseLesson(
            id: 'jl-1-1',
            title: '1.1 The Dart on the Web Landscape & Jaspr Intro',
            duration: '15:20',
            videoUrl: 'https://www.youtube.com/watch?v=OXh5wX1Z8jM',
            isFreePreview: true,
          ),
          CourseLesson(
            id: 'jl-1-2',
            title: '1.2 Components, DOM Elements & Type-Safe CSS',
            duration: '20:10',
            videoUrl: 'https://www.youtube.com/watch?v=76vA9kI1w78',
            isFreePreview: true,
          ),
        ],
      ),
    ],
  ),

  /// SOFTWARE RESOURCE #3: Production Flutter Starter Kit
  Course(
    id: 'flutter-production-ui-kit',
    title: 'Production Flutter Starter Kit & Design Tokens',
    subtitle: 'Boilerplate Architecture with Auth, Theming & Navigation',
    description:
        'A free, open-source production foundation for your next Flutter project. Pre-configured with dependency injection, dynamic theme engine, responsive layout breakpoints, and clean folder structures.',
    category: 'software',
    categoryLabel: 'Free Resource',
    level: 'All Levels',
    duration: 'Instant GitHub Access',
    badge: 'Free Starter Kit',
    isFree: true,
    topics: [
      'Clean Folder Structure & Feature Modules',
      'Theme & Color Token Management',
      'GoRouter / AutoRoute Setup with Guards',
      'Pre-built Custom Widgets & Modals',
    ],
    features: [
      '100% Free & Open Source',
      'Save 40+ hours on every new project',
      'Strict linter and code quality rules',
    ],
    ctaText: 'Download & Watch Setup Guide',
    icon: '📦',
    introVideoUrl: 'https://www.youtube.com/watch?v=1xipg02Wu8s',
    chapters: [
      CourseChapter(
        id: 'kit-ch-1',
        title: 'Chapter 1: Starter Kit Walkthrough',
        description: 'Tour the architecture, run scripts, and configure theme tokens.',
        lessons: [
          CourseLesson(
            id: 'kl-1-1',
            title: '1.1 Project Structure & DI Configuration',
            duration: '11:15',
            videoUrl: 'https://www.youtube.com/watch?v=1xipg02Wu8s',
            isFreePreview: true,
          ),
        ],
      ),
    ],
  ),

  /// ENGINEERING COURSE #1: E&I Inspection & QA/QC Masterclass
  Course(
    id: 'ei-inspection-qaqc-masterclass',
    title: 'E&I Inspection & QA/QC Engineering Masterclass',
    subtitle: 'From P&ID & Loop Drawings to Site ITRs and MDR Handover',
    description:
        'The definitive practical training for engineers and inspectors entering the oil & gas and industrial EPC sectors. Master cable tray inspection, impulse piping, smart transmitter calibration, and MDR dossier compilation.',
    category: 'engineering',
    categoryLabel: 'E&I QA/QC',
    level: 'Professional Engineers & Inspectors',
    duration: '10 Comprehensive Modules',
    badge: 'Field Masterclass',
    topics: [
      'P&ID, Hook-ups & Schematic Interpretation',
      'Cable Pulling, Glanding & Termination Audits',
      'HART Smart Transmitter Calibration & Loop Checks',
      'ITR Execution & Final MDR Turnover Dossiers',
    ],
    features: [
      'Based on real EPC refinery specifications',
      'Includes real ITR forms and checklists',
      'Certificate of Professional Completion',
    ],
    ctaText: 'View Syllabus & Watch Lecture',
    icon: '🛠️',
    introVideoUrl: 'https://drive.google.com/file/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/preview',
    chapters: [
      CourseChapter(
        id: 'ei-ch-1',
        title: 'Chapter 1: Engineering Drawings & Field P&IDs',
        description: 'Read and interpret industrial EPC engineering drawings and instrument loops.',
        lessons: [
          CourseLesson(
            id: 'eil-1-1',
            title: '1.1 Interpreting P&ID Instrumentation Symbols & Tagging',
            duration: '21:00',
            videoUrl: 'https://drive.google.com/file/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/preview',
            isFreePreview: true,
            notes: 'Field walkthrough of process lines, control valves, and transmitter symbols.',
          ),
          CourseLesson(
            id: 'eil-1-2',
            title: '1.2 Loop Diagrams & Junction Box Terminal Schedules',
            duration: '18:45',
            videoUrl: 'https://www.youtube.com/watch?v=8q3H-7F5z3k',
            isFreePreview: false,
          ),
        ],
      ),
      CourseChapter(
        id: 'ei-ch-2',
        title: 'Chapter 2: Site Inspection & Quality Records (ITR / MDR)',
        description: 'Executing inspection test records and assembling final mechanical completion dossiers.',
        lessons: [
          CourseLesson(
            id: 'eil-2-1',
            title: '2.1 Cable Tray, Pulling & Glanding Quality Verification',
            duration: '26:30',
            videoUrl: 'https://www.youtube.com/watch?v=0k5G6FmP1yU',
            isFreePreview: true,
          ),
          CourseLesson(
            id: 'eil-2-2',
            title: '2.2 Loop Checking, Calibration & Punchlist Management',
            duration: '31:10',
            videoUrl: 'https://www.youtube.com/watch?v=hZ7j7J0L9xY',
            isFreePreview: false,
          ),
        ],
      ),
    ],
  ),

  /// ENGINEERING COURSE #2: Hazardous Area ATEX / IECEx Practical Guide
  Course(
    id: 'atex-hazardous-areas-guide',
    title: 'Hazardous Area (ATEX / IECEx) Practical Field Guide',
    subtitle: 'Field Inspection Protocols for Ex-d, Ex-e, Ex-i & Ex-n Installations',
    description:
        'Master the critical safety standards of IEC 60079-14 and 60079-17. Learn step-by-step verification procedures for flamepaths, barrier glands, intrinsically safe calculation sheets, and hazardous area tagging.',
    category: 'engineering',
    categoryLabel: 'Ex Protection',
    level: 'Engineers & Certified Inspectors',
    duration: '6 In-Depth Modules',
    badge: 'Safety Certified',
    topics: [
      'Zone 0, 1, 2 & Dust Zone Classification',
      'Ex-d Flameproof & Ex-e Increased Safety Checks',
      'Ex-i Intrinsic Safety Barrier Verification',
      'Cable Gland Selection (Barrier vs Standard)',
    ],
    features: [
      'Comprehensive field reference cheat-sheets',
      'Practical failure modes & audit checklists',
      'Case studies from refinery & offshore rigs',
    ],
    ctaText: 'Explore Hazardous Area Curriculum',
    icon: '⚡',
    introVideoUrl: 'https://www.youtube.com/watch?v=8q3H-7F5z3k',
    chapters: [
      CourseChapter(
        id: 'atex-ch-1',
        title: 'Chapter 1: Hazardous Area Fundamentals',
        description: 'Gas groups, temperature classes, and equipment protection levels (EPL).',
        lessons: [
          CourseLesson(
            id: 'atex-1-1',
            title: '1.1 Classification of Hazardous Areas (IEC 60079-10)',
            duration: '24:00',
            videoUrl: 'https://www.youtube.com/watch?v=8q3H-7F5z3k',
            isFreePreview: true,
          ),
        ],
      ),
    ],
  ),

  /// ENGINEERING RESOURCE #3: QA/QC Inspection ITR Pack & MDR Checklist
  Course(
    id: 'ei-itr-mdr-documentation-pack',
    title: 'EPC ITR Pack & MDR Turnover Checklist',
    subtitle: 'Production-Ready Excel & Word Inspection Templates',
    description:
        'Download ready-to-use Inspection Test Record (ITR) templates covering cable continuity, insulation resistance (megger), loop checks, instrument calibration, and complete MDR turnover table of contents.',
    category: 'engineering',
    categoryLabel: 'Inspection Toolkit',
    level: 'All Levels',
    duration: 'Instant Download Kit',
    badge: 'Toolkit & Templates',
    isFree: true,
    topics: [
      'Megger & Continuity Testing Sheets',
      'Instrument Calibration Test Sheets',
      'Inspection & Test Plan (ITP) Boilerplate',
      'Punch List & Non-Conformance Report (NCR) Forms',
    ],
    features: [
      'Over 25+ editable field templates',
      'Adheres to major EPC contractor standards',
      'Instant access via Google Drive / Direct download',
    ],
    ctaText: 'Download Free Inspection Pack',
    icon: '📋',
    introVideoUrl: 'https://drive.google.com/file/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/preview',
    chapters: [
      CourseChapter(
        id: 'pack-ch-1',
        title: 'Chapter 1: Template Orientation & Walkthrough',
        description: 'How to customize the ITR forms for project specifications.',
        lessons: [
          CourseLesson(
            id: 'pack-1-1',
            title: '1.1 Walkthrough of Calibration & Megger Templates',
            duration: '14:20',
            videoUrl: 'https://drive.google.com/file/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/preview',
            isFreePreview: true,
          ),
        ],
      ),
    ],
  ),
];

List<Course> get softwareCourses =>
    coursesList.where((c) => c.category == 'software').toList();

List<Course> get engineeringCourses =>
    coursesList.where((c) => c.category == 'engineering').toList();

Course? getCourseById(String id) {
  try {
    return coursesList.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
}
