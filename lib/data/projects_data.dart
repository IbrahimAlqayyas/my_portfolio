import '../models/project.dart';

final List<Project> projectsList = [
  /// SOFTWARE #1: AI Dashboard & Analytics Suite
  Project(
    id: 'ai-analytics-suite',
    title: 'AI Dashboard & Analytics',
    subtitle: 'Real-time Data Visualization Platform',
    shortDescription:
        'High-performance analytics platform built with Jaspr & Dart for tracking real-time metrics and diagnostics.',
    fullDescription: '''
This project is an enterprise-level analytics dashboard designed to monitor and process real-time streams of metrics, user activities, and performance diagnostics. 

Built with modern web technologies and clean architecture, it features customizable widget dashboards, dark/light theme switching, and interactive charting capabilities.
''',
    coverImage: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Web / SaaS',
    category: 'software',
    tags: ['Jaspr', 'Dart', 'Web', 'Analytics', 'Tailwind'],
    clientOrScope: 'SaaS Platform / Web App',
    deliverables: [
      'Full-stack Dart & Jaspr architecture',
      'Real-time streaming charts and telemetry dashboards',
      'Production-grade responsive layout with zero build warnings',
    ],
    images: [
      'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?auto=format&fit=crop&w=1000&q=80',
    ],
    videos: [
      'https://www.w3schools.com/html/mov_bbb.mp4',
    ],
    gifs: [
      'https://media.giphy.com/media/3oKIPeEyWA0T143648/giphy.gif',
    ],
    demoUrl: 'https://example.com/demo1',
    githubUrl: 'https://github.com/example/ai-analytics',
  ),

  /// SOFTWARE #2: Fintech Mobile & Web Wallet
  Project(
    id: 'cross-platform-wallet',
    title: 'Fintech Mobile & Web Wallet',
    subtitle: 'Secure Multi-Asset Crypto & Fiat Wallet',
    shortDescription:
        'Cross-platform financial application built for fast, secure crypto transfers and multi-currency asset tracking.',
    fullDescription: '''
A modern digital wallet application featuring biometric authentication, instant peer-to-peer transfers, and multi-currency exchange rate tracking.

Key architectural features include clean state management, encrypted local storage, biometric security, and responsive UI scaling across desktop and mobile devices.
''',
    coverImage: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Mobile',
    category: 'software',
    tags: ['Flutter', 'Dart', 'Fintech', 'State Management'],
    clientOrScope: 'Fintech Startup MVP',
    deliverables: [
      'Multi-currency balance management and transactions',
      'Biometric authentication (FaceID & Fingerprint)',
      'Cross-platform codebase (iOS, Android & Web)',
    ],
    images: [
      'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&w=1000&q=80',
    ],
    videos: [
      'https://www.w3schools.com/html/mov_bbb.mp4',
    ],
    gifs: [
      'https://media.giphy.com/media/l41K3t5s5Vb5d03p6/giphy.gif',
    ],
    demoUrl: 'https://example.com/demo2',
    githubUrl: 'https://github.com/example/fintech-wallet',
  ),

  /// SOFTWARE #3: E-Commerce Mobile App
  Project(
    id: 'ecommerce-mobile-app',
    title: 'E-Commerce Mobile Application',
    subtitle: 'Seamless Shopping Experience for Mobile Users',
    shortDescription:
        'Full-featured mobile e-commerce platform with real-time product search, filtering, and checkout flows.',
    fullDescription: '''
A sleek, performant e-commerce mobile application crafted with Flutter and Dart. Features dynamic product grids, seamless cart state synchronization, filterable product catalogs, and integrated payment gateway flows.
''',
    coverImage: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Mobile',
    category: 'software',
    tags: ['Flutter Mobile', 'Dart', 'E-Commerce', 'UI/UX'],
    clientOrScope: 'Retail Brand Mobile App',
    deliverables: [
      'Interactive catalog with real-time category filtering',
      'Cart and checkout flow with stripe payment integration',
      'Push notification system for order tracking',
    ],
    images: [
      'https://images.unsplash.com/photo-1472851294608-062f824d29cc?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1000&q=80',
    ],
    videos: [
      'https://www.w3schools.com/html/mov_bbb.mp4',
    ],
    gifs: [
      'https://media.giphy.com/media/26tn33aiTi1jkl6H6/giphy.gif',
    ],
    demoUrl: 'https://example.com/demo3',
    githubUrl: 'https://github.com/example/ecommerce-app',
  ),

  /// SOFTWARE #4: The Intersection: Industrial Field Inspection App
  Project(
    id: 'fieldinspect-mobile-suite',
    title: 'FieldInspect — E&I Mobile Inspection Suite',
    subtitle: 'Offline-First Industrial QA/QC App (The Intersection)',
    shortDescription:
        'Digitalized inspection workflows: offline ITR checklist execution, Ex equipment tag scanning, and punch-list tracking for field engineers.',
    fullDescription: '''
The ultimate bridge between field engineering and modern software: an offline-first mobile application designed specifically for industrial E&I construction and inspection engineers.

Inspectors can scan field tags via QR/NFC, fill out inspection test records (ITRs), attach photographic punch-list evidence, and sync to central cloud MDR repositories when internet access is restored.
''',
    coverImage: 'https://images.unsplash.com/photo-1581092335397-9583fe92d232?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Mobile / Industrial',
    category: 'software',
    tags: ['Flutter', 'Offline Sync', 'ATEX / ITRs', 'Field QA/QC', 'Industrial Tech'],
    clientOrScope: 'Industrial Field Solution',
    deliverables: [
      'Offline SQLite / Hive storage for remote plant areas',
      'Direct ITR generation with digital technician sign-offs',
      'ATEX tag verification and photographic punch-list management',
    ],
    images: [
      'https://images.unsplash.com/photo-1581092335397-9583fe92d232?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=1000&q=80',
    ],
    videos: [
      'https://www.w3schools.com/html/mov_bbb.mp4',
    ],
    demoUrl: 'https://example.com/fieldinspect',
    githubUrl: 'https://github.com/example/fieldinspect-app',
  ),

  /// ENGINEERING #1: Oil & Gas Refinery E&I QA/QC & ITR Verification
  Project(
    id: 'refinery-turnaround-inspection',
    title: 'Refinery E&I Turnaround & QA/QC Audit',
    subtitle: 'Comprehensive Inspection & MDR Verification Package',
    shortDescription:
        'Technical QA/QC auditing, ITR certification packages, and pre-commissioning verification for critical refinery units.',
    fullDescription: '''
Comprehensive QA/QC engineering inspection and certification audit conducted for a major plant turnaround. 

Scope included inspection of cable tray integrity, glanding and terminations, instrument impulse piping, junction boxes, and pre-commissioning loop checks. Audited and assembled the complete Manufacturer Data Report (MDR) ensuring 100% compliance with international standards.
''',
    coverImage: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Oil & Gas',
    category: 'engineering',
    tags: ['E&I QA/QC', 'ITR Verification', 'MDR Dossier', 'IEC Standards', 'Commissioning'],
    clientOrScope: 'Downstream Refining / EPC Turnaround',
    deliverables: [
      'Inspection of over 1,200 instrument and electrical tags',
      'Zero non-conformance closure on final MDR handover package',
      'Clearance of pre-commissioning punch lists ahead of schedule',
    ],
    images: [
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1504307651254-35680f356dfd?auto=format&fit=crop&w=1000&q=80',
    ],
  ),

  /// ENGINEERING #2: Hazardous Area ATEX/IECEx Audit
  Project(
    id: 'atex-hazardous-area-audit',
    title: 'Hazardous Area (ATEX / IECEx) Inspection',
    subtitle: 'Ex-d, Ex-e, Ex-i Compliance Verification & Dossier Handover',
    shortDescription:
        'Rigorous explosion-proof compliance audits, barrier gland verifications, and hazardous equipment registers for gas processing facilities.',
    fullDescription: '''
Critical inspection and compliance audit across Zone 1 and Zone 2 gas processing facilities. 

Conducted detailed inspection of explosion-proof enclosures (Ex-d), increased safety terminals (Ex-e), and intrinsically safe loops (Ex-i). Established a centralized Ex equipment register with baseline inspection sheets, ensuring adherence to IEC 60079 series standards and site safety mandates.
''',
    coverImage: 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Hazardous Areas',
    category: 'engineering',
    tags: ['ATEX', 'IECEx', 'Ex-d / Ex-e / Ex-i', 'Loop Checking', 'Field Safety'],
    clientOrScope: 'Gas Processing Facility',
    deliverables: [
      'Complete Ex Equipment Inspection Register (IEC 60079-17)',
      'Detailed verification of flamepaths, sealing fittings, and IS barriers',
      'Client risk mitigation report and remediation action plan',
    ],
    images: [
      'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1581092580497-e0d23cbdf1dc?auto=format&fit=crop&w=1000&q=80',
    ],
  ),

  /// ENGINEERING #3: Substation & MCC Commissioning Documentation
  Project(
    id: 'substation-mcc-commissioning',
    title: 'Substation & MCC Commissioning Dossier',
    subtitle: 'Switchgear Testing & Protection Coordination Handover',
    shortDescription:
        'Full electrical testing dossier: insulation resistance, relay settings, CT/VT checks, and handover registers for primary substations.',
    fullDescription: '''
Turnkey commissioning documentation management and verification for 11kV/415V substations and Motor Control Centers (MCC).

Supervised and documented primary and secondary injection tests, transformer winding tests, earth pit resistance audits, and protection relay trip checks. Delivered the consolidated commissioning test dossiers accepted by client QA/QC authorities without reservation.
''',
    coverImage: 'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Electrical Power',
    category: 'engineering',
    tags: ['MCC', 'Switchgear', 'Insulation Resistance', 'Relay Testing', 'Handover'],
    clientOrScope: 'Industrial Substation & Power Distribution',
    deliverables: [
      'Complete testing dossier for 48 MCC feeder compartments',
      'Earth grid continuity & resistance test compliance sheets',
      'Comprehensive as-built markup and handover clearance',
    ],
    images: [
      'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1508873696983-2df5293cb32f?auto=format&fit=crop&w=1000&q=80',
    ],
  ),

  /// ENGINEERING #4: Smart Calibration & Cable Schedule Framework
  Project(
    id: 'calibration-systems-framework',
    title: 'Calibration & Cable Schedule Quality System',
    subtitle: 'Standardized Quality Registers for Industrial EPC Projects',
    shortDescription:
        'Development of standardized instrument calibration certificates, automated cable pulling registers, and punch-list trackers.',
    fullDescription: '''
Designed and rolled out an engineering documentation and quality control framework for EPC field teams. 

Includes standardized calibration protocols for smart transmitters (HART / Foundation Fieldbus), control valve stroke checks, and automated cable pulling & termination trackers. Significantly reduced turnaround time for ITR package reviews by 40%.
''',
    coverImage: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Instrumentation',
    category: 'engineering',
    tags: ['Instrumentation', 'Calibration Registers', 'Cable Schedules', 'QA/QC Protocols'],
    clientOrScope: 'EPC Contracting & Quality Management',
    deliverables: [
      'Standardized calibration certificate templates with uncertainty limits',
      'Automated cable schedule and drum allocation spreadsheet engine',
      '40% reduction in ITR submission rejection rates',
    ],
    images: [
      'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=1000&q=80',
      'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=1000&q=80',
    ],
  ),
];

/// Shared helper lists
List<Project> get softwareProjects =>
    projectsList.where((p) => p.category == 'software').toList();

List<Project> get engineeringProjects =>
    projectsList.where((p) => p.category == 'engineering').toList();

Project? getProjectById(String id) {
  try {
    return projectsList.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}
