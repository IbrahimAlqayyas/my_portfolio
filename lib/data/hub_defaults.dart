import '../models/course_category.dart';
import '../models/hub_content.dart';
import '../models/metric_item.dart';
import '../models/service_item.dart';

final HubContent defaultSoftwareHubContent = HubContent(
  badge: '📱 Software Engineering & Mobile Track',
  title: 'Flutter & Web Software Engineering',
  subtitle: 'Crafting High-Performance Cross-Platform Apps with Flutter & Dart',
  bio:
      'With +6 years of software experience, I build robust, beautiful mobile and web applications. From clean architecture and reactive state management to seamless offline synchronization and snappy web rendering, I deliver production software that scales.',
  primaryBtnText: 'Hire for Mobile & Web Apps →',
  primaryBtnLink: '/contact',
  secondaryBtnText: 'View Apps & Code ↓',
  metrics: [
    MetricItem(value: '6+ Years', label: 'Software Engineering'),
    MetricItem(value: '100%', label: 'Dart & Flutter Specialization'),
    MetricItem(value: 'iOS & Android', label: 'Cross-Platform Deployments'),
    MetricItem(value: 'Clean Arch', label: 'Scalable Enterprise Patterns'),
  ],
  servicesTitle: 'Software Development Services',
  servicesSubtitle:
      'End-to-end technical solutions tailored for startups, businesses, and enterprise teams.',
  services: [
    ServiceItem(
      id: 'soft-service-1',
      icon: '📱',
      title: 'Custom Mobile Applications',
      description:
          'Native-speed iOS and Android applications developed from Figma/wireframes into maintainable Flutter codebases.',
      features: ['iOS & Android Stores', 'Offline-First Storage', 'Push Notifications & APIs'],
    ),
    ServiceItem(
      id: 'soft-service-2',
      icon: '⚡',
      title: 'Full-Stack Web & Jaspr Apps',
      description:
          'Lightning-fast web apps using Jaspr and modern Dart. Clean SSR, SEO optimization, and reactive front-ends.',
      features: ['Server-Side Rendering', 'Zero Bloat Architecture', 'High Lighthouse Scores'],
    ),
    ServiceItem(
      id: 'soft-service-3',
      icon: '🚀',
      title: 'Startup MVP Acceleration',
      description:
          'Rapid prototyping and MVP development for founders who need to validate their product with real users quickly.',
      features: ['Fast Time-to-Market', 'Payment Gateways', 'Scalable Architecture Base'],
    ),
    ServiceItem(
      id: 'soft-service-4',
      icon: '🛠️',
      title: 'Code Audit & Refactoring',
      description:
          'Transform legacy or sluggish codebases with Clean Architecture, Riverpod/Bloc state management, and strict testing.',
      features: ['Performance Optimization', 'Bug Hunting & Overflow Fixes', 'Unit & Widget Testing'],
    ),
  ],
  featuredProjectsTitle: 'Featured Software Projects',
  featuredProjectsSubtitle:
      'Production mobile applications, web platforms, and industrial mobile solutions.',
  featuredCoursesTitle: 'Software Courses & Developer Resources',
  featuredCoursesSubtitle:
      'Free starter kits, architecture masterclasses, and in-depth Dart tutorials.',
  toolingTitle: 'Core Technologies & Tooling',
  toolingSubtitle: 'My primary software development toolbox.',
  toolingList: [
    'Flutter',
    'Dart',
    'Jaspr',
    'Riverpod',
    'Bloc',
    'Firebase',
    'REST APIs',
    'GraphQL',
    'SQLite & Hive',
    'Git & GitHub Actions',
    'Figma to Code',
    'Clean Architecture',
  ],
  ctaTitle: 'Ready to build your next mobile or web application?',
  ctaDescription: 'Let’s turn your product vision into a clean, high-performance Flutter reality.',
  ctaBtnText: 'Start a Software Project →',
  ctaBtnLink: '/contact',
);

