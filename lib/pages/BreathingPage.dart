import 'dart:async';
import 'package:flutter/material.dart';

// ── Breathing mode definition ──────────────────────────────────────────────
class BreathingMode {
  final String name;
  final String label;
  final String pattern;
  final int inhaleSec;
  final int holdSec;
  final int exhaleSec;

  const BreathingMode({
    required this.name,
    required this.label,
    required this.pattern,
    required this.inhaleSec,
    required this.holdSec,
    required this.exhaleSec,
  });
}

// ── Available modes ────────────────────────────────────────────────────────
const List<BreathingMode> modes = [
  BreathingMode(name: 'calm',  label: 'Ramus',   pattern: '4 · 0 · 4', inhaleSec: 4, holdSec: 0, exhaleSec: 4),
  BreathingMode(name: '478',   label: '4-7-8',   pattern: '4 · 7 · 8', inhaleSec: 4, holdSec: 7, exhaleSec: 8),
  BreathingMode(name: '444',   label: '4-4-4',  pattern: '4 · 4 · 4', inhaleSec: 4, holdSec: 4, exhaleSec: 4),
  BreathingMode(name: 'quick', label: 'Greitas', pattern: '2 · 2 · 6', inhaleSec: 2, holdSec: 2, exhaleSec: 6),
];

const List<int> durationOptions = [1, 2, 5, 10];

const _purple     = Color.fromRGBO(167, 139, 250, 1);
const _purpleDark = Color.fromRGBO(100, 70, 180, 1);
const _btnDark    = Color.fromRGBO(55, 50, 75, 1);
const _bg         = Color(0xFFF8F5FF);
const _cardBg     = Color(0xFFFFFFFF);
const _cardBorder = Color(0xFFE8E0F8);

// ── Page ───────────────────────────────────────────────────────────────────
class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with TickerProviderStateMixin {

  BreathingMode _mode = modes[0];
  int _durationMinutes = 2;

  bool _running  = false;
  bool _finished = false;

  late int _secondsLeft;

  String _phaseLabel = '';
  int _phaseSec  = 0;
  int _phaseMax  = 1;

  Timer? _timer;

  late AnimationController _circleAnim;
  late Animation<double>   _circleScaleAnim;

  late AnimationController _pulseAnim;
  late Animation<double>   _pulseScaleAnim;

  int _phaseIndex   = 0;
  int _phaseSecLeft = 0;

