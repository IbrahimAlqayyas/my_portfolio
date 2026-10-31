import 'package:jaspr/dom.dart';

// Dark Mode Design System Tokens derived from ALQYAS Logo2
const backgroundColor = Color('#0f172a');
const surfaceColor = Color('#141820');
const surfaceBorder = Color('#282e3a');

/// Unified Glassmorphic Card & Panel Tokens
/// -------------------------------------------------------------
/// Modifying [cardBackground] here changes the card/container
/// background across the ENTIRE application in one single place.
const cardBackground = Color.rgba(16, 20, 26, 0.38); // Unified transparent card background with lowered blue
const cardBorder = Color.rgba(255, 255, 255, 0.08); // Unified translucent card border with neutral specular rim
const cardBackdropFilter = {
  'backdrop-filter': 'blur(1px)',
  '-webkit-backdrop-filter': 'blur(1px)',
};

// Primary Brand Colors (ALQYAS Logo2 Palette)
const primaryColor = Color('#fbc51a'); // Main Screen Brand Color: Warm Golden Yellow (Q)
const secondaryColor = Color('#ff577b'); // Secondary Brand Color: Coral Pink (AL)
const accentColor = Color('#ff577b'); // Accent Color: Coral Pink (AL)
const emeraldAccent = Color('#6ef27b'); // Neon Emerald Green (S)
const magentaAccent = Color('#ff56bb'); // Magenta Pink (Y & A2)
const blueAccent = Color('#38bdf8'); // Bright Sky Blue (Logo1)

const textColor = Color('#f8fafc');
const textMutedColor = Color('#94a3b8');
