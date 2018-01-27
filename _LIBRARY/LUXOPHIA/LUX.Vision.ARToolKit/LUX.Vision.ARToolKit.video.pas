unit LUX.Vision.ARToolKit.video;

(*
 *  video.h
 *  ARToolKit5
 *
 *  This file is part of ARToolKit.
 *
 *  ARToolKit is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  ARToolKit is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with ARToolKit.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  As a special exception, the copyright holders of this library give you
 *  permission to link this library with independent modules to produce an
 *  executable, regardless of the license terms of these independent modules, and to
 *  copy and distribute the resulting executable under terms of your choice,
 *  provided that you also meet, for each linked independent module, the terms and
 *  conditions of the license of that module. An independent module is a module
 *  which is neither derived from nor based on this library. If you modify this
 *  library, you may extend this exception to your version of the library, but you
 *  are not obligated to do so. If you do not wish to do so, delete this exception
 *  statement from your version.
 *
 *  Copyright 2015-2016 Daqri, LLC.
 *  Copyright 2002-2015 ARToolworks, Inc.
 *
 *  Author(s): Hirokazu Kato, Atsishi Nakazawa, Philip Lamb
 *
 *)
(*
 *
 * Author: Hirokazu Kato, Atsishi Nakazawa
 *
 *         kato@sys.im.hiroshima-cu.ac.jp
 *         nakazawa@inolab.sys.es.osaka-u.ac.jp
 *
 * Revision: 4.3
 * Date: 2002/01/01
 *
 *)

interface //#################################################################### ■

uses LUX.Code.C,
     LUX.Vision.ARToolKit.ar,
     LUX.Vision.ARToolKit.videoConfig;
//#include <limits.h>

type T_AR_VIDEO_MODULE = (
       AR_VIDEO_MODULE_DUMMY                    = 0,
       AR_VIDEO_MODULE_RESERVED1                = 1,
       AR_VIDEO_MODULE_RESERVED2                = 2,
       AR_VIDEO_MODULE_1394                     = 3,
       AR_VIDEO_MODULE_RESERVED4                = 4,
       AR_VIDEO_MODULE_RESERVED5                = 5,
       AR_VIDEO_MODULE_RESERVED6                = 6,
       AR_VIDEO_MODULE_RESERVED7                = 7,
       AR_VIDEO_MODULE_RESERVED8                = 8,
       AR_VIDEO_MODULE_RESERVED9                = 9,
       AR_VIDEO_MODULE_RESERVED10               = 10,
       AR_VIDEO_MODULE_GSTREAMER                = 11,
       AR_VIDEO_MODULE_AVFOUNDATION             = 12,
       AR_VIDEO_MODULE_RESERVED13               = 13,
       AR_VIDEO_MODULE_IMAGE                    = 14,
       AR_VIDEO_MODULE_ANDROID                  = 15,
       AR_VIDEO_MODULE_WINDOWS_MEDIA_FOUNDATION = 16,
       AR_VIDEO_MODULE_WINDOWS_MEDIA_CAPTURE    = 17,
       AR_VIDEO_MODULE_V4L2                     = 18,
       AR_VIDEO_MODULE_MAX                      = 18
     );

//
// arVideoParamGet/arVideoParamSet names.
//

