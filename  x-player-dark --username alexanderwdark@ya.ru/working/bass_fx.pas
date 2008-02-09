{=============================================================================
  BASS_FX 2.2 - Copyright (c) 2002-2005 (: JOBnik! :) [Arthur Aminov, ISRAEL]
                                                      [http://www.jobnik.org]

   bugs/suggestions/questions -> e-mail: bass_fx@jobnik.org
  ----------------------------------------------------------

  BASS_FX 2.2 unit is based on BASS_FX 1.1 unit:
  ---------------------------------------------
  (c) 2002 Roger Johansson. w1dg3r@yahoo.com

  NOTE: This unit will only work with BASS_FX version 2.2
        Check http://www.un4seen.com for any later versions of BASS_FX.PAS

  * Requires BASS & BASS.PAS 2.2 - available @ www.un4seen.com

  How to install:
  ---------------
  Copy BASS_FX.PAS & BASS.PAS to the \LIB subdirectory of your Delphi path
  or your project dir.
=============================================================================}

unit BASS_FX;

interface

uses BASS;

const
  // Error codes returned by BASS_ErrorGetCode()
  BASS_FX_ERROR_NODECODE = 100;  // Not a decoding channel
  BASS_FX_ERROR_STEREO   = 101;  // Only for stereo
  BASS_FX_ERROR_BPMINUSE = 102;  // BPM detection is in use
  BASS_FX_ERROR_BPMX2    = 103;  // BPM has already multed by 2

// Tempo / Reverse / BPM flag
const
  BASS_FX_FREESOURCE = $10000;  // Free the source handle as well?

{=============================================================================================
  D S P (Digital Signal Processing)
==============================================================================================}

// DSP effects
const
  BASS_FX_DSPFX_SWAP    = 0;      // Swap channels: left<=>right : for STEREO Only!
  BASS_FX_DSPFX_ROTATE  = 1;      // A channels volume ping-pong : for STEREO Only!
  BASS_FX_DSPFX_ECHO    = 2;      // Echo
  BASS_FX_DSPFX_FLANGER = 3;      // Flanger
  BASS_FX_DSPFX_VOLUME  = 4;      // Volume Amplifier : L/R for STEREO, L for MONO
  BASS_FX_DSPFX_PEAKEQ  = 5;      // Peaking Equalizer
  BASS_FX_DSPFX_REVERB  = 6;      // Reverb
  BASS_FX_DSPFX_LPF     = 7;      // Low Pass Filter
  BASS_FX_DSPFX_S2M     = 8;      // Stereo 2 Mono : for STEREO Only!
  BASS_FX_DSPFX_DAMP    = 9;      // Dynamic Amplification
  BASS_FX_DSPFX_AUTOWAH = 10;     // Auto WAH
  BASS_FX_DSPFX_ECHO2   = 11;     // Echo 2
  BASS_FX_DSPFX_PHASER  = 12;     // Phaser
  BASS_FX_DSPFX_ECHO3   = 13;     // Echo 3
  BASS_FX_DSPFX_CHORUS  = 14;     // Chorus
  BASS_FX_DSPFX_APF     = 15;     // All Pass Filter
  BASS_FX_DSPFX_COMPRESSOR = 16;  // Compressor
  BASS_FX_DSPFX_DISTORTION = 17;  // Distortion

type
  // Flanger
  BASS_FX_DSPFLANGER = record
    fWetDry: FLOAT;              // [0.........1]
    fSpeed:  FLOAT;              // [0.........n]
  end;

  // Echo
  BASS_FX_DSPECHO = record
    fLevel: FLOAT;              // [0.........1]
    lDelay: integer;            // [1200..30000]
  end;

  // Reverb
  BASS_FX_DSPREVERB = record
    fLevel: FLOAT;              // [0.........1]
    lDelay: integer;            // [1200..10000]
  end;

  // Volume
  BASS_FX_DSPVOLUME = record    // L/R for STEREO, L for MONO for both channels
    fLeft:  FLOAT;              // [0....1....n]
    fRight: FLOAT;              // [0....1....n]
  end;

  // Peaking Equalizer
  BASS_FX_DSPPEAKEQ = record
    lBand:   integer;            // [0..n] more bands => more memory & cpu usage
    lFreq:   DWORD;              // current sample rate of a stream/music
    fBandwidth: FLOAT;           // in octaves [0..4] - Q is not in use
    fQ:      FLOAT;
    // the EE kinda definition [0..1] - Bandwidth is not in use
    fCenter: FLOAT;          // eg. 1000Hz
    fGain:   FLOAT;              // in dB. eg. [-15..0..+15]
  end;

  // Low Pass Filter
  BASS_FX_DSPLPF = record
    lFreq:      DWORD;              // current samplerate of stream/music
    fResonance: FLOAT;              // [2..........10]
    fCutOffFreq: FLOAT;             // [200Hz..5000Hz]
  end;

  // Dynamic Amplification
  BASS_FX_DSPDAMP = record
    fTarget: FLOAT;              // target volume level                  [0.......1]
    fQuiet:  FLOAT;              // quiet  volume level                  [0.......1]
    fRate:   FLOAT;              // amp adjustment rate                  [e.g: 0.02]
    fGain:   FLOAT;              // amplification level                  [0.......1]
    fDelay:  FLOAT;              // delay in seconds before increasing level [0..Length]
  end;

  // Auto WAH
  BASS_FX_DSPAUTOWAH = record
    fDryMix:   FLOAT;          // dry (unaffected) signal mix               [-2......2]
    fWetMix:   FLOAT;          // wet (affected) signal mix                 [-2......2]
    fFeedback: FLOAT;          // feedback                                  [-1......1]
    fRate:     FLOAT;
    // rate of sweep in cycles per second        [0<....<10]
    fRange:    FLOAT;
    // sweep range in octaves                    [0<....<10]
    fFreq:     FLOAT;
    // base frequency of sweep Hz                [0<...1000]
  end;

  // Echo 2
  BASS_FX_DSPECHO2 = record
    fDryMix:   FLOAT;          // dry (unaffected) signal mix               [-2......2]
    fWetMix:   FLOAT;          // wet (affected) signal mix                 [-2......2]
    fFeedback: FLOAT;          // feedback                                  [-1......1]
    fDelay:    FLOAT;
    // delay sec                                 [0<......6]
  end;

  // Phaser
  BASS_FX_DSPPHASER = record
    fDryMix:   FLOAT;          // dry (unaffected) signal mix               [-2......2]
    fWetMix:   FLOAT;          // wet (affected) signal mix                 [-2......2]
    fFeedback: FLOAT;          // feedback                                  [-1......1]
    fRate:     FLOAT;
    // rate of sweep in cycles per second        [0<....<10]
    fRange:    FLOAT;
    // sweep range in octaves                    [0<....<10]
    fFreq:     FLOAT;
    // base frequency of sweep                   [0<...1000]
  end;

  // Echo 3
  BASS_FX_DSPECHO3 = record
    fDryMix: FLOAT;              // dry (unaffected) signal mix               [-2......2]
    fWetMix: FLOAT;              // wet (affected) signal mix                 [-2......2]
    fDelay:  FLOAT;              // delay sec                                 [0<......6]
  end;

  // Chorus
  BASS_FX_DSPCHORUS = record
    fDryMix:   FLOAT;          // dry (unaffected) signal mix               [-2......2]
    fWetMix:   FLOAT;          // wet (affected) signal mix                 [-2......2]
    fFeedback: FLOAT;          // feedback                                  [-1......1]
    fMinSweep: FLOAT;          // minimal delay ms                        [0<..<6000]
    fMaxSweep: FLOAT;          // maximum delay ms                         [0<..<6000]
    fRate:     FLOAT;              // rate ms/s                                [0<...1000]
  end;

  // All Pass Filter
  BASS_FX_DSPAPF = record
    fGain:  FLOAT;              // reverberation time                       [-1=<..<=1]
    fDelay: FLOAT;              // delay sec                                [0<....<=6]
  end;

  // Compressor
  BASS_FX_DSPCOMPRESSOR = record
    fThreshold:   FLOAT;          // compressor threshold                     [0<=...<=1]
    fAttacktime:  FLOAT;          // attack time ms                           [0<.<=1000]
    fReleasetime: FLOAT;          // release time ms                          [0<.<=5000]
  end;

  // Distortion
  BASS_FX_DSPDISTORTION = record
    fDrive:    FLOAT;              // distortion drive                         [0<=...<=5]
    fDryMix:   FLOAT;          // dry (unaffected) signal mix              [-5<=..<=5]
    fWetMix:   FLOAT;          // wet (affected) signal mix                [-5<=..<=5]
    fFeedback: FLOAT;          // feedback                                 [-1<=..<=1]
    fVolume:   FLOAT;          // distortion volume                        [0=<...<=2]
  end;

function BASS_FX_DSP_Set(handle: DWORD; dsp_fx: integer; priority: integer): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_DSP_Set';
{
  Set any chosen DSP effect to any handle.
  handle   : stream/music/wma/cd/any other supported add-on format
  dsp_fx   : FX you wish to use
  priority : The priority of the new DSP, which determines it's position in the DSP chain
               DSPs with higher priority are called before those with lower.
  RETURN   : TRUE if created (0=error!)
}

function BASS_FX_DSP_Remove(handle: DWORD; dsp_fx: integer): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_DSP_Remove';
{
  Remove chosen DSP effect.
  handle : stream/music/wma/cd/any other supported add-on format
  dsp_fx : FX you wish to remove
  RETURN : TRUE if removed (0=error!)
}

function BASS_FX_DSP_SetParameters(handle: DWORD; dsp_fx: integer; par: Pointer): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_DSP_SetParameters';
{
  Set the parameters of a DSP effect.
  handle : stream/music/wma/cd/any other supported add-on format
  dsp_fx : FX you wish to set parameters to
  par    : Pointer to the parameter structure
  RETURN : TRUE if ok (0=error!)
}

function BASS_FX_DSP_GetParameters(handle: DWORD; DSP_FX: integer; par: Pointer): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_DSP_GetParameters';
{
  Retrieve the parameters of a DSP effect.
  handle : stream/music/wma/cd/any other supported add-on format
  dsp_fx : FX you wish to get parameters from
  par    : Pointer to the parameter structure
  RETURN : TRUE if ok (0=error!)
}

function BASS_FX_DSP_Reset(handle: DWORD; dsp_fx: integer): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_DSP_Reset';
{
  Call this function before changing position to avoid *clicks*
  handle : stream/music/wma/cd/any other supported add-on format
  dsp_fx : FX you wish to reset parameters of
  RETURN : TRUE if ok (0=error!)
}

{=============================================================================================
  TEMPO / PITCH SCALING / SAMPLERATE
==============================================================================================}

// tempo flags
const
  BASS_FX_TEMPO_QUICKALGO   = $400000;
  // Using quicker tempo change algorithm gain speed, lose quality
  BASS_FX_TEMPO_NO_AAFILTER = $800000;
// Not using FIR low-pass (anti-alias) filter gain speed, lose quality

// NOTES: 1. BASS_SYNC_POS is not supported for MODs, yet.
//        2. Enable Tempo supported flags in BASS_FX_TempoCreate and the others to source handle.

function BASS_FX_TempoCreate(chan, flags: DWORD): HSTREAM; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_TempoCreate';
{
  Creates a resampling stream from a decoding channel.
  chan     : a handle returned by:
                        BASS_StreamCreateFile     : flags = BASS_STREAM_DECODE ...
                  BASS_MusicLoad            : flags = BASS_MUSIC_DECODE ...
                  BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
                  BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
                        * Any other add-on handle using a decoding channel.
  flags    : BASS_SAMPLE_SOFTWARE/LOOP/3D/FX or BASS_STREAM_DECODE/AUTOFREE or
             BASS_SPEAKER_xxx or BASS_FX_TEMPO_xxx or BASS_FX_FREESOURCE
  RETURN   : the tempo stream handle (0=error!)
}

function BASS_FX_TempoGetSource(chan: HSTREAM): DWORD; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_TempoGetSource';
{
  Get the source channel handle.
  chan   : tempo stream handle
  RETURN : the source channel handle (0=error!)
}

function BASS_FX_TempoSet(chan: HSTREAM; tempo, samplerate, pitch: FLOAT): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_TempoSet';
{
  Set new values to tempo/rate/pitch to change its speed.
  chan       : tempo stream (or source channel) handle
  tempo      : in Percents  [-95%..0..+5000%]              (-100 = leave current)
  samplerate : in Hz, but calculates by the same % as tempo  (   0 = leave current)
  pitch      : in Semitones [-60....0....+60]              (-100 = leave current)
  RETURN     : TRUE if ok (0=error!)
}

function BASS_FX_TempoGet(chan: HSTREAM; var tempo, samplerate, pitch: FLOAT): BOOL;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_TempoGet';
{
  Get tempo/rate/pitch values.
  chan       : tempo stream (or source channel) handle
  tempo      : current tempo        (Nil if not in use)
  samplerate : current samplerate    (Nil if not in use)
  pitch      : current pitch        (Nil if not in use)
  RETURN     : TRUE if ok (0=error!)
}

function BASS_FX_TempoGetRateRatio(chan: HSTREAM): FLOAT; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_TempoGetRateRatio';
{
  Get the ratio of the resulting rate and source rate (the resampling ratio).
  chan   : tempo stream (or source channel) handle
  RETURN : the ratio (0=error!)
}

{=============================================================================================
  R E V E R S E
==============================================================================================}

// NOTES: 1. MODs won't load without BASS_MUSIC_PRESCAN flag.
//        2. Enable Reverse supported flags in BASS_FX_ReverseCreate and the others to source handle.

function BASS_FX_ReverseCreate(chan: HSTREAM; dec_block: FLOAT; flags: DWORD): HSTREAM;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_ReverseCreate';
{
  Creates a Reversed stream from a decoding channel.
  chan      : a handle returned by:
              BASS_StreamCreateFile    : flags = BASS_STREAM_DECODE ...
                    BASS_MusicLoad            : flags = BASS_MUSIC_DECODE Or BASS_MUSIC_PRESCAN ...
              BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
              BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
              * Other stream add-on formats if created as decoded channel.
                * For better MP3/2/1 Reverse playback use: BASS_STREAM_PRESCAN flag
  dec_block : decode in # of seconds blocks...
            larger blocks = less seeking overhead but larger spikes.
  flags    : BASS_SAMPLE_SOFTWARE/LOOP/3D/FX or BASS_STREAM_DECODE/AUTOFREE or
                BASS_SPEAKER_xxx or BASS_FX_FREESOURCE
  RETURN    : the reverse stream handle (0=error!)
}

function BASS_FX_ReverseGetSource(chan: HSTREAM): HSTREAM; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_ReverseGetSource';
{
  Get the source channel handle.
  chan   : reverse stream handle
  RETURN : the source channel handle (0=error!)
}

{=============================================================================================
  B P M (Beats Per Minute)
=============================================================================================}

// bpm flags
const
  BASS_FX_BPM_BKGRND = 1;
  // If in use, then you can do other stuff while detection's in process
  BASS_FX_BPM_MULT2  = 2;
// If in use, then will auto multiply bpm by 2 (if BPM < MinBPM*2)

 //-----------
 // Option - 1 - Get BPM from a decoded channel
 //--------------------------------------------
type
  BPMPROCESSPROC = procedure(chan: DWORD; percent: FLOAT); stdcall;

{
  Get the detection process in percents of a channel.
  chan    : channel that the BASS_FX_BPM_DecodeGet has applied to
  percent : the process in percents [0%..100%]
}

function BASS_FX_BPM_DecodeGet(chan: DWORD; startSec, endSec: FLOAT;
  minMaxBPM, flags: DWORD; proc: BPMPROCESSPROC): FLOAT; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_BPM_DecodeGet';
{
  Get the original BPM of a decoding channel.
  chan    : a handle returned by:
           BASS_StreamCreateFile     : flags = BASS_STREAM_DECODE ...
           BASS_MusicLoad            : flags = BASS_MUSIC_DECODE Or BASS_MUSIC_PRESCAN ...
           BASS_WMA_StreamCreateFile : flags = BASS_STREAM_DECODE ...
           BASS_CD_StreamCreate      : flags = BASS_STREAM_DECODE ...
          * Any other add-on handle using a decoding channel.
  startSec  : start detecting position in seconds
  endSec    : end detecting position in seconds - 0 = full length
  minMaxBPM : set min & max bpm, e.g: MAKELONG(LOWORD.HIWORD), LO=Min, HI=Max. 0 = defaults 45/230
  flags    : BASS_FX_BPM_xxx or BASS_FX_FREESOURCE
  *proc     : user defined function to receive the process in percents, use Nil if not in use
  RETURN    : the original BPM value (-1=error!)
}

 //-----------
 // Option - 2 - Auto get BPM by period of time in seconds
 //-------------------------------------------------------
type
  BPMPROC = procedure(handle: DWORD; bpm: FLOAT; user: DWORD); stdcall;

{
  Get the BPM after period of time in seconds.
  handle : handle that the BASS_FX_BPM_CallbackSet has applied to
  bpm    : the new original bpm value
    user   : the user instance data given when BASS_FX_BPM_CallbackSet was called.
}

function BASS_FX_BPM_CallbackSet(handle: DWORD; proc: BPMPROC;
  period: FLOAT; minMaxBPM, flags, user: DWORD): BOOL; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_BPM_CallbackSet';
{
  Enable getting BPM value by period of time in seconds.
  handle    : stream/music/wma/cd/any other supported add-on format
  *proc     : user defined function to receive the bpm value
  period    : detection period in seconds
  minMaxBPM : set min & max bpm, e.g: MAKELONG(LOWORD.HIWORD), LO=Min, HI=Max. 0 = defaults 45/230
  flags     : only BASS_FX_BPM_MULT2 flag is used
    user      : user instance data to pass to the callback function.
  RETURN    : TRUE if ok (0=error!)
}

function BASS_FX_BPM_CallbackReset(handle: DWORD): BOOL; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_BPM_CallbackReset';
{
  Reset the buffers. Call this function after changing position.
  handle : stream/music/wma/cd/any other supported add-on format
  RETURN : TRUE if ok (0=error!)
}

{----------------------------------------
   Functions to use with Both options.
----------------------------------------}

// translation options
const
  BASS_FX_BPM_X2    = 0;
  // Multiply the original BPM value by 2 (may be called only once & will change the original BPM as well!).
  BASS_FX_BPM_2FREQ = 1;     // BPM value to Frequency.
  BASS_FX_BPM_FREQ2 = 2;     // Frequency to BPM value.
  BASS_FX_BPM_2PERCENT = 3;  // Percents to BPM value.
  BASS_FX_BPM_PERCENT2 = 4;  // BPM value to Percents.

function BASS_FX_BPM_Translate(handle: DWORD; val2tran: FLOAT; trans: DWORD): FLOAT;
  stdcall; external 'bass_fx.dll' Name 'BASS_FX_BPM_Translate';
{
  Translate the given BPM to FREQ/PERCENT and vice versa or multiply BPM by 2.
  handle   : stream/music/wma/cd/any other supported add-on format
  val2tran : specify a value to translate to a given option (no matter if used X2).
  trans    : any of the above translation option
  RETURN   : new calculated value. (-1=error!)

  NOTE     : This function will not detect the BPM, it will just translate the detected
               original BPM value of a given handle.
}

function BASS_FX_BPM_Free(handle: DWORD): BOOL; stdcall;
  external 'bass_fx.dll' Name 'BASS_FX_BPM_Free';
{
  Free all resources used by a given handle.

  NOTE: If BASS_FX_FREESOURCE is used, then will free the decoding channel as well.
          You can't set/get this flag with BASS_ChannelSetFlags/BASS_ChannelGetInfo.

  handle : stream/music/wma/cd/any other supported add-on format
}

implementation

end.
