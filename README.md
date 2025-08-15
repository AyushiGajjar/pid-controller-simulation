# pid-controller-simulation
What: MATLAB or Python simulation of a PID controller for speed or temperature control.  Why: PID is core to control engineering, and recruiters love seeing it.  Extra Touch: Add a GUI to change Kp, Ki, Kd and visualize the response.  Tech: MATLAB Simulink / Python (matplotlib).
# PID Controller Simulation & Tuning

A clean, educational project to **simulate and tune a PID controller** for standard first/second-order plants. Includes **Python (CLI + GUI)** and **MATLAB** implementations, plots, and performance metrics (rise time, settling time, overshoot).

![Status](https://img.shields.io/badge/status-active-success)
![Made with](https://img.shields.io/badge/Python-3.10+-blue)
![MATLAB](https://img.shields.io/badge/MATLAB-R2021a+-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features
- Parallel-form PID: `u = Kp*e + Ki*∫e dt + Kd*de/dt`
- Plants: **First-order** (τs+1) and **Second-order** (ωₙ, ζ)
- Step response plots + metrics (rise, settling, overshoot, steady-state error)
- **Python**:
  - Uses `python-control` if available; else **pure NumPy** fallback
  - Optional **Tkinter GUI** with real-time sliders
- **MATLAB**: ready-to-run scripts with configurable parameters

---

## 🧠 Why This Project?
PID control is foundational in **Instrumentation & Control**. This repo demonstrates:
- Model-based design
- Controller tuning intuition
- Reproducible simulations (Python/MATLAB)

Use screenshots in `docs/images/` to show your results.

---

## 🔧 Quickstart

### 1) Clone
```bash
git clone https://github.com/YOUR_USERNAME/pid-controller-simulation.git
cd pid-controller-simulation