const AR_VIDEO_1394_BRIGHTNESS               = 65;
const AR_VIDEO_1394_BRIGHTNESS_FEATURE_ON    = 66;
const AR_VIDEO_1394_BRIGHTNESS_AUTO_ON       = 67;
const AR_VIDEO_1394_BRIGHTNESS_MAX_VAL       = 68;
const AR_VIDEO_1394_BRIGHTNESS_MIN_VAL       = 69;
const AR_VIDEO_1394_EXPOSURE                 = 70;
const AR_VIDEO_1394_EXPOSURE_FEATURE_ON      = 71;
const AR_VIDEO_1394_EXPOSURE_AUTO_ON         = 72;
const AR_VIDEO_1394_EXPOSURE_MAX_VAL         = 73;
const AR_VIDEO_1394_EXPOSURE_MIN_VAL         = 74;
const AR_VIDEO_1394_WHITE_BALANCE            = 75;
const AR_VIDEO_1394_WHITE_BALANCE_UB         = 76;
const AR_VIDEO_1394_WHITE_BALANCE_VR         = 77;
const AR_VIDEO_1394_WHITE_BALANCE_FEATURE_ON = 78;
const AR_VIDEO_1394_WHITE_BALANCE_AUTO_ON    = 79;
const AR_VIDEO_1394_WHITE_BALANCE_MAX_VAL    = 80;
const AR_VIDEO_1394_WHITE_BALANCE_MIN_VAL    = 81;
const AR_VIDEO_1394_SHUTTER_SPEED            = 82;
const AR_VIDEO_1394_SHUTTER_SPEED_FEATURE_ON = 83;
const AR_VIDEO_1394_SHUTTER_SPEED_AUTO_ON    = 84;
const AR_VIDEO_1394_SHUTTER_SPEED_MAX_VAL    = 85;
const AR_VIDEO_1394_SHUTTER_SPEED_MIN_VAL    = 86;
const AR_VIDEO_1394_GAIN                     = 87;
const AR_VIDEO_1394_GAIN_FEATURE_ON          = 88;
const AR_VIDEO_1394_GAIN_AUTO_ON             = 89;
const AR_VIDEO_1394_GAIN_MAX_VAL             = 90;
const AR_VIDEO_1394_GAIN_MIN_VAL             = 91;
const AR_VIDEO_1394_FOCUS                    = 92;
const AR_VIDEO_1394_FOCUS_FEATURE_ON         = 93;
const AR_VIDEO_1394_FOCUS_AUTO_ON            = 94;
const AR_VIDEO_1394_FOCUS_MAX_VAL            = 95;
const AR_VIDEO_1394_FOCUS_MIN_VAL            = 96;
const AR_VIDEO_1394_GAMMA                    = 97;
const AR_VIDEO_1394_GAMMA_FEATURE_ON         = 98;
const AR_VIDEO_1394_GAMMA_AUTO_ON            = 99;
const AR_VIDEO_1394_GAMMA_MAX_VAL            = 100;
const AR_VIDEO_1394_GAMMA_MIN_VAL            = 101;

const AR_VIDEO_PARAM_GET_IMAGE_ASYNC = 200; ///< int
const AR_VIDEO_PARAM_DEVICEID        = 201; ///< string, readonly.

const AR_VIDEO_FOCUS_MODE                = 301; ///< int
const AR_VIDEO_FOCUS_MANUAL_DISTANCE     = 302; ///< double
const AR_VIDEO_FOCUS_POINT_OF_INTEREST_X = 303; ///< double
const AR_VIDEO_FOCUS_POINT_OF_INTEREST_Y = 304; ///< double

const AR_VIDEO_PARAM_AVFOUNDATION_IOS_DEVICE              = 400; ///< int, values from enumeration AR_VIDEO_AVFOUNDATION_IOS_DEVICE.
const AR_VIDEO_PARAM_AVFOUNDATION_FOCUS_PRESET            = 401; ///< int, values from enumeration AR_VIDEO_AVFOUNDATION_FOCUS_PRESET.
const AR_VIDEO_PARAM_AVFOUNDATION_CAMERA_POSITION         = 402; ///< int, values from enumeration AR_VIDEO_AVFOUNDATION_CAMERA_POSITION.
const AR_VIDEO_PARAM_AVFOUNDATION_WILL_CAPTURE_NEXT_FRAME = 403; ///< int (0=false, 1=true). If true, next incoming frame will also be captured to system's camera roll.

const AR_VIDEO_PARAM_ANDROID_CAMERA_INDEX   = 500; ///< int
const AR_VIDEO_PARAM_ANDROID_CAMERA_FACE    = 501; ///< int
const AR_VIDEO_PARAM_ANDROID_INTERNET_STATE = 502; ///< int
const AR_VIDEO_PARAM_ANDROID_FOCAL_LENGTH   = 503; ///< double

const AR_VIDEO_GET_VERSION = INT_MAX;

// For arVideoParamGet(AR_VIDEO_FOCUS_MODE, ...)
const AR_VIDEO_FOCUS_MODE_FIXED             = 0;
const AR_VIDEO_FOCUS_MODE_AUTO              = 1;
const AR_VIDEO_FOCUS_MODE_POINT_OF_INTEREST = 2;
const AR_VIDEO_FOCUS_MODE_MANUAL            = 3;

///
/// @brief Values returned by arVideoParamGeti(AR_VIDEO_PARAM_AVFOUNDATION_IOS_DEVICE, ...)
///
type T_AR_VIDEO_AVFOUNDATION_IOS_DEVICE = (
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE3G        = 1,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE3GS          ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE4            ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPODTOUCH4         ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPAD2              ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPAD3              ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE_GENERIC     ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPOD_GENERIC       ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPAD_GENERIC       ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE4S           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_APPLETV_GENERIC    ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE5            ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPODTOUCH5         ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPAD4              ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADMINI           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE5C           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE5S           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADAIR            ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADMINI2          ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADMINI3          ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADMINI4          ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADAIR2           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE6            ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE6PLUS        ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE6S           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE6SPLUS       ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONESE           ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADPRO129         ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE7            ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPHONE7PLUS        ,
       AR_VIDEO_AVFOUNDATION_IOS_DEVICE_IPADPRO97
     );

///
/// @brief Values returned by arVideoParamGeti/arVideoParamSeti(AR_VIDEO_PARAM_AVFOUNDATION_FOCUS_PRESET, ...)
///
type T_AR_VIDEO_AVFOUNDATION_FOCUS_PRESET = (
       AR_VIDEO_AVFOUNDATION_FOCUS_NONE  = 0, ///< No focus preset set.
       AR_VIDEO_AVFOUNDATION_FOCUS_MACRO    , ///< Focus preset to camera's shortest macro setting.
       AR_VIDEO_AVFOUNDATION_FOCUS_0_3M     , ///< Focus preset to 0.3 metres.
       AR_VIDEO_AVFOUNDATION_FOCUS_1_0M     , ///< Focus preset to 1.0 metres.
       AR_VIDEO_AVFOUNDATION_FOCUS_INF        ///< Focus preset to optical infinity.
     );

///
/// @brief Values returned by arVideoParamGeti(AR_VIDEO_PARAM_AVFOUNDATION_CAMERA_POSITION, ...)
///
type T_AR_VIDEO_AVFOUNDATION_CAMERA_POSITION = (
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_UNKNOWN            = -1,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_UNSPECIFIED        =  0,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_REAR                   ,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_FRONT                  ,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_REAR_STEREO_LEFT       ,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_REAR_STEREO_RIGHT      ,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_FRONT_STEREO_LEFT      ,
       AR_VIDEO_AVFOUNDATION_CAMERA_POSITION_FRONT_STEREO_RIGHT
     );

///
/// @brief Values returned by  arVideoParamGeti(AR_VIDEO_PARAM_ANDROID_CAMERA_FACE, ...)
///
type T_AR_VIDEO_ANDROID_CAMERA_FACE = (
       AR_VIDEO_ANDROID_CAMERA_FACE_REAR  = 0,
       AR_VIDEO_ANDROID_CAMERA_FACE_FRONT
     );

///
/// @brief Values for device position, as encoded in ARVideoSourceInfoT.flags & AR_VIDEO_SOURCE_INFO_POSITION_MASK.
///
const AR_VIDEO_POSITION_UNKNOWN = $0000; ///< Camera physical position on device unknown.
const AR_VIDEO_POSITION_FRONT   = $0008; ///< Camera is on front of device pointing towards user.
const AR_VIDEO_POSITION_BACK    = $0010; ///< Camera is on back of device pointing away from user.
const AR_VIDEO_POSITION_LEFT    = $0018; ///< Camera is on left of device pointing to user's left.
const AR_VIDEO_POSITION_RIGHT   = $0020; ///< Camera is on right of device pointing to user's right.
const AR_VIDEO_POSITION_TOP     = $0028; ///< Camera is on top of device pointing toward ceiling when device is held upright.
const AR_VIDEO_POSITION_BOTTOM  = $0030; ///< Camera is on bottom of device pointing towards floor when device is held upright.
const AR_VIDEO_POSITION_OTHER   = $0038; ///< Camera physical position on device is known but none of the above.

///
/// @brief Values for device stereo mode, as encoded in ARVideoSourceInfoT.flags & AR_VIDEO_SOURCE_INFO_STEREO_MODE_MASK.
///
const AR_VIDEO_STEREO_MODE_MONO                      = $0000; ///< Device is monoscopic.
const AR_VIDEO_STEREO_MODE_LEFT                      = $0040; ///< Device is left eye of a stereoscopic pair.
const AR_VIDEO_STEREO_MODE_RIGHT                     = $0080; ///< Device is right eye of a stereoscopic pair.
const AR_VIDEO_STEREO_MODE_FRAME_SEQUENTIAL          = $00C0; ///< Device is left and right stereo images in sequential frames.
const AR_VIDEO_STEREO_MODE_SIDE_BY_SIDE              = $0100; ///< Device is left and right stereo images in a single frame, arranged horizontally with left eye on left.
const AR_VIDEO_STEREO_MODE_OVER_UNDER                = $0140; ///< Device is left and right stereo images in a single frame, arranged vertically with left eye on top.
const AR_VIDEO_STEREO_MODE_HALF_SIDE_BY_SIDE         = $0180; ///< Device is left and right stereo images in a single frame with the frames scaled to half-width, arranged horizontally with left eye on left.
const AR_VIDEO_STEREO_MODE_OVER_UNDER_HALF_HEIGHT    = $01C0; ///< Device is left and right stereo images in a single frame with the frames scaled to half-height, arranged vertically with left eye on top.
const AR_VIDEO_STEREO_MODE_ROW_INTERLACED            = $0200; ///< Device is left and right stereo images in a single frame with row interleaving, where pixels in even-numbered rows are sampled from the left eye, and pixels in odd-number rows from the right eye.
const AR_VIDEO_STEREO_MODE_COLUMN_INTERLACED         = $0240; ///< Device is left and right stereo images in a single frame with column interleaving, where pixels in even-numbered columns are sampled from the left eye, and pixels in odd-number columns from the right eye.
const AR_VIDEO_STEREO_MODE_ROW_AND_COLUMN_INTERLACED = $0280; ///< Device is left and right stereo images in a single frame with row and column interleaving, where pixels where the evenness/oddness of the row is the same as the column are sampled from the left eye, and the remaining pixels from the right eye.
const AR_VIDEO_STEREO_MODE_ANAGLYPH_RG               = $02C0; ///< Device is left and right stereo images in a single frame, where both eyes are converted to mono and the left eye is carried in the red channel and the right eye in the green channel.
const AR_VIDEO_STEREO_MODE_ANAGLYPH_RB               = $0300; ///< Device is left and right stereo images in a single frame, where both eyes are converted to mono and the left eye is carried in the red channel and the right eye in the blue channel.
const AR_VIDEO_STEREO_MODE_RESERVED0                 = $0340; ///< Reserved for future use.
const AR_VIDEO_STEREO_MODE_RESERVED1                 = $0380; ///< Reserved for future use.
const AR_VIDEO_STEREO_MODE_RESERVED2                 = $03C0; ///< Reserved for future use.

///
/// @brief Values for ARVideoSourceInfoT.flags.
///
const AR_VIDEO_SOURCE_INFO_FLAG_OFFLINE     = $0001;      ///< 0 = unknown or not offline, 1 = offline.
const AR_VIDEO_SOURCE_INFO_FLAG_IN_USE      = $0002;      ///< 0 = unknown or not in use, 1 = in use.
const AR_VIDEO_SOURCE_INFO_FLAG_OPEN_ASYNC  = $0004;      ///< 0 = open normally, 1 = open async.
const AR_VIDEO_SOURCE_INFO_POSITION_MASK    = $0038;      ///< compare (value & AR_VIDEO_SOURCE_INFO_POSITION_MASK) against enums.
const AR_VIDEO_SOURCE_INFO_STEREO_MODE_MASK = $03C0;      ///< compare (value & AR_VIDEO_SOURCE_INFO_STEREO_MODE_MASK) against enums.

///
/// @brief Values describing a video source.
///
type T_ARVideoSourceInfoT = record
       name       :P_char;     ///< UTF-8 encoded string representing the name of the source, in a form suitable for presentation to an end-user, e.g. in a list of inputs.
       model      :P_char;     ///< UTF-8 encoded string representing the model of the source, where this information is available. May be NULL if model information is not attainable.
       UID        :P_char;     ///< UTF-8 encoded string representing a unique ID for this source, and suitable for passing to arVideoOpen/ar2VideoOpen as a UID in the configuration. May be NULL if sources cannot be uniquely identified.
       flags      :T_uint32_t;
       open_token :P_char;     ///< UTF-8 encoded string containing the token that should be passed (in the space-separated list of tokens to arVideoOpen/ar2VideoOpen, in order to select this source to be opened. Note that this token is only valid so long as the underlying video hardware configuration does not change, so should not be stored between sessions.
     end;

///
/// @brief Values describing a list of video sources.
///
type T_ARVideoSourceInfoListT = record
       count :T_int;
       info  :P_ARVideoSourceInfoT;
     end;

typedef void (*AR_VIDEO_FRAME_READY_CALLBACK)(void *);

{$IFDEF _WIN32 }
  {$IFDEF LIBARVIDEO_DYNAMIC }
    {$IFDEF LIBARVIDEO_EXPORTS }
      //#define AR_DLL_API __declspec(dllexport)
    {$ELSE}
      //#define AR_DLL_API __declspec(dllimport)
    {$ENDIF}
  {$ELSE}
    //#define AR_DLL_API extern
  {$ENDIF}
{$ELSE}
  {$DEFINE AR_DLL_API }
{$ENDIF}

//#include <AR/videoLuma.h>

type T_AR2VideoParamT = record
       module      :T_int;
       moduleParam :P_void;
       lumaInfo    :P_ARVideoLumaInfo;
     end;

function arVideoGetDefaultModule(void) :T_AR_VIDEO_MODULE; stdcall; external _DLLNAME_;
function arVideoOpen(const char *config) :T_int; stdcall; external _DLLNAME_;
function arVideoOpenAsync(const char *config, void (*callback)(void *), void *userdata) :T_int; stdcall; external _DLLNAME_;
function arVideoClose(void) :T_int; stdcall; external _DLLNAME_;
function arVideoDispOption(void) :T_int; stdcall; external _DLLNAME_;
function arVideoGetModule(void) :T_AR_VIDEO_MODULE; stdcall; external _DLLNAME_;
function arVideoGetId(ARUint32 *id0, ARUint32 *id1) :T_int; stdcall; external _DLLNAME_;
function arVideoGetSize(int *x, int *y) :T_int; stdcall; external _DLLNAME_;
function arVideoGetPixelSize(void) :T_int; stdcall; external _DLLNAME_;
function arVideoGetPixelFormat(void) :T_AR_PIXEL_FORMAT; stdcall; external _DLLNAME_;

(*!
    @brief Get a frame image from the video module.
    @return NULL if no image was available, or a pointer to an AR2VideoBufferT holding the image.
        The returned pointer remains valid until either the next call to arVideoGetImage, or a
        call to arVideoCapStop.
 *)
function arVideoGetImage(void) :P_AR2VideoBufferT; stdcall; external _DLLNAME_;

(*!
    @brief Start video capture.
    @detail Each call to arVideoCapStart must be balanced with a call to arVideoCapStop.
    @see arVideoCapStop
 *)
function arVideoCapStart(void) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Start video capture with asynchronous notification of new frame arrival.
    @param callback A function to call when a new frame arrives. This function may be
        called anytime until the function arVideoCapStop has been called successfully.
        The callback may occur on a different thread to the calling thread and it is
        up to the user to synchronise the callback with any procedures that must run
        on the main thread, a rendering thread, or other arbitrary thread.
    @param userdata Optional user data pointer which will be passed to the callback as a parameter. May be NULL.
 *)
function arVideoCapStartAsync(AR_VIDEO_FRAME_READY_CALLBACK callback, void *userdata) :T_int; stdcall; external _DLLNAME_;


(*!
    @brief Stop video capture.
    @detail Each call to arVideoCapStop must match a call to arVideoCapStart.
    @see arVideoCapStart
 *)
function arVideoCapStop(void) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Get value of an integer parameter from active video module.
    @param paramName Name of parameter to get, as defined in <AR/video.h>
    @param value Pointer to integer, which will be filled with the value of the parameter.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoGetParami(int paramName, int *value) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Set value of an integer parameter in active video module.
    @param paramName Name of parameter to set, as defined in <AR/video.h>
    @param value Integer value to set the parameter to.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoSetParami(int paramName, int  value) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Get value of a double-precision floating-point parameter from active video module.
    @param paramName Name of parameter to get, as defined in <AR/video.h>
    @param value Pointer to double, which will be filled with the value of the parameter.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoGetParamd(int paramName, double *value) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Set value of a double-precision floating-point parameter in active video module.
    @param paramName Name of parameter to set, as defined in <AR/video.h>
    @param value Double value to set the parameter to.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoSetParamd(int paramName, double  value) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Get value of a string parameter from active video module.
    @param paramName Name of parameter to get, as defined in <AR/video.h>
    @param value Pointer to pointer, which will be filled with a pointer to a C-string
        (nul-terminated, UTF-8) containing the value of the parameter. The string returned is
        allocated internally, and it is the responsibility of the caller to call free() on the
        returned value.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoGetParams(const int paramName, char **value) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Get value of a string parameter in active video module.
    @param paramName Name of parameter to set, as defined in <AR/video.h>
    @param value Pointer to C-string (nul-terminated, UTF-8) containing the value to set the parameter to.
    @return -1 in case of error, 0 in case of no error.
 *)
function arVideoSetParams(const int paramName, const char  *value) :T_int; stdcall; external _DLLNAME_;

function arVideoSaveParam(char *filename) :T_int; stdcall; external _DLLNAME_;
function arVideoLoadParam(char *filename) :T_int; stdcall; external _DLLNAME_;
function arVideoSetBufferSize(const int width, const int height) :T_int; stdcall; external _DLLNAME_;
function arVideoGetBufferSize(int *width, int *height) :T_int; stdcall; external _DLLNAME_;

function arVideoGetCParam(ARParam *cparam) :T_int; stdcall; external _DLLNAME_;
function arVideoGetCParamAsync  (void (*callback)(const ARParam *, void *), void *userdata) :T_int; stdcall; external _DLLNAME_;

function arVideoUtilGetPixelSize(const AR_PIXEL_FORMAT arPixelFormat) :T_int; stdcall; external _DLLNAME_;
function arVideoUtilGetPixelFormatName(const AR_PIXEL_FORMAT arPixelFormat) :P_char; stdcall; external _DLLNAME_;
{$IF not AR_ENABLE_MINIMIZE_MEMORY_FOOTPRINT }
function arVideoSaveImageJPEG(int w, int h, AR_PIXEL_FORMAT pixFormat, ARUint8 *pixels, const char *filename, const int quality (* 0 to 100 *), const int flipV) :T_int; stdcall; external _DLLNAME_;
{$ENDIF} // !AR_ENABLE_MINIMIZE_MEMORY_FOOTPRINT

