%% ========================================================================
% Constants Initialisation
% ========================================================================
clear; clc;

%% Mass Properties & Kinematics
% ------------------------------------------------------------------------
% Mass and Geometry
Sat.mass = 3.0;              % Mass in kg (approx 3U)
Sat.dim  = [0.10, 0.10, 0.30]; % Dimensions [x, y, z] in meters

% Inertia Tensor (kg*m^2) - Assumes uniform 3U rectangular prism
Sat.J = diag([ ...
    (1/12) * Sat.mass * (Sat.dim(2)^2 + Sat.dim(3)^2), ... % Jxx
    (1/12) * Sat.mass * (Sat.dim(1)^2 + Sat.dim(3)^2), ... % Jyy
    (1/12) * Sat.mass * (Sat.dim(1)^2 + Sat.dim(2)^2)  ... % Jzz
]);

% Initial Conditions
IC.q0     = [1; 0; 0; 0];              % Initial Quaternion [q0, q1, q2, q3]
IC.w0_deg = [5; -3; 8];                % Initial tip-off rates in deg/s
IC.w0     = IC.w0_deg * (pi / 180);    % Initial angular velocity in rad/s

%% Orbit & Environment Parameters
% ------------------------------------------------------------------------
Orbit.altitude   = 500e3;              % Altitude in meters (500 km LEO)
Orbit.R_earth    = 6371e3;             % Earth mean radius in meters
Orbit.mu         = 3.986004418e14;     % Earth gravitational parameter (m^3/s^2)
Orbit.radius     = Orbit.R_earth + Orbit.altitude;
Orbit.inclination= 97.4 * (pi / 180);  % Sun-synchronous orbit (rad)
Orbit.mean_motion= sqrt(Orbit.mu / Orbit.radius^3); % rad/s
Orbit.period     = 2 * pi / Orbit.mean_motion;      % seconds

%% Sensor Specifications
% ------------------------------------------------------------------------
% Sampling Rates
Sensors.sample_rate = 10;              % ADCS Loop Frequency (Hz)
Sensors.dt          = 1 / Sensors.sample_rate;

% Gyroscope / IMU
Sensors.Gyro.bias_drift_deg_hr = 5;  % Target <2 deg/hr bias
Sensors.Gyro.bias_drift     = Sensors.Gyro.bias_drift_deg_hr * (pi/180) / 3600; % rad/s
Sensors.Gyro.noise_density  = 0.005;   % Noise density (rad/s/sqrt(Hz))
Sensors.Gyro.scale_factor   = 1.0;

% Magnetometer
Sensors.Mag.noise_std       = 50e-9;   % Noise std dev in Tesla (50 nT)
Sensors.Mag.bias            = [100; -100; 50] * 1e-9; % Bias in Tesla

% Coarse Sun Sensors (CSS - 6 faces)
Sensors.CSS.fov_deg         = 85;      % Field of view per face (deg)
Sensors.CSS.noise_std       = 0.02;    % Current output noise std dev

% Fine Sun Sensor (FSS - 1 unit)
Sensors.FSS.fov_deg         = 110;      % FOV cone angle (deg)
Sensors.FSS.accuracy_deg    = 0.3;     % Accuracy in degrees
Sensors.FSS.accuracy_rad    = Sensors.FSS.accuracy_deg * (pi / 180);

%% Actuator Specifications
% ------------------------------------------------------------------------
% Reaction Wheels
Actuators.RW.J_wheel        = 2.128e-6; % Wheel flywheel inertia (kg*m^2)
Actuators.RW.max_speed_rpm  = 10000;    % Max speed in RPM
Actuators.RW.max_speed      = Actuators.RW.max_speed_rpm * (2*pi/60); % rad/s
Actuators.RW.max_torque     = 0.0023;   % Max motor torque (N*m)

% Magnetic Torquers
Actuators.MTQ.max_dipole    = 0.3;     % Max dipole moment (A*m^2)
Actuators.MTQ.efficiency    = 0.95;

%% Controller & Estimator Parameters
% ------------------------------------------------------------------------
% B-Dot Controller Gain
Ctrl.BDot.gain              = 1e5;     % Detumbling proportional gain

% Pointing PD Controller Gains
Ctrl.PD.Kp                  = 0.01;    % Proportional Gain (Stiffness)
Ctrl.PD.Kd                  = 0.05;    % Derivative Gain (Damping)

% Desaturation Gain
Ctrl.Desat.gain             = 0.1;
