unit LUX.Vision.ARToolKit.config;

(*
 *  config.h
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
 *  Author(s): Hirokazu Kato, Philip Lamb
 *
 *)
(*!
    @file config.h
    @brief ARToolKit core configuration.
    @version 5.3.2
    @details
    @copyright 2015-2016 Daqri, LLC.
 *)

interface //#################################################################### ■

//
// As of version 2.72 and 4.1, ARToolKit supports an OpenGL-like
// versioning system, with both header versions (for the version
// of the ARToolKit SDK installed) and runtime version reporting
// via arGetVersion().
//

(*@
    The MAJOR version number defines non-backwards compatible
    changes in the ARToolKit API. Range: [0-99].
 *)
const AR_HEADER_VERSION_MAJOR = 5;

(*@
    The MINOR version number defines additions to the ARToolKit
    API, or (occsasionally) other significant backwards-compatible
    changes in runtime functionality. Range: [0-99].
 *)
const AR_HEADER_VERSION_MINOR = 4;

(*@
    The TINY version number defines bug-fixes to existing
    functionality. Range: [0-99].
 *)
const AR_HEADER_VERSION_TINY = 0;

(*@
    The BUILD version number will always be zero in releases,
    but may be non-zero in post-release development builds,
    version-control repository-sourced code, or other. Range: [0-99].
 *)
const AR_HEADER_VERSION_DEV = 0;

(*@
    The string representation below must match the major, minor
    and tiny release numbers.
 *)
const AR_HEADER_VERSION_STRING = '5.4.0';

(*@
    Convenience macros to enable use of certain ARToolKit header
    functionality by the release version in which it appeared.
    Each time the major version number is incremented, all
    existing macros must be removed, and just one new one
    added for the new major version.
    Each time the minor version number is incremented, a new
    AR_HAVE_HEADER_VERSION_ macro definition must be added.
    Tiny version numbers (being bug-fix releases, by definition)
    are NOT included in the AR_HAVE_HEADER_VERSION_ system.
 *)
{$DEFINE AR_HAVE_HEADER_VERSION_5 }
{$DEFINE AR_HAVE_HEADER_VERSION_5_1 }
{$DEFINE AR_HAVE_HEADER_VERSION_5_2 }
{$DEFINE AR_HAVE_HEADER_VERSION_5_3 }
{$DEFINE AR_HAVE_HEADER_VERSION_5_4 }

//
// End version definitions.
//

(*
#undef   AR_BIG_ENDIAN
#undef   AR_LITTLE_ENDIAN
*)

(*!
    @typedef AR_PIXEL_FORMAT
    @brief ARToolKit pixel-format specifiers.
    @details
        ARToolKit functions can accept pixel data in a variety of formats.
        This enumerations provides a set of constants you can use to request
        data in a particular pixel format from an ARToolKit function that
        returns data to you, or to specify that data you are providing to an
        ARToolKit function is in a particular pixel format.
 *)
typedef enum {
    (*@
        Value indicating pixel format is invalid or unset.
     *)
    AR_PIXEL_FORMAT_INVALID = -1,
    (*@
        Each pixel is represented by 24 bits. Eight bits per each Red, Green,
        and Blue component. This is the native 24 bit format for the Mac platform.
     *)
    AR_PIXEL_FORMAT_RGB = 0,
    (*@
        Each pixel is represented by 24 bits. Eight bits per each Blue, Red, and
        Green component. This is the native 24 bit format for the Win32 platform.
     *)
    AR_PIXEL_FORMAT_BGR,
    (*@
        Each pixel is represented by 32 bits. Eight bits per each Red, Green,
        Blue, and Alpha component.
     *)
    AR_PIXEL_FORMAT_RGBA,
    (*@
        Each pixel is represented by 32 bits. Eight bits per each Blue, Green,
        Red, and Alpha component. This is the native 32 bit format for the Win32
        and Mac Intel platforms.
     *)
    AR_PIXEL_FORMAT_BGRA,
    (*@
        Each pixel is represented by 32 bits. Eight bits per each Alpha, Blue,
        Green, and Red component. This is the native 32 bit format for the SGI
        platform.
     *)
    AR_PIXEL_FORMAT_ABGR,
    (*@
        Each pixel is represented by 8 bits of luminance information.
     *)
    AR_PIXEL_FORMAT_MONO,
    (*@
        Each pixel is represented by 32 bits. Eight bits per each Alpha, Red,
        Green, and Blue component. This is the native 32 bit format for the Mac
        PowerPC platform.
     *)
    AR_PIXEL_FORMAT_ARGB,
    (*@
        8-bit 4:2:2 Component Y'CbCr format. Each 16 bit pixel is represented
        by an unsigned eight bit luminance component and two unsigned eight bit
        chroma components. Each pair of pixels shares a common set of chroma
        values. The components are ordered in memory; Cb, Y0, Cr, Y1. The
        luminance components have a range of [16, 235], while the chroma value
        has a range of [16, 240]. This is consistent with the CCIR601 spec.
        This format is fairly prevalent on both Mac and Win32 platforms.
        '2vuy' is the Apple QuickTime four-character code for this pixel format.
        The equivalent Microsoft fourCC is 'UYVY'.
     *)
    AR_PIXEL_FORMAT_2vuy,
    (*@
        8-bit 4:2:2 Component Y'CbCr format. Identical to the AR_PIXEL_FORMAT_2vuy except
        each 16 bit word has been byte swapped. This results in a component
        ordering of; Y0, Cb, Y1, Cr.
        This is most prevalent yuv 4:2:2 format on both Mac and Win32 platforms.
        'yuvs' is the Apple QuickTime four-character code for this pixel format.
        The equivalent Microsoft fourCC is 'YUY2'.
     *)
    AR_PIXEL_FORMAT_yuvs,
    (*@
        A packed-pixel format. Each 16 bit pixel consists of 5 bits of red color
        information in bits 15-11, 6 bits of green color information in bits 10-5,
        and 5 bits of blue color information in bits 4-0. Byte ordering is big-endian.
     *)
    AR_PIXEL_FORMAT_RGB_565,
    (*@
        A packed-pixel format. Each 16 bit pixel consists of 5 bits of red color
        information in bits 15-11, 5 bits of green color information in bits 10-6,
        5 bits of blue color information in bits 5-1, and a single alpha bit in bit 0.
        Byte ordering is big-endian.
     *)
    AR_PIXEL_FORMAT_RGBA_5551,
    (*@
        A packed-pixel format. Each 16 bit pixel consists of 4 bits of red color
        information in bits 15-12, 6 bits of green color information in bits 11-8,
        4 bits of blue color information in bits 7-4, and 4 bits of alpha information
        in bits 3-0. Byte ordering is big-endian.
     *)
    AR_PIXEL_FORMAT_RGBA_4444,
    (*@
         8-bit 4:2:0 Component Y'CbCr format. Each 2x2 pixel block is represented
         by 4 unsigned eight bit luminance values and two unsigned eight bit
         chroma values. The chroma plane and luma plane are separated in memory. The
         luminance components have a range of [16, 235], while the chroma value
         has a range of [16, 240]. This is consistent with the CCIR601 spec.
         '420v' is the Apple Core Video four-character code for this pixel format.
     *)
    AR_PIXEL_FORMAT_420v,
    (*@
         8-bit 4:2:0 Component Y'CbCr format. Each 2x2 pixel block is represented
         by 4 unsigned eight bit luminance components and two unsigned eight bit
         chroma components. The chroma plane and luma plane are separated in memory. The
         luminance components have a range of [0, 255], while the chroma value
         has a range of [1, 255].
         '420f' is the Apple Core Video four-character code for this pixel format.
         The equivalent Microsoft fourCC is 'NV12'.
     *)
    AR_PIXEL_FORMAT_420f,
    (*@
        8-bit 4:2:0 Component Y'CbCr format. Each 2x2 pixel block is represented
        by 4 unsigned eight bit luminance components and two unsigned eight bit
        chroma components. The chroma plane and luma plane are separated in memory. The
        luminance components have a range of [0, 255], while the chroma value
        has a range of [1, 255].
     *)
    AR_PIXEL_FORMAT_NV21
} AR_PIXEL_FORMAT;
const AR_PIXEL_FORMAT_UYVY = AR_PIXEL_FORMAT_2vuy;
const AR_PIXEL_FORMAT_YUY2 = AR_PIXEL_FORMAT_yuvs;

// Note if making changes to the above table:
// If the number of pixel formats supported changes, AR_PIXEL_FORMAT_MAX must too.
// The functions arVideoUtilGetPixelSize(), arVideoUtilGetPixelFormatName()
// and arUtilGetPixelSize() arUtilGetPixelFormatName() must also be edited.
const AR_PIXEL_FORMAT_MAX = AR_PIXEL_FORMAT_NV21;

//
//  For Linux
//

{$IFDEF EMSCRIPTEN }
  {$DEFINE __linux }
{$ENDIF}

{$IF defined( __linux ) and not defined( ANDROID ) }

{$DEFINE AR_CALLBACK }

// Determine architecture endianess using gcc's macro, or assume little-endian by default.
  {$IF ( __BYTE_ORDER__ = __ORDER_BIG_ENDIAN__ ) or defined( __BIG_ENDIAN__ ) }
    {$DEFINE AR_BIG_ENDIAN }  // Most Significant Byte has greatest address in memory (ppc).
    {$UNDEF AR_LITTLE_ENDIAN }
#  elif (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__) || defined (__LITTLE_ENDIAN__)
    {$UNDEF AR_BIG_ENDIAN }   // Least significant Byte has greatest address in memory (x86).
    {$DEFINE AR_LITTLE_ENDIAN }
  {$ELSE}
    {$DEFINE AR_LITTLE_ENDIAN }
  {$ENDIF}

// Input modules. This is edited by the configure script.
{$UNDEF ARVIDEO_INPUT_V4L2 }
{$UNDEF ARVIDEO_INPUT_1394CAM }
{$UNDEF ARVIDEO_INPUT_GSTREAMER }
{$UNDEF ARVIDEO_INPUT_IMAGE }
{$DEFINE ARVIDEO_INPUT_DUMMY }

// Default input module. This is edited by the configure script.
{$UNDEF ARVIDEO_INPUT_DEFAULT_V4L2 }
{$UNDEF ARVIDEO_INPUT_DEFAULT_1394 }
{$UNDEF ARVIDEO_INPUT_DEFAULT_GSTREAMER }
{$UNDEF ARVIDEO_INPUT_DEFAULT_IMAGE }
{$UNDEF ARVIDEO_INPUT_DEFAULT_DUMMY }

// Other Linux-only configuration.
const HAVE_LIBJPEG    = 1;
const HAVE_INTEL_SIMD = 1;

{$ENDIF} // __linux

// Default pixel formats.

{$IFDEF ARVIDEO_INPUT_V4L2 }
(* #define  ARVIDEO_INPUT_V4L2_DEFAULT_PIXEL_FORMAT   AR_PIXEL_FORMAT_BGR  *)
(* #define  ARVIDEO_INPUT_V4L2_DEFAULT_PIXEL_FORMAT   AR_PIXEL_FORMAT_BGRA *)
const ARVIDEO_INPUT_V4L2_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_BGR;
{$ENDIF}

{$IFDEF ARVIDEO_INPUT_1394CAM }
(* #define  ARVIDEO_INPUT_1394CAM_DEFAULT_PIXEL_FORMAT   AR_PIXEL_FORMAT_MONO *)
(* #define  ARVIDEO_INPUT_1394CAM_DEFAULT_PIXEL_FORMAT   AR_PIXEL_FORMAT_RGB  *)
const ARVIDEO_INPUT_1394CAM_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_MONO;
{$UNDEF ARVIDEO_INPUT_1394CAM_USE_DRAGONFLY }
{$UNDEF ARVIDEO_INPUT_1394CAM_USE_DF_EXPRESS }
{$UNDEF ARVIDEO_INPUT_1394CAM_USE_FLEA }
{$UNDEF ARVIDEO_INPUT_1394CAM_USE_FLEA_XGA }
{$UNDEF ARVIDEO_INPUT_1394CAM_USE_DFK21AF04 }
{$ENDIF}

{$IFDEF ARVIDEO_INPUT_GSTREAMER }
const ARVIDEO_INPUT_GSTREAMER_PIXEL_FORMAT = AR_PIXEL_FORMAT_RGB;
{$ENDIF}



//
//  For Windows                                              
//
{$IFDEF _WIN32 }

// Include Windows API.
{$IFNDEF WIN32_LEAN_AND_MEAN }
  {$DEFINE WIN32_LEAN_AND_MEAN } // Exclude rarely-used stuff from Windows headers
{$ENDIF}
#include <sdkddkver.h> // Minimum supported version. See http://msdn.microsoft.com/en-us/library/windows/desktop/aa383745.aspx
#include <windows.h>

#define AR_CALLBACK __stdcall
#define strdup _strdup
{$DEFINE LIBARVIDEO_DYNAMIC }

// Define _WINRT for support Windows Runtime platforms.
{$IF defined( WINAPI_FAMILY ) }
#  if (WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP) // Windows Phone 8.1 and later.
#    if (_WIN32_WINNT >= 0x0603) // (_WIN32_WINNT_WINBLUE)
      {$DEFINE _WINRT }
      {$UNDEF LIBARVIDEO_DYNAMIC }
      {$DEFINE ARDOUBLE_IS_FLOAT }
    {$ELSE}
#      error ARToolKit for Windows Phone requires Windows Phone 8.1 or later. Please compile with Visual Studio 2013 or later with Windows Phone 8.1 SDK installed and with _WIN32_WINNT=0x0603 in your project compiler settings (setting /D_WIN32_WINNT=0x0603).
    {$ENDIF}
#  elif (WINAPI_FAMILY == WINAPI_FAMILY_PC_APP) // Windows Store 8.1 and later.
#    if (_WIN32_WINNT >= 0x0603) // (_WIN32_WINNT_WINBLUE)
      {$DEFINE _WINRT }
      {$UNDEF LIBARVIDEO_DYNAMIC }
      {$DEFINE ARDOUBLE_IS_FLOAT }
    {$ELSE}
#      error ARToolKit for Windows Store requires Windows 8.1 or later. Please compile with Visual Studio 2013 or later with Windows 8.1 SDK installed and with _WIN32_WINNT=0x0603 in your project compiler settings (setting /D_WIN32_WINNT=0x0603).
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

// Endianness.
// Windows on x86, x86-64 and ARM all run little-endian.
{$UNDEF AR_BIG_ENDIAN }
{$DEFINE AR_LITTLE_ENDIAN }

// Input modules. This is edited by the configure script.
{$DEFINE ARVIDEO_INPUT_DUMMY }
{$UNDEF ARVIDEO_INPUT_IMAGE }
{$UNDEF ARVIDEO_INPUT_WINDOWS_MEDIA_FOUNDATION }
{$UNDEF ARVIDEO_INPUT_WINDOWS_MEDIA_CAPTURE }

// Default input module. This is edited by the configure script.
{$UNDEF ARVIDEO_INPUT_DEFAULT_DUMMY }
{$UNDEF ARVIDEO_INPUT_DEFAULT_IMAGE }
{$UNDEF ARVIDEO_INPUT_DEFAULT_WINDOWS_MEDIA_FOUNDATION }
{$UNDEF ARVIDEO_INPUT_DEFAULT_WINDOWS_MEDIA_CAPTURE }

// Other Windows-only configuration.
const HAVE_LIBJPEG = 1;

{$IF defined( _M_IX86 ) or defined( _M_X64 ) }
  const HAVE_INTEL_SIMD = 1;
#elif defined(_M_ARM)
  {$UNDEF HAVE_ARM_NEON } // MSVC doesn't support inline assembly on ARM platform.
{$ENDIF}

{$ENDIF} // _WIN32

// Default pixel formats.

{$IFDEF ARVIDEO_INPUT_WINDOWS_MEDIA_FOUNDATION }
const ARVIDEO_INPUT_WINDOWS_MEDIA_FOUNDATION_PIXEL_FORMAT = AR_PIXEL_FORMAT_BGRA;
{$ENDIF}

{$IFDEF ARVIDEO_INPUT_WINDOWS_MEDIA_CAPTURE }
const ARVIDEO_INPUT_WINDOWS_MEDIA_CAPTURE_PIXEL_FORMAT = AR_PIXEL_FORMAT_BGRA;
{$ENDIF}

//
//  For Android                                              
//    Note that Android NDK also defines __linux             
//

{$IF defined( ANDROID ) }

// Determine architecture endianess using gcc's macro, or assume little-endian by default.
  {$IF ( __BYTE_ORDER__ = __ORDER_BIG_ENDIAN__ ) or defined( __BIG_ENDIAN__ ) }
    {$DEFINE AR_BIG_ENDIAN }  // Most Significant Byte has greatest address in memory (ppc).
    {$UNDEF AR_LITTLE_ENDIAN }
#  elif (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__) || defined (__LITTLE_ENDIAN__)
    {$UNDEF AR_BIG_ENDIAN }   // Least significant Byte has greatest address in memory (x86).
    {$DEFINE AR_LITTLE_ENDIAN }
  {$ELSE}
    {$DEFINE AR_LITTLE_ENDIAN }
  {$ENDIF}

{$DEFINE AR_CALLBACK }
{$DEFINE ARDOUBLE_IS_FLOAT }

{$UNDEF ARVIDEO_INPUT_DUMMY }
{$DEFINE ARVIDEO_INPUT_ANDROID }
{$UNDEF ARVIDEO_INPUT_IMAGE }
{$UNDEF ARVIDEO_INPUT_DEFAULT_DUMMY }
{$DEFINE ARVIDEO_INPUT_DEFAULT_ANDROID }
{$UNDEF ARVIDEO_INPUT_DEFAULT_IMAGE }

const HAVE_LIBJPEG      = 1;
const USE_OPENGL_ES     = 1;
const USE_CPARAM_SEARCH = 1;

{$ENDIF} // _ANDROID

// Default pixel formats.

{$IFDEF ARVIDEO_INPUT_ANDROID }
const ARVIDEO_INPUT_ANDROID_PIXEL_FORMAT = AR_PIXEL_FORMAT_NV21;
{$ENDIF}

//
//  For macOS                                             
//
{$IF __APPLE__ }

#  include <TargetConditionals.h>
#  include <AvailabilityMacros.h>

  {$DEFINE AR_CALLBACK }

// Endianness.
  {$IF TARGET_RT_BIG_ENDIAN }
    {$DEFINE AR_BIG_ENDIAN }  // Most Significant Byte has greatest address in memory (ppc).
    {$UNDEF AR_LITTLE_ENDIAN }
#  elif TARGET_RT_LITTLE_ENDIAN
    {$UNDEF AR_BIG_ENDIAN }
    {$DEFINE AR_LITTLE_ENDIAN }
  {$ELSE}
#    error
  {$ENDIF}

{$IF TARGET_IPHONE_SIMULATOR }

#error This release does not support the simulator. Please target an iOS device.
{$DEFINE ARDOUBLE_IS_FLOAT }
{$DEFINE ARVIDEO_INPUT_DUMMY }
{$DEFINE ARVIDEO_INPUT_DEFAULT_DUMMY }

#elif TARGET_OS_IPHONE

{$DEFINE ARDOUBLE_IS_FLOAT }
{$DEFINE ARVIDEO_INPUT_AVFOUNDATION }
{$UNDEF ARVIDEO_INPUT_DUMMY }
{$DEFINE ARVIDEO_INPUT_IMAGE }
{$DEFINE ARVIDEO_INPUT_DEFAULT_AVFOUNDATION }
{$UNDEF ARVIDEO_INPUT_DEFAULT_DUMMY }
{$UNDEF ARVIDEO_INPUT_DEFAULT_IMAGE }
const HAVE_LIBJPEG  = 1;
const USE_OPENGL_ES = 1;
{$IFDEF __LP64__ }
  const HAVE_ARM64_NEON = 1;
{$ELSE}
  const HAVE_ARM_NEON = 1;
{$ENDIF}
const USE_CPARAM_SEARCH = 1;

#elif TARGET_OS_MAC

{$DEFINE ARVIDEO_INPUT_AVFOUNDATION }
{$DEFINE ARVIDEO_INPUT_DUMMY }
{$DEFINE ARVIDEO_INPUT_IMAGE }
{$DEFINE ARVIDEO_INPUT_DEFAULT_AVFOUNDATION }
{$UNDEF ARVIDEO_INPUT_DEFAULT_DUMMY }
{$UNDEF ARVIDEO_INPUT_DEFAULT_IMAGE }
const HAVE_LIBJPEG    = 1;
const HAVE_INTEL_SIMD = 1;

{$ENDIF}

{$ENDIF} // __APPLE__

// Default pixel formats.

{$IFDEF ARVIDEO_INPUT_AVFOUNDATION }
const ARVIDEO_INPUT_AVFOUNDATION_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_BGRA;
{$ENDIF}

//
//  Emscripten input                                         
//

{$IFDEF EMSCRIPTEN }
{$DEFINE ARVIDEO_INPUT_DEFAULT_EMSCRIPTEN }
const ARVIDEO_INPUT_EMSCRIPTEN_PIXEL_FORMAT = AR_PIXEL_FORMAT_RGBA;
{$ENDIF}

//
//  Multi-platform inputs
//

{$IFDEF ARVIDEO_INPUT_DUMMY }
const ARVIDEO_INPUT_DUMMY_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_RGB;
{$ENDIF}

{$IFDEF ARVIDEO_INPUT_IMAGE }
const ARVIDEO_INPUT_IMAGE_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_RGB;
{$ENDIF}

//
// Setup AR_DEFAULT_PIXEL_FORMAT.
//
 
{$IF defined( ARVIDEO_INPUT_DEFAULT_DUMMY ) }
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_DUMMY_DEFAULT_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_V4L2)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_V4L2_DEFAULT_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_1394)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_1394CAM_DEFAULT_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_GSTREAMER)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_GSTREAMER_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_AVFOUNDATION)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_AVFOUNDATION_DEFAULT_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_ANDROID)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_ANDROID_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_IMAGE)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_IMAGE_DEFAULT_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_WINDOWS_MEDIA_FOUNDATION)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_WINDOWS_MEDIA_FOUNDATION_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_WINDOWS_MEDIA_CAPTURE)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_WINDOWS_MEDIA_CAPTURE_PIXEL_FORMAT;
#elif defined(ARVIDEO_INPUT_DEFAULT_EMSCRIPTEN)
  const AR_DEFAULT_PIXEL_FORMAT = ARVIDEO_INPUT_EMSCRIPTEN_PIXEL_FORMAT;
{$ELSE}
#  error
{$ENDIF}

//
// If trying to minimize memory footprint, disable a few things.
//

{$IF AR_ENABLE_MINIMIZE_MEMORY_FOOTPRINT }
const AR_DISABLE_THRESH_MODE_AUTO_ADAPTIVE = 1;
const AR_DISABLE_NON_CORE_FNS              = 1;
const AR_DISABLE_LABELING_DEBUG_MODE       = 1;
{$ENDIF}

implementation //############################################################### ■

end. //######################################################################### ■