type T_AR_VIDEO_ASPECT_RATIO = (
       AR_VIDEO_ASPECT_RATIO_1_1   ,  ///< 1.0:   "Square".
       AR_VIDEO_ASPECT_RATIO_11_9  ,  ///< 1.222: Equivalent to well-known sizes 176x144 (QCIF), 352x288 (CIF).
       AR_VIDEO_ASPECT_RATIO_5_4   ,  ///< 1.25:  Equivalent to well-known sizes 1280x1024 (SXGA), 2560x2048.
       AR_VIDEO_ASPECT_RATIO_4_3   ,  ///< 1.333: Equivalent to well-known sizes 320x240 (QVGA), 480x360, 640x480 (VGA), 768x576 (576p), 800x600 (SVGA), 960x720, 1024x768 (XGA), 1152x864, 1280x960, 1400x1050, 1600x1200, 2048x1536.
       AR_VIDEO_ASPECT_RATIO_3_2   ,  ///< 1.5:   Equivalent to well-known sizes 240x160, 480x320, 960x640, 720x480 (480p), 1152x768, 1280x854, 1440x960.
       AR_VIDEO_ASPECT_RATIO_14_9  ,  ///< 1.556:
       AR_VIDEO_ASPECT_RATIO_8_5   ,  ///< 1.6:   Equivalent to well-known sizes 320x200, 1280x800, 1440x900, 1680x1050, 1920x1200, 2560x1600.

       AR_VIDEO_ASPECT_RATIO_5_3   ,  ///< 1.667: Equivalent to well-known sizes 800x480, 1280x768, 1600x960.
       AR_VIDEO_ASPECT_RATIO_16_9  ,  ///< 1.778: "Widescreen". Equivalent to well-known sizes 1280x720 (720p), 1920x1080 (1080p).
       AR_VIDEO_ASPECT_RATIO_9_5   ,  ///< 1.8:   Equivalent to well-known sizes 864x480.
       AR_VIDEO_ASPECT_RATIO_17_9  ,  ///< 1.889: Equivalent to well-known sizes 2040x1080.
       AR_VIDEO_ASPECT_RATIO_21_9  ,  ///< 2.333: "Ultrawide". Equivalent to well-known sizes 2560x1080, 1280x512.
       AR_VIDEO_ASPECT_RATIO_UNIQUE   ///< Value not easily representable as a ratio of integers.
     );

(*!
    @brief Determine the approximate aspect ratio for a given image resolution.
    @details
        A convenience method which makes it easy to determine the approximate aspect ratio
        of an image with the given resolution (expressed in pixel width and height).
        Returns a symbolic constant for the aspect ratio, which makes it easy to determine
        whether two different resolutions have the same aspect ratio. Assumes square pixels.
    @param w Width in pixels
    @param h Height in pixels
    @result If a matching commonly-used aspect ratio can be found, returns symbolic constant for that aspect ratio.
*)
function arVideoUtilFindAspectRatio(int w, int h) :T_AR_VIDEO_ASPECT_RATIO; stdcall; external _DLLNAME_;

(*!
    @brief Determine the approximate aspect ratio for a given image resolution.
    @details
        A convenience method which makes it easy to determine the approximate aspect ratio
        of an image with the given resolution (expressed in pixel width and height).
        Returns a string for the aspect ratio. Assumes square pixels.
    @param w Width in pixels
    @param h Height in pixels
    @result If a matching commonly-used aspect ratio can be found, returns string name for that aspect ratio. This string must be free'd when finished with.
*)
function arVideoUtilFindAspectRatioName(int w, int h) :P_char; stdcall; external _DLLNAME_;

(*!
    @brief   Get the version of ARToolKit with which the arVideo library was built.
    @details
        It is highly recommended that
        any calling program that depends on features in a certain
        ARToolKit version, check at runtime that it is linked to a version
        of ARToolKit that can supply those features. It is NOT sufficient
        to check the ARToolKit SDK header versions, since with ARToolKit implemented
        in dynamically-loaded libraries, there is no guarantee that the
        version of ARToolKit installed on the machine at run-time will be as
        recent as the version of the ARToolKit SDK which the host
        program was compiled against.
    @result
        Returns the full version number of the ARToolKit version corresponding
        to this video library, in binary coded decimal (BCD) format.

        BCD format allows simple tests of version number in the caller
        e.g. if ((arGetVersion(NULL) >> 16) > 0x0272) printf("This release is later than 2.72\n");

        The major version number is encoded in the most-significant byte
        (bits 31-24), the minor version number in the second-most-significant
        byte (bits 23-16), the tiny version number in the third-most-significant
        byte (bits 15-8), and the build version number in the least-significant
        byte (bits 7-0).

        If the returned value is equal to -1, it can be assumed that the actual
        version is in the range 0x04000000 to 0x04040100.
    @since Available in ARToolKit v4.4.2 and later. The underlying
        functionality can also be used when compiling against earlier versions of
        ARToolKit (v4.0 to 4.4.1) with a slightly different syntax: replace
        "arVideoGetVersion()" in your code with "arVideoGetParami(AR_VIDEO_GET_VERSION, NULL)".
 *)
