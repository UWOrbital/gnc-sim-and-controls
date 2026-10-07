```text
 ██████╗ ███╗   ██╗ ██████╗
██╔════╝ ████╗  ██║██╔════╝
██║  ███╗██╔██╗ ██║██║
██║   ██║██║╚██╗██║██║
╚██████╔╝██║ ╚████║╚██████╗
 ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝
███████╗██╗███╗   ███╗       ██╗        ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  ██████╗ ██╗     ███████╗
██╔════╝██║████╗ ████║       ██║       ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔═══██╗██║     ██╔════╝
███████╗██║██╔████╔██║    ████████╗    ██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝██║   ██║██║     ███████╗
╚════██║██║██║╚██╔╝██║    ██╔═██╔═╝    ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██║   ██║██║     ╚════██║
███████║██║██║ ╚═╝ ██║    ██████║      ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║╚██████╔╝███████╗███████║
╚══════╝╚═╝╚═╝     ╚═╝    ╚═════╝       ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
```
## Structure

```
gnc-sim-and-controls/
├── adcs_full_model.prj   MATLAB project file (open this first)
├── resources/project/    MATLAB project metadata (do not edit by hand)
├── config/               init.m: parameters loaded by the top model's InitFcn
├── models/
│   ├── top/              adcs_model.slx: full closed-loop sim (start here)
│   ├── environment/      environment.slx: orbit, magnetic field, sun
│   ├── dynamics/         dynamics_kinematics_subsystem.slx: attitude dynamics + kinematics
│   ├── sensors/          sensors.slx, sun_sensor_model.slx
│   ├── actuators/        actuators.slx, reaction_wheel_model.slx
│   ├── estimation/       TODO: ads.slx: attitude determination
│   ├── control/          VERIFY: controller.slx
│   ├── navigation/       TODO: SGP4/TLE propagation, orbit estimation
│   ├── guidance/         TODO: pointing targets (nadir, sun, ground)
│   └── modes_fdir/       TODO: mode manager, fault detection and recovery
├── libraries/            TODO: shared blocks (quaternion utils, frame transforms)
├── tests/                TODO: unit tests, detumble and pointing scenarios
├── analysis/             TODO: Monte Carlo, budgets, GPS trade, plots
├── flight_software/      TODO: flight software and Simulink to C codegen
├── docs/                 Documentation
├── tools/                setup_project_paths.m: repairs project file list and path
└── archived/             Old models, kept for reference only. Never on the path.
```

## How to run
1. Open `adcs_full_model.prj` in MATLAB (R2025a or newer).
2. Open `models/top/adcs_model.slx`. Its InitFcn runs `config/init.m` automatically.
3. Required toolboxes: Simulink, Aerospace Blockset, Aerospace Toolbox, DSP System Toolbox,
   and Sensor Fusion and Tracking Toolbox or Navigation Toolbox (for the IMU block).

## Operations
- `adcs_model.slx` connects the subsystem models through Model Reference blocks.
- Models reference each other **by name**, not by path. The project path (`config/`,
  `models/**`, `libraries/`) is what lets MATLAB find them. Moving a model between
  folders is safe as long as its folder is on the project path.
- `archived/` contains older models with duplicate names, so it must never be added
  to the path.

## Rules
- Add, move or remove files through the MATLAB project (or rerun
  `tools/setup_project_paths.m`), then commit `resources/project/` along with your change.
- New models go in the matching `models/<area>/` folder. Shared blocks go in `libraries/`.