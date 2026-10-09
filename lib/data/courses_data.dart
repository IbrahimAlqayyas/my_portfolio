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
    ctaText: 'Explore Syllabus & Enroll',
    icon: '📱',
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
    ctaText: 'View Web Course',
    icon: '⚡',
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
    ctaText: 'Download Free Starter Kit',
    icon: '📦',
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
    ctaText: 'View Syllabus & Enroll',
    icon: '🛠️',
  ),

  /// ENGINEERING COURSE #2: Hazardous Area ATEX / IECEx Practical Guide
  Course(
    id: 'atex-hazardous-areas-guide',
    title: 'Hazardous Area (ATEX / IECEx) Practical Field Guide',
    subtitle: 'Field Inspection Protocols for Ex-d, Ex-e, Ex-i & Ex-n Installations',
    description:
        'Master the critical safety standards of IEC 60079-14 and 60079-17. Learn step-by-step verification procedures for flamepaths, barrier glands, intrinsically safe calculation sheets, and hazardous area tagging.',
    category: 'engineering',
    categoryLabel: 'Hazardous Areas',
    level: 'Site Inspectors & QA/QC',
    duration: '6 Modules + Field Checklists',
    badge: 'Industrial Guide',
    topics: [
      'IEC 60079 Series Breakdown',
      'Flamepath Measurement & Enclosure Audits',
      'Intrinsically Safe (Ex-i) Parameters & Barriers',
      'Non-Conformance Punch-Listing & Rectification',
    ],
    features: [
      'Printable pocket inspection sheets',
      'Common field violation case studies',
      'Risk assessment & compliance templates',
    ],
    ctaText: 'Access Industrial Guide',
    icon: '⚡',
  ),

  /// ENGINEERING RESOURCE #3: Complete Quality Documentation & ITR Pack
  Course(
    id: 'ei-dossier-templates-pack',
    title: 'Complete E&I Documentation & ITR Quality Pack',
    subtitle: 'Ready-to-Use Registers, Calibration Sheets & Punch List Trackers',
    description:
        'A comprehensive digital toolkit of professional templates formatted for client submittal. Includes automated instrument calibration registers, cable pulling logs, and handover punch-list spreadsheets.',
    category: 'engineering',
    categoryLabel: 'Free Template Pack',
    level: 'All Field Engineers',
    duration: 'Instant Download (Excel & PDF)',
    badge: 'Free Template Pack',
    isFree: true,
    topics: [
      'Standardized ITR Templates (Electrical & Instrument)',
      'Smart Transmitter 5-Point Calibration Sheet',
      'Automated Cable Pulling & Drum Allocation Register',
      'Category A & B Punch List Management Engine',
    ],
    features: [
      '100% Free instant download',
      'Formulas and conditional formatting included',
      'ISO 9001 / EPC compliant format',
    ],
    ctaText: 'Download Free Quality Pack',
    icon: '📑',
  ),
];

/// Shared helper lists
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