#define  arVideoGetVersion() arVideoGetParami(AR_VIDEO_GET_VERSION, NULL)

function ar2VideoCreateSourceInfoList(const char *config) :P_ARVideoSourceInfoListT; stdcall; external _DLLNAME_;
procedure ar2VideoDeleteSourceInfoList(ARVideoSourceInfoListT **p); stdcall; external _DLLNAME_;
function ar2VideoOpen(const char *config) :P_AR2VideoParamT; stdcall; external _DLLNAME_;
function ar2VideoOpenAsync(const char *config, void (*callback)(void *), void *userdata) :P_AR2VideoParamT; stdcall; external _DLLNAME_;
function ar2VideoClose(AR2VideoParamT *vid) :T_int; stdcall; external _DLLNAME_;
function ar2VideoDispOption(AR2VideoParamT *vid) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetModule(AR2VideoParamT *vid) :T_AR_VIDEO_MODULE; stdcall; external _DLLNAME_;
function ar2VideoGetId(AR2VideoParamT *vid, ARUint32 *id0, ARUint32 *id1) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetSize(AR2VideoParamT *vid, int *x,int *y) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetPixelSize(AR2VideoParamT *vid) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetPixelFormat(AR2VideoParamT *vid) :T_AR_PIXEL_FORMAT; stdcall; external _DLLNAME_;
function ar2VideoGetImage(AR2VideoParamT *vid) :P_AR2VideoBufferT; stdcall; external _DLLNAME_;
function ar2VideoCapStart(AR2VideoParamT *vid) :T_int; stdcall; external _DLLNAME_;
function ar2VideoCapStartAsync(AR2VideoParamT *vid, AR_VIDEO_FRAME_READY_CALLBACK callback, void *userdata) :T_int; stdcall; external _DLLNAME_;
function ar2VideoCapStop(AR2VideoParamT *vid) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetParami(AR2VideoParamT *vid, int paramName, int *value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoSetParami(AR2VideoParamT *vid, int paramName, int  value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetParamd(AR2VideoParamT *vid, int paramName, double *value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoSetParamd(AR2VideoParamT *vid, int paramName, double  value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetParams(AR2VideoParamT *vid, const int paramName, char **value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoSetParams(AR2VideoParamT *vid, const int paramName, const char  *value) :T_int; stdcall; external _DLLNAME_;
function ar2VideoSaveParam(AR2VideoParamT *vid, char *filename) :T_int; stdcall; external _DLLNAME_;
function ar2VideoLoadParam(AR2VideoParamT *vid, char *filename) :T_int; stdcall; external _DLLNAME_;
function ar2VideoSetBufferSize(AR2VideoParamT *vid, const int width, const int height) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetBufferSize(AR2VideoParamT *vid, int *width, int *height) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetCParam(AR2VideoParamT *vid, ARParam *cparam) :T_int; stdcall; external _DLLNAME_;
function ar2VideoGetCParamAsync  (AR2VideoParamT *vid, void (*callback)(const ARParam *, void *), void *userdata) :T_int; stdcall; external _DLLNAME_;


{$IF TARGET_PLATFORM_ANDROID }
// JNI interface.
jint ar2VideoPushInit(AR2VideoParamT *vid, JNIEnv *env, jobject obj, jint width, jint height, const char *pixelFormat, jint camera_index, jint camera_face);
jint ar2VideoPush1(AR2VideoParamT *vid, JNIEnv *env, jobject obj, jbyteArray buf, jint bufSize);
jint ar2VideoPush2(AR2VideoParamT *vid, JNIEnv *env, jobject obj,
                   jobject buf0, jint buf0PixelStride, jint buf0RowStride,
                   jobject buf1, jint buf1PixelStride, jint buf1RowStride,
                   jobject buf2, jint buf2PixelStride, jint buf2RowStride,
                   jobject buf3, jint buf3PixelStride, jint buf3RowStride);
jint ar2VideoPushFinal(AR2VideoParamT *vid, JNIEnv *env, jobject obj);
{$ENDIF} // TARGET_PLATFORM_ANDROID

implementation //############################################################### ■

end. //######################################################################### ■