  @override
  void initState() {
    super.initState();
    _secondsLeft = _durationMinutes * 60;

    _circleAnim = AnimationController(vsync: this, duration: Duration.zero);
    _circleScaleAnim = Tween<double>(begin: 0.45, end: 1.0).animate(
      CurvedAnimation(parent: _circleAnim, curve: Curves.easeInOut),
    );

    _pulseAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseScaleAnim = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseAnim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _circleAnim.dispose();
    _pulseAnim.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _running      = true;
      _finished     = false;
      _secondsLeft  = _durationMinutes * 60;
      _phaseIndex   = 0;
      _phaseSecLeft = _mode.inhaleSec;
      _phaseLabel   = 'Įkvėpk';
      _phaseMax     = _mode.inhaleSec;
      _phaseSec     = _mode.inhaleSec;
    });
    _animateInhale();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _secondsLeft--;
        _phaseSecLeft--;
        _phaseSec = _phaseSecLeft;
        if (_phaseSecLeft <= 0) _nextPhase();
        if (_secondsLeft  <= 0) _end();
      });
    });
  }

  void _nextPhase() {
    if (_mode.holdSec == 0 && _phaseIndex == 0) {
      _phaseIndex = 2;
    } else {
      _phaseIndex = (_phaseIndex + 1) % 3;
    }
    switch (_phaseIndex) {
      case 0:
        _phaseSecLeft = _mode.inhaleSec;
        _phaseLabel   = 'Įkvėpk';
        _phaseMax     = _mode.inhaleSec;
        _animateInhale();
        break;
      case 1:
        _phaseSecLeft = _mode.holdSec;
        _phaseLabel   = 'Sulaikyk';
        _phaseMax     = _mode.holdSec;
        break;
      case 2:
        _phaseSecLeft = _mode.exhaleSec;
        _phaseLabel   = 'Iškvėpk';
        _phaseMax     = _mode.exhaleSec;
        _animateExhale();
        break;
    }
    _phaseSec = _phaseSecLeft;
  }

  void _animateInhale() {
    _circleAnim.duration = Duration(seconds: _mode.inhaleSec);
    _circleAnim.forward(from: _circleAnim.value);
  }

  void _animateExhale() {
    _circleAnim.duration = Duration(seconds: _mode.exhaleSec);
    _circleAnim.reverse(from: _circleAnim.value);
  }

  void _stop() {
    _timer?.cancel();
    _circleAnim.stop();
    _circleAnim.value = 0;
    setState(() {
      _running    = false;
      _phaseLabel = '';
    });
  }

  void _end() {
    _timer?.cancel();
    _circleAnim.stop();
    setState(() {
      _running    = false;
      _finished   = true;
      _phaseLabel = 'Puiku!';
    });
  }

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return m > 0 ? '$m:${s.toString().padLeft(2, '0')}' : '${s}s';
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _purple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () { _stop(); Navigator.pop(context); },
        ),
        title: const Text(
          'Kvėpavimas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_running && !_finished) ...[
              _modeSelector(),
              const SizedBox(height: 20),
              _durationSelector(),
              const SizedBox(height: 40),
              // Start button shown right after duration, no circle yet
              _startButton(),
            ],
            if (_running) ...[
              _breathingCircle(),
              const SizedBox(height: 28),
              _runningControls(),
            ],
            if (_finished) ...[
              const SizedBox(height: 20),
              _finishedSection(),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ── Mode selector ──────────────────────────────────────────────────────
  Widget _modeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Režimas',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: modes.map((m) {
              final selected = m == _mode;
              return GestureDetector(
                onTap: () => setState(() => _mode = m),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? _purple : _btnDark,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        m.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        m.pattern,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Įkvėpimas · Sulaikymas · Iškvėpimas (sekundėmis)',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
        ),
      ],
    );
  }

  // ── Duration selector ──────────────────────────────────────────────────
  Widget _durationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trukmė',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: durationOptions.map((t) {
            final selected = t == _durationMinutes;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  _durationMinutes = t;
                  _secondsLeft = t * 60;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: selected ? _purple : _btnDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$t',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'min',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Start button (shown before session) ───────────────────────────────
  Widget _startButton() {
    return Center(
      child: GestureDetector(
        onTap: _start,
        child: Container(
          width: 200,
          height: 52,
          decoration: BoxDecoration(
            color: _purple,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: _purple.withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Pradėti',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Breathing circle (shown only while running) ────────────────────────
  Widget _breathingCircle() {
    return SizedBox(
      height: 280,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _circleScaleAnim,
              builder: (_, __) => ScaleTransition(
                scale: _pulseScaleAnim,
                child: Container(
                  width:  240 * _circleScaleAnim.value + 30,
                  height: 240 * _circleScaleAnim.value + 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _purple.withOpacity(0.10),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _circleScaleAnim,
              builder: (_, __) {
                final size = 90.0 + 150.0 * _circleScaleAnim.value;
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _purple,
                    boxShadow: [
                      BoxShadow(
                        color: _purple.withOpacity(0.35),
                        blurRadius: 28,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                );
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _phaseLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_phaseSec > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '$_phaseSec',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Running controls ───────────────────────────────────────────────────
  Widget _runningControls() {
    return Column(
      children: [
        Center(
          child: Text(
            _formatTime(_secondsLeft),
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: _phaseMax > 0 ? (_phaseSec / _phaseMax) : 0,
            minHeight: 4,
            backgroundColor: _purple.withOpacity(0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(_purple),
          ),
        ),
        const SizedBox(height: 28),
        Center(
          child: GestureDetector(
            onTap: _stop,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _btnDark,
              ),
              child: const Icon(Icons.stop_rounded, color: Colors.white, size: 26),
            ),
          ),
        ),
      ],
    );
  }

  // ── Finished screen ────────────────────────────────────────────────────
  Widget _finishedSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, color: _purple, size: 46),
          const SizedBox(height: 10),
          const Text(
            'Sesija baigta!',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Atlikote $_durationMinutes min ${_mode.label.toLowerCase()} kvėpavimo praktiką',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => setState(() {
              _finished    = false;
              _phaseLabel  = '';
              _secondsLeft = _durationMinutes * 60;
              _circleAnim.value = 0;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 13),
              decoration: BoxDecoration(
                color: _purple,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Dar kartą',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}