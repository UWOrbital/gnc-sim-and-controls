/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: example_detumbling.h
 *
 * Code generated for Simulink model 'example_detumbling'.
 *
 * Model version                  : 1.8
 * Simulink Coder version         : 9.7 (R2022a) 13-Nov-2021
 * C/C++ source code generated on : Sat Nov 12 15:25:21 2022
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-A
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. Safety precaution
 *    3. RAM efficiency
 *    4. ROM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_example_detumbling_h_
#define RTW_HEADER_example_detumbling_h_
#ifndef example_detumbling_COMMON_INCLUDES_
#define example_detumbling_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* example_detumbling_COMMON_INCLUDES_ */

#include "example_detumbling_types.h"

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  real_T DiscreteTimeIntegrator_DSTATE[3];/* '<Root>/Discrete-Time Integrator' */
  real_T UD_DSTATE[3];                 /* '<S1>/UD' */
  real_T DiscreteTimeIntegrator1_DSTATE[3];/* '<Root>/Discrete-Time Integrator1' */
} DW_example_detumbling_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T ang_vel[3];                   /* '<Root>/ang_vel' */
  real_T error_quat[4];                /* '<Root>/error_quat' */
} ExtU_example_detumbling_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T torque[3];                    /* '<Root>/torque' */
  real_T ang_pos[3];                   /* '<Root>/ang_pos' */
  real_T ang_accel[3];                 /* '<Root>/ang_accel' */
  boolean_T is_equal[3];               /* '<Root>/is_equal' */
} ExtY_example_detumbling_T;

/* Block signals and states (default storage) */
extern DW_example_detumbling_T example_detumbling_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_example_detumbling_T example_detumbling_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_example_detumbling_T example_detumbling_Y;

/* Model entry point functions */
extern void example_detumbling_initialize(void);
extern void example_detumbling_step(void);
extern void example_detumbling_terminate(void);

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<S1>/Data Type Duplicate' : Unused code path elimination
 */

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'example_detumbling'
 * '<S1>'   : 'example_detumbling/Discrete Derivative'
 */
#endif                                 /* RTW_HEADER_example_detumbling_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
