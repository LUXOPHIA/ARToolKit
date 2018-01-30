unit LUX.Vision.ARToolKit.define;

interface //#################################################################### ■

uses LUX.Code.C;

const _DLLNAME_ = 'ARvideod.dll';

type T_ARInt8   =  T_char;
     P_ARInt8   = ^T_ARInt8;
    PP_ARInt8   = ^P_ARInt8;
type T_ARInt16  =  T_short;
     P_ARInt16  = ^T_ARInt16;
    PP_ARInt16  = ^P_ARInt16;
type T_ARInt32  =  T_int;
     P_ARInt32  = ^T_ARInt32;
    PP_ARInt32  = ^P_ARInt32;
type T_ARUint8  =  T_unsigned_char;
     P_ARUint8  = ^T_ARUint8;
    PP_ARUint8  = ^P_ARUint8;
type T_ARUint16 =  T_unsigned_short;
     P_ARUint16 = ^T_ARUint16;
    PP_ARUint16 = ^P_ARUint16;
type T_ARUint32 =  T_unsigned_int;
     P_ARUint32 = ^T_ARUint32;
    PP_ARUint32 = ^P_ARUint32;
type T_ARfloat  =  T_float;
     P_ARfloat  = ^T_ARfloat;
    PP_ARfloat  = ^P_ARfloat;
{$IFDEF ARDOUBLE_IS_FLOAT }
type T_ARdouble =  T_float;
     P_ARdouble = ^T_ARdouble;
    PP_ARdouble = ^P_ARdouble;
{$ELSE}
type T_ARdouble =  T_double;
     P_ARdouble = ^T_ARdouble;
    PP_ARdouble = ^P_ARdouble;
{$ENDIF}

type T_ARdouble02 = array of array [ 0..2-1 ] of T_ARdouble;
type T_ARdouble03 = array of array [ 0..3-1 ] of T_ARdouble;
type T_ARdouble16 = array [ 0..16-1 ] of T_ARdouble;
type T_ARdouble34 = array [ 0..3-1, 0..4-1 ] of T_ARdouble;
type T_ARdouble43 = array [ 0..4-1, 0..3-1 ] of T_ARdouble;
type T_float34    = array [ 0..3-1, 0..4-1 ] of T_float;
type T_ARdouble26 = array [ 0..2-1, 0..6-1 ] of T_ARdouble;
type T_ARdouble6 = array [ 0..6-1 ] of T_ARdouble;
type T_int4 = array [ 0..4-1 ] of T_int;
type T_ARdouble42 = array [ 0..4-1, 0..2-1 ] of T_ARdouble;
type T_ARdouble2 = array [ 0..2-1 ] of T_ARdouble;
type T_ARdouble3 = array [ 0..3-1 ] of T_ARdouble;
type T_ARdouble4 = array [ 0..4-1 ] of T_ARdouble;

implementation //############################################################### ■

end. //######################################################################### ■
