import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class CosmicCanvas extends StatelessComponent {
  const CosmicCanvas({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Component.element(tag: 'canvas', id: 'cosmic-canvas'),
      script(
        content: r'''
(function () {

  if (window.__cosmicCanvasInitialized) return;
  window.__cosmicCanvasInitialized = true;

  function initCosmicCanvas() {

    const canvas = document.getElementById('cosmic-canvas');
    window.myCanvas = canvas;

setInterval(() => {
  const current = document.getElementById('cosmic-canvas');
}, 1000);

    if (!canvas) return;

    const ctx = canvas.getContext('2d', {
      alpha: true,
      desynchronized: true
    });

    let width = 0;
    let height = 0;
    let dpr = 1;


    const colors = [
      '#fbc51a',
      '#ff577b',
      '#6ef27b',
      '#38bdf8',
      '#ffffff'
    ];

    const particles = [];
    const stardust = [];


function updateParticleCount() {

  const target = Math.min(
    Math.floor(width * height / 2800),
    350
  );

  while (particles.length < target) {

    particles.push({

      x: Math.random() * width,
      y: Math.random() * height,

      vx: (Math.random() - 0.5) * 0.3,
      vy: (Math.random() - 0.5) * 0.3,

      radius: Math.random() * 0.8 + 0.6,

      color: colors[Math.floor(Math.random() * colors.length)],

      alpha: Math.random() * 0.75 + 0.25,

      pulse: Math.random() * Math.PI * 2

    });

  }

  while (particles.length > target) {
    particles.pop();
  }

}

function resizeCanvas() {

 const oldWidth = width || window.innerWidth;
const oldHeight = height || window.innerHeight;

width = window.innerWidth;
height = window.innerHeight;
const scaleX = width / oldWidth;
const scaleY = height / oldHeight;

for (const p of particles) {
  p.x *= scaleX;
  p.y *= scaleY;
}

for (const s of stardust) {
  s.x *= scaleX;
  s.y *= scaleY;
}

  canvas.style.width = width + "px";
  canvas.style.height = height + "px";

  canvas.width = width * dpr;
  canvas.height = height * dpr;

  ctx.setTransform(1, 0, 0, 1, 0, 0);
  ctx.scale(dpr, dpr);
  updateParticleCount();
}

    resizeCanvas();
    updateParticleCount();

requestAnimationFrame(() => {
    resizeCanvas();
    updateParticleCount();

    requestAnimationFrame(() => {
        resizeCanvas();
        updateParticleCount();

        setTimeout(resizeCanvas, 50);
        setTimeout(resizeCanvas, 150);
        setTimeout(resizeCanvas, 300);
    });
});
    window.addEventListener('resize', resizeCanvas);

    const mouse = {
      x: -1000,
      y: -1000,
      active: false
    };

    window.addEventListener('mousemove', (e) => {
      mouse.x = e.clientX;
      mouse.y = e.clientY;
      mouse.active = true;
      createStardust(e.clientX, e.clientY);
    });

    window.addEventListener('mouseleave', () => {
      mouse.active = false;
    });


    function createStardust(x, y) {

      for (let i = 0; i < 4; i++) {

        stardust.push({

          x: x + (Math.random() - 0.5) * 10,
          y: y + (Math.random() - 0.5) * 10,

          vx: (Math.random() - 0.5),

          vy: (Math.random() - 0.5) - 0.3,

          radius: Math.random() * 0.9 + 0.5,

          color: colors[Math.floor(Math.random() * colors.length)],

          life: 1,

          decay: Math.random() * 0.035 + 0.025

        });

      }

    }

function ensureCanvasSize() {

    if (
        canvas.width !== width ||
        canvas.height !== height ||
        canvas.style.width !== width + "px" ||
        canvas.style.height !== height + "px"
    ) {

        canvas.width = width;
        canvas.height = height;

        canvas.style.width = width + "px";
        canvas.style.height = height + "px";

    }
}

    function animate() {

ensureCanvasSize();

      ctx.clearRect(0, 0, width, height);

      for (const p of particles) {

        p.x += p.vx;
        p.y += p.vy;

        if (p.x < 0) p.x = width;
        if (p.x > width) p.x = 0;

        if (p.y < 0) p.y = height;
        if (p.y > height) p.y = 0;

        p.pulse += 0.03;

        const size =
            p.radius +
            Math.sin(p.pulse) * 0.15;

        const dx = mouse.x - p.x;
        const dy = mouse.y - p.y;

        const dist = Math.sqrt(dx * dx + dy * dy);

        const maxDist = 130;

        if (mouse.active && dist > 0 && dist < maxDist) {

          const force = 1 - dist / maxDist;

          p.x += (dx / dist) * force;
          p.y += (dy / dist) * force;

          ctx.beginPath();
          ctx.moveTo(p.x, p.y);
          ctx.lineTo(mouse.x, mouse.y);

          ctx.strokeStyle = p.color;
          ctx.globalAlpha = force * 0.3;
          ctx.lineWidth = 0.6;
          ctx.stroke();
          ctx.globalAlpha = 1;
        }

        ctx.beginPath();
        ctx.arc(
          p.x,
          p.y,
          size,
          0,
          Math.PI * 2
        );

        ctx.fillStyle = p.color;
        ctx.globalAlpha = p.alpha;
        ctx.fill();
        ctx.globalAlpha = 1;

      }

      for (let i = stardust.length - 1; i >= 0; i--) {

        const s = stardust[i];

        s.x += s.vx;
        s.y += s.vy;

        s.life -= s.decay;

        if (s.life <= 0) {

          stardust.splice(i, 1);
          continue;

        }

        ctx.beginPath();

        ctx.arc(
          s.x,
          s.y,
          s.radius * s.life,
          0,
          Math.PI * 2
        );

        ctx.fillStyle = s.color;
        ctx.globalAlpha = s.life * 0.75;
        ctx.fill();
        ctx.globalAlpha = 1;

      }

      requestAnimationFrame(animate);

    }

    animate();

  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCosmicCanvas);
  } else {
    initCosmicCanvas();
  }

})();
''',
      ),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('#cosmic-canvas').styles(
      position: Position.fixed(top: 0.px, left: 0.px),
      width: 100.percent,
      height: 100.percent,
      pointerEvents: PointerEvents.none,
      zIndex: ZIndex(0),
    ),
  ];
}