final HubContent defaultEngineeringHubContent = HubContent(
  badge: '⚡ Electrical & Instrumentation (E&I) Track',
  title: 'E&I Construction, Inspection & QA/QC',
  subtitle: 'Precision Quality Assurance & Regulatory Compliance for Industrial EPC Projects',
  bio:
      'Specialized in oil & gas, refinery, and power generation E&I QA/QC. Delivering rigorous inspection protocols, ATEX/IECEx hazardous area compliance, smart transmitter calibrations, and seamless Manufacturer Data Report (MDR) turnover dossiers.',
  primaryBtnText: 'Request Engineering Consultation →',
  primaryBtnLink: '/contact',
  secondaryBtnText: 'View Case Studies ↓',
  metrics: [
    MetricItem(value: 'IEC & ATEX', label: 'Compliance Standards'),
    MetricItem(value: '100%', label: 'ITR & MDR Verification'),
    MetricItem(value: 'Oil & Gas', label: 'Refinery & Plant Experience'),
    MetricItem(value: 'Zero NCR', label: 'Handover Excellence'),
  ],
  servicesTitle: 'E&I Engineering & Consulting Services',
  servicesSubtitle:
      'Comprehensive technical consulting and field verification for EPC contractors and plant operators.',
  services: [
    ServiceItem(
      id: 'eng-service-1',
      icon: '📋',
      title: 'ITR & MDR Dossier Audits',
      description:
          'End-to-end review of Inspection & Test Records (ITRs), calibration certs, and compilation of client handover dossiers (MDRs).',
      features: ['100% Document Verification', 'Pre-Commissioning Punch Lists', 'Client Acceptance Facilitation'],
    ),
    ServiceItem(
      id: 'eng-service-2',
      icon: '⚠️',
      title: 'Hazardous Area (ATEX) Audits',
      description:
          'Ex-d, Ex-e, Ex-i inspection of enclosures, barrier glands, and intrinsically safe loop calculations per IEC 60079 series.',
      features: ['Ex Equipment Register', 'IEC 60079-14 & 17 Compliance', 'Defect Remediation Guidance'],
    ),
    ServiceItem(
      id: 'eng-service-3',
      icon: '🔬',
      title: 'Calibration Systems & Registers',
      description:
          'Quality registers for HART and Fieldbus smart transmitters, control valves stroke tests, and primary electrical testing.',
      features: ['5-Point Calibration Logs', 'Uncertainty Verification', 'Test Equipment Certification Tracking'],
    ),
    ServiceItem(
      id: 'eng-service-4',
      icon: '🎓',
      title: 'Technical Training & Field QA/QC',
      description:
          'Hands-on training courses and field mentorship for junior engineers and QA/QC inspectors in modern installation standards.',
      features: ['Cable Glanding & Pulling Rules', 'Loop Checking Methodology', 'MDR Dossier Best Practices'],
    ),
  ],
  featuredProjectsTitle: 'E&I Engineering Case Studies',
  featuredProjectsSubtitle:
      'Documented inspection projects, hazardous area audits, and commissioning quality packages.',
  featuredCoursesTitle: 'E&I Training & Quality Documentation Packs',
  featuredCoursesSubtitle:
      'Field masterclasses, printable inspection sheets, and standardized Excel/PDF quality registers.',
  toolingTitle: 'Standards, Codes & Compliance Frameworks',
  toolingSubtitle: 'All engineering and inspection services strictly adhere to international codes.',
  toolingList: [
    'IEC 60079 (Hazardous Areas)',
    'ATEX Directive 2014/34/EU',
    'IECEx Certified Systems',
    'ISO 9001 Quality Management',
    'API 500 / API 505 Area Classification',
    'IEC 60364 Electrical Installations',
    'NFPA 70 (NEC Standards)',
    'ISA-5.1 Instrumentation Symbols',
  ],
  ctaTitle: 'Need E&I Consulting or QA/QC Audit for your Facility?',
  ctaDescription:
      'Whether preparing for an upcoming turnaround, resolving MDR punch lists, or certifying hazardous areas, let’s discuss your scope.',
  ctaBtnText: 'Schedule an Engineering Consultation →',
  ctaBtnLink: '/contact',
);

final List<CourseCategory> defaultCourseCategories = [
  CourseCategory(id: 'software', label: 'Software & Flutter', icon: '💻'),
  CourseCategory(id: 'engineering', label: 'E&I QA/QC', icon: '⚡'),
];
