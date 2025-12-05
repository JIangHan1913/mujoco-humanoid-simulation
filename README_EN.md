# MuJoCo Humanoid Robot Simulation Control

This project uses MuJoCo physics engine for humanoid robot simulation and real-time control via gamepad.

> **🎉 Ready to Use**: The program has integrated a pre-trained policy model (`.pt` file) for **Walker Taishan**, and can be run directly after configuration without additional training.

## 📺 Demo Video

Watch the demonstration video to see the robot in action:

**Bilibili**: [Watch Demo Video](https://www.bilibili.com/video/BV1jx2YBqEPD/)

## Core Features

The program includes **Walker Taishan** omnidirectional humanoid walking with the following features:
- ✅ **Omnidirectional Humanoid Walking**: Supports movement and rotation in all directions (forward, backward, left, right)
- ✅ **Stable Stair Climbing**: Can climb stairs at maximum speed, automatically adapting to step height
- ✅ **Disturbance Rejection**: Capable of resisting external disturbances, can be verified in disturbance test mode
- ✅ **Automatic Foot Position Alignment**: Automatically adjusts foot position to optimal posture when stopped

> **⚠️ Known Issues**: Due to limitations of the MuJoCo physics engine, the following phenomena may occur:
> - The foot may **sink into stairs** when first climbing steps (subsequent steps work normally)
> - **Slipping** may occur when standing still for extended periods
> 

## Table of Contents

- [Core Features](#core-features)
- [Features](#features)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
  - [Step 1: Calibrate Gamepad](#step-1-calibrate-gamepad)
  - [Step 2: Run Simulation](#step-2-run-simulation)
- [Gamepad Control Guide](#gamepad-control-guide)
  - [Joystick Control](#joystick-control)
  - [Button Control](#button-control)
  - [D-Pad Control](#d-pad-control)
- [Operating Modes](#operating-modes)
- [Configuration File](#configuration-file)
- [FAQ](#faq)

## Features

- ✅ **Pre-trained Model**: Integrated pre-trained Walker Taishan policy model, ready to use
- ✅ Real-time gamepad control of robot movement
- ✅ Three operating modes: Walking, Running, Disturbance Test
- ✅ Switchable camera tracking and visualization options
- ✅ Support for multiple gamepads (Logitech, Betop, etc.)
- ✅ Automatic gamepad center value calibration
- ✅ Support for robot state reset

## Requirements

- Python 3.7+
- MuJoCo
- PyTorch
- Pygame
- PyYAML
- NumPy

## Quick Start

### Basic Steps

1. **Connect Gamepad**: Insert the gamepad into your computer
2. **Configure Environment**: Open terminal and configure the environment (default reinforcement learning environment is sufficient)
3. **Run Program**: Execute the command to start simulation
   ```bash
   python deploy_mujoco_gamepad.py
   ```
4. **Enable Camera Tracking**: Press **Y button** on gamepad to enable camera tracking mode
5. **Control Robot**:
   - **Right Joystick**: Control xy linear velocity (forward/backward/left/right movement)
   - **Left Joystick**: Control yaw angular velocity (rotation)
   - **D-Pad (➡️⬅️⬆️⬇️)**: Control camera direction
   - **B Button**: Reset robot state

> **💡 Tip**: When using Logitech or Betop gamepads, you can run directly without calibration.

---

### Step 1: Calibrate Gamepad

> **💡 Tip**: If you are using a **Logitech** or **Betop** gamepad, the project already includes default calibration files. **You can skip the calibration step** and run the simulation directly. Only run the calibration script when using other brands or if the default calibration is inaccurate.

Before controlling the robot with other brand gamepads, **you need to calibrate the gamepad** to ensure correct joystick center values.

#### 1.1 Run Calibration Script

```bash
python calibrate_gamepad.py
```

#### 1.2 Select Gamepad Type

The program will prompt you to select a gamepad type:
- **1. Logitech** - Default option, Left joystick(0,1), Right joystick(2,3)
- **2. Betop** - Left joystick(0,1), Right joystick(3,4)
- **3. Other/Custom** - Manually specify axis mapping

#### 1.3 Calibrate Joystick Center Values

1. As prompted, move **all joysticks to center position** (apply no force)
2. Press any key to start sampling
3. The program will automatically sample 100 times and calculate center values

#### 1.4 Calibrate Button Mapping

Press the following buttons in sequence as prompted:
- **LB**: Mode switch button
- **X**: Toggle foot contact force display
- **Y**: Toggle pelvis tracking
- **B**: Reset robot state
- **A**: Toggle foot contact status display
- **RB**: Reserved button (optional)

> **Note**: If you don't want to calibrate a button, you can press Enter to skip.

#### 1.5 Test Calibration Results

After calibration is complete, you can optionally test the calibration results by moving joysticks and pressing buttons to view real-time values.

#### 1.6 Save Calibration File

Calibration results are automatically saved to corresponding JSON files:
- Logitech gamepad: `gamepad_calibration_logitech.json`
- Betop gamepad: `gamepad_calibration_betop.json`
- Custom gamepad: `gamepad_calibration_custom.json`

### Step 2: Run Simulation

Run the simulation program:

```bash
# Use default config file e2_21dof.yaml
python deploy_mujoco_gamepad.py

# Or specify another config file
python deploy_mujoco_gamepad.py your_config.yaml
```

**Note**: If no config file is specified, the program defaults to `configs/e2_21dof.yaml`. Config files are located in the `configs/` directory.

#### 2.1 Start Simulation

After the program starts:
1. Robot model and policy files are automatically loaded
2. Gamepad is initialized and calibration file is loaded
3. MuJoCo simulation window opens

#### 2.2 Start Controlling

Use the gamepad to control robot movement. See [Gamepad Control Guide](#gamepad-control-guide) for details.

## Gamepad Control Guide

### Joystick Control

#### Right Joystick (Movement Control)
- **Up/Down**: Control robot forward/backward velocity
  - Push up: Forward (positive direction)
  - Push down: Backward (negative direction)
- **Left/Right**: Control robot left/right velocity
  - Push left: Move left (negative direction)
  - Push right: Move right (positive direction)

#### Left Joystick (Angular Velocity and Disturbance Control)
- **Left/Right**: Control robot angular velocity (rotation)
  - Push left: Counter-clockwise rotation (negative direction)
  - Push right: Clockwise rotation (positive direction)
  - **Note**: In disturbance test mode, left joystick left/right does not control angular velocity
- **Up/Down**: Only used in disturbance test mode to control disturbance force forward/backward direction
- **Left/Right + Up/Down**: In disturbance test mode, controls disturbance force direction and magnitude

### Button Control

| Button | Function | Description |
|--------|----------|-------------|
| **LB** | Switch Mode | Cycle through: Walking → Running → Disturbance Test → Walking |
| **X** | Toggle Foot Contact Force | Show/hide foot contact force vectors in simulation window |
| **Y** | Toggle Pelvis Tracking | Enable/disable camera tracking of robot pelvis |
| **B** | Reset Robot State | Reset robot to initial position and pose |
| **A** | Toggle Contact Status | Show/hide foot contact status |
| **RB** | Reserved Button | Currently unused |

### D-Pad Control

**Only effective when pelvis tracking is enabled** (after pressing Y button to enable tracking):

- **Left/Right**: Rotate view around robot
  - Left: Rotate view counter-clockwise
  - Right: Rotate view clockwise
- **Up/Down**: Control view distance
  - Up: Zoom out
  - Down: Zoom in

## Operating Modes

### Mode 1: Walking Mode
- **Max Forward Velocity**: 1.2 m/s
- **Max Backward Velocity**: 0.8 m/s
- **Max Left/Right Velocity**: 0.8 m/s
- **Max Angular Velocity**: 1.3 rad/s
- **Use Case**: Normal walking, fine control

### Mode 2: Running Mode
- **Max Forward Velocity**: 2.0 m/s
- **Max Backward Velocity**: 0.8 m/s
- **Max Left/Right Velocity**: 0.8 m/s
- **Max Angular Velocity**: 1.3 rad/s
- **Use Case**: Fast movement, high-speed walking

### Mode 3: Disturbance Test Mode
- **Velocity Limits**: Same as walking mode
- **Special Function**: Left joystick controls disturbance force
  - Left joystick X-axis: Control disturbance force left/right direction
  - Left joystick Y-axis: Control disturbance force forward/backward direction
  - Disturbance force magnitude: Determined by joystick amplitude (max 100N)
  - Disturbance force application point: `torso_link` (torso)
- **Angular Velocity Control**: Disabled in this mode
- **Use Case**: Test robot disturbance rejection capability

**Switch Mode**: Press **LB** button to cycle through modes. Current mode will be displayed in console.

## Configuration File

Configuration files are located in the `configs/` directory, for example `e2_21dof.yaml`.

### Main Configuration Items

```yaml
# Policy file path
policy_path: "policy/motion_lstm.pt"

# Robot model file path
xml_path: "model/e2/scene_terrain.xml"

# Simulation parameters
simulation_duration: 600.0  # Simulation duration (seconds)
simulation_dt: 0.002         # Simulation time step
control_decimation: 10       # Control update frequency

# PD controller parameters
kps: [100, 80, 80, ...]      # Position gain
kds: [4, 2, 2, ...]          # Velocity gain

# Default joint angles
default_angles: [-0.10, 0.0, ...]

# Scaling parameters
ang_vel_scale: 0.25          # Angular velocity scale
dof_pos_scale: 1.0           # Joint position scale
dof_vel_scale: 0.05          # Joint velocity scale
action_scale: 0.25           # Action scale
cmd_scale: [2.0, 2.0, 0.25]  # Velocity command scale

# Observation and action dimensions
num_actions: 21              # Action dimension
num_obs: 72                  # Observation dimension
include_phase_in_obs: False  # Whether to include phase in observation

# Initial velocity command
cmd_init: [0., 0, 0]         # [forward/backward velocity, left/right velocity, angular velocity]

# Gamepad type
gamepad_type: logitech       # logitech, betop, or custom
```

### Gamepad Configuration

You can specify the gamepad type in the configuration file:

```yaml
gamepad_type: logitech  # Options: logitech, betop, custom
```

If using a custom gamepad, you can also specify axis mapping:

```yaml
gamepad_type: custom
axis_mapping: [0, 1, 2, 3]  # [Left joystick X, Left joystick Y, Right joystick X, Right joystick Y]
```

## FAQ

### 1. Robot keeps drifting or is uncontrollable

**Cause**: Gamepad is not calibrated or calibration is inaccurate.

**Solution**:
1. Run `calibrate_gamepad.py` to recalibrate
2. Ensure all joysticks are at center position during calibration
3. Check if calibration file is loaded correctly

### 2. Gamepad not detected

**Cause**: Gamepad not connected or driver issue.

**Solution**:
1. Check if gamepad is properly connected
2. On Linux systems, you may need to install `python3-pygame` or related drivers
3. Run calibration script to test if gamepad is recognized

### 3. Buttons not responding

**Cause**: Buttons not calibrated or button ID incorrect.

**Solution**:
1. Run calibration script to recalibrate buttons
2. Check if button mapping in calibration file is correct
3. Confirm button IDs match actual gamepad buttons

### 4. Simulation window cannot open

**Cause**: MuJoCo viewer initialization failed.

**Solution**:
1. Check if MuJoCo is installed correctly
2. Confirm display environment variables are set correctly (Linux systems may need to set `DISPLAY`)
3. Check if model file paths are correct

### 5. Robot movement is unnatural

**Cause**: PD controller parameters or scaling parameters are inappropriate.

**Solution**:
1. Adjust `kps` and `kds` parameters in config file
2. Check `action_scale` and `cmd_scale` parameters
3. Confirm `default_angles` is correct

### 6. Disturbance force not working in disturbance mode

**Cause**: Not switched to disturbance mode or disturbance body ID is incorrect.

**Solution**:
1. Press **LB** button to switch to disturbance test mode
2. Check console output to confirm mode has switched
3. Confirm `torso_link` body exists in model file

## File Structure

```
deploy_mujoco/
├── calibrate_gamepad.py              # Gamepad calibration script
├── deploy_mujoco_gamepad.py          # Main simulation program
├── configs/                          # Configuration file directory
│   └── e2_21dof.yaml                 # Robot configuration file
├── model/                            # Robot model directory
│   └── e2/
│       ├── e2_21Dof.xml              # Robot model file
│       ├── scene_terrain.xml         # Scene file
│       └── meshes/                   # Mesh files
├── policy/                           # Policy file directory
│   └── motion_lstm.pt                # Pre-trained policy model
├── utils/                            # Utility function directory
│   ├── gamepad_utils.py              # Gamepad utilities
│   ├── mode_utils.py                 # Mode control utilities
│   ├── viewer_utils.py               # Viewer control utilities
│   ├── disturbance_utils.py          # Disturbance force utilities
│   └── math_utils.py                 # Math utilities
└── gamepad_calibration_*.json        # Gamepad calibration files
```

## Technical Support

For questions or suggestions, please check code comments or contact the development team.

---

**Enjoy!** 🚀

