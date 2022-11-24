/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: example_detumbling.c
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

#include "example_detumbling.h"
#include "rtwtypes.h"

/* Block signals and states (default storage) */
DW_example_detumbling_T example_detumbling_DW;

/* External inputs (root inport signals with default storage) */
ExtU_example_detumbling_T example_detumbling_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_example_detumbling_T example_detumbling_Y;

/* Model step function */
void example_detumbling_step(void)
{
  real_T rtb_Diff;
  real_T rtb_Sign;
  real_T rtb_TSamp;

  /* Signum: '<Root>/Sign' incorporates:
   *  Inport: '<Root>/error_quat'
   */
  if (example_detumbling_U.error_quat[0] < 0.0) {
    rtb_Sign = -1.0;
  } else {
    rtb_Sign = (example_detumbling_U.error_quat[0] > 0.0);
  }

  /* End of Signum: '<Root>/Sign' */

  /* Outport: '<Root>/torque' incorporates:
   *  Gain: '<Root>/k_d'
   *  Gain: '<Root>/k_p'
   *  Inport: '<Root>/ang_vel'
   *  Inport: '<Root>/error_quat'
   *  Product: '<Root>/Product'
   *  Sum: '<Root>/Sum6'
   */
  example_detumbling_Y.torque[0] = 0.2 * example_detumbling_U.error_quat[1] *
    rtb_Sign + 0.1 * example_detumbling_U.ang_vel[0];

  /* Outport: '<Root>/ang_pos' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator'
   */
  example_detumbling_Y.ang_pos[0] =
    example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[0];

  /* SampleTimeMath: '<S1>/TSamp' incorporates:
   *  Inport: '<Root>/ang_vel'
   *
   * About '<S1>/TSamp':
   *  y = u * K where K = 1 / ( w * Ts )
   */
  rtb_TSamp = example_detumbling_U.ang_vel[0] * 5.0;

  /* Sum: '<S1>/Diff' incorporates:
   *  UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/Diff':
   *
   *  Add in CPU
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  rtb_Diff = rtb_TSamp - example_detumbling_DW.UD_DSTATE[0];

  /* Outport: '<Root>/ang_accel' */
  example_detumbling_Y.ang_accel[0] = rtb_Diff;

  /* Outport: '<Root>/is_equal' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator1'
   *  Inport: '<Root>/ang_vel'
   *  RelationalOperator: '<Root>/Equal'
   */
  example_detumbling_Y.is_equal[0] =
    (example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[0] ==
     example_detumbling_U.ang_vel[0]);

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' incorporates:
   *  Inport: '<Root>/ang_vel'
   */
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[0] += 0.2 *
    example_detumbling_U.ang_vel[0];

  /* Update for UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  example_detumbling_DW.UD_DSTATE[0] = rtb_TSamp;

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator1' */
  example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[0] += 0.2 * rtb_Diff;

  /* Outport: '<Root>/torque' incorporates:
   *  Gain: '<Root>/k_d'
   *  Gain: '<Root>/k_p'
   *  Inport: '<Root>/ang_vel'
   *  Inport: '<Root>/error_quat'
   *  Product: '<Root>/Product'
   *  Sum: '<Root>/Sum6'
   */
  example_detumbling_Y.torque[1] = 0.2 * example_detumbling_U.error_quat[2] *
    rtb_Sign + 0.1 * example_detumbling_U.ang_vel[1];

  /* Outport: '<Root>/ang_pos' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator'
   */
  example_detumbling_Y.ang_pos[1] =
    example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[1];

  /* SampleTimeMath: '<S1>/TSamp' incorporates:
   *  Inport: '<Root>/ang_vel'
   *
   * About '<S1>/TSamp':
   *  y = u * K where K = 1 / ( w * Ts )
   */
  rtb_TSamp = example_detumbling_U.ang_vel[1] * 5.0;

  /* Sum: '<S1>/Diff' incorporates:
   *  UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/Diff':
   *
   *  Add in CPU
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  rtb_Diff = rtb_TSamp - example_detumbling_DW.UD_DSTATE[1];

  /* Outport: '<Root>/ang_accel' */
  example_detumbling_Y.ang_accel[1] = rtb_Diff;

  /* Outport: '<Root>/is_equal' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator1'
   *  Inport: '<Root>/ang_vel'
   *  RelationalOperator: '<Root>/Equal'
   */
  example_detumbling_Y.is_equal[1] =
    (example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[1] ==
     example_detumbling_U.ang_vel[1]);

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' incorporates:
   *  Inport: '<Root>/ang_vel'
   */
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[1] += 0.2 *
    example_detumbling_U.ang_vel[1];

  /* Update for UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  example_detumbling_DW.UD_DSTATE[1] = rtb_TSamp;

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator1' */
  example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[1] += 0.2 * rtb_Diff;

  /* Outport: '<Root>/torque' incorporates:
   *  Gain: '<Root>/k_d'
   *  Gain: '<Root>/k_p'
   *  Inport: '<Root>/ang_vel'
   *  Inport: '<Root>/error_quat'
   *  Product: '<Root>/Product'
   *  Sum: '<Root>/Sum6'
   */
  example_detumbling_Y.torque[2] = 0.2 * example_detumbling_U.error_quat[3] *
    rtb_Sign + 0.1 * example_detumbling_U.ang_vel[2];

  /* Outport: '<Root>/ang_pos' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator'
   */
  example_detumbling_Y.ang_pos[2] =
    example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[2];

  /* SampleTimeMath: '<S1>/TSamp' incorporates:
   *  Inport: '<Root>/ang_vel'
   *
   * About '<S1>/TSamp':
   *  y = u * K where K = 1 / ( w * Ts )
   */
  rtb_TSamp = example_detumbling_U.ang_vel[2] * 5.0;

  /* Sum: '<S1>/Diff' incorporates:
   *  UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/Diff':
   *
   *  Add in CPU
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  rtb_Diff = rtb_TSamp - example_detumbling_DW.UD_DSTATE[2];

  /* Outport: '<Root>/ang_accel' */
  example_detumbling_Y.ang_accel[2] = rtb_Diff;

  /* Outport: '<Root>/is_equal' incorporates:
   *  DiscreteIntegrator: '<Root>/Discrete-Time Integrator1'
   *  Inport: '<Root>/ang_vel'
   *  RelationalOperator: '<Root>/Equal'
   */
  example_detumbling_Y.is_equal[2] =
    (example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[2] ==
     example_detumbling_U.ang_vel[2]);

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' incorporates:
   *  Inport: '<Root>/ang_vel'
   */
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[2] += 0.2 *
    example_detumbling_U.ang_vel[2];

  /* Update for UnitDelay: '<S1>/UD'
   *
   * Block description for '<S1>/UD':
   *
   *  Store in Global RAM
   */
  example_detumbling_DW.UD_DSTATE[2] = rtb_TSamp;

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator1' */
  example_detumbling_DW.DiscreteTimeIntegrator1_DSTATE[2] += 0.2 * rtb_Diff;
}

/* Model initialize function */
void example_detumbling_initialize(void)
{
  /* InitializeConditions for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[0] = 50.0;
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[1] = 50.0;
  example_detumbling_DW.DiscreteTimeIntegrator_DSTATE[2] = 50.0;
}

/* Model terminate function */
void example_detumbling_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
