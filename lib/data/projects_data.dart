import '../models/project.dart';

final List<Project> projectsList = [
  Project(
    id: 'ai-analytics-suite',
    title: 'AI Dashboard & Analytics',
    subtitle: 'Real-time Data Visualization Platform',
    shortDescription: 'High-performance analytics platform built with Jaspr & Dart for tracking real-time metrics.',
    fullDescription: '''
This project is an enterprise-level analytics dashboard designed to monitor and process real-time streams of metrics, user activities, and performance diagnostics. 

Built with modern web technologies and clean architecture, it features customizable widget dashboards, dark/light theme switching, and interactive charting capabilities.
''',
    coverImage: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Web',
    tags: ['Jaspr', 'Dart', 'Web', 'Analytics', 'Tailwind'],
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
  Project(
    id: 'cross-platform-wallet',
    title: 'Fintech Mobile & Web Wallet',
    subtitle: 'Secure Multi-Asset Crypto & Fiat Wallet',
    shortDescription:
        'Cross-platform financial application built for fast, secure crypto transfers and asset tracking.',
    fullDescription: '''
A modern digital wallet application featuring biometric authentication, instant peer-to-peer transfers, and multi-currency exchange rate tracking.

Key architectural features include clean state management, encrypted local storage, biometric security, and responsive UI scaling across desktop and mobile browsers.
''',
    coverImage: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Mobile',
    tags: ['Flutter', 'Dart', 'Fintech', 'State Management'],
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
  Project(
    id: 'ecommerce-mobile-app',
    title: 'E-Commerce Mobile Application',
    subtitle: 'Seamless Shopping Experience for Mobile Users',
    shortDescription: 'Full-featured mobile e-commerce platform with real-time product search and secure checkout.',
    fullDescription: '''
A sleek, performant e-commerce mobile application crafted with Flutter and Dart. Features dynamic product grids, seamless cart state synchronization, filterable product catalogs, and integrated payment gateway flows.
''',
    coverImage: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?auto=format&fit=crop&w=800&q=80',
    mainTag: 'Mobile',
    tags: ['Flutter Mobile', 'Dart', 'E-Commerce', 'UI/UX'],
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
];

Project? getProjectById(String id) {
  try {
    return projectsList.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}
