﻿unit LUX.Vision.ARToolKit.videoConfig;

(*
 *  videoConfig.h
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
 *  Copyright 2015 Daqri, LLC.
 *  Copyright 2002-2015 ARToolworks, Inc.
 *
 *  Author(s): Hirokazu Kato, Philip Lamb
 *
 *)

interface //#################################################################### ■

uses LUX.Vision.ARToolKit.config;

{$IFDEF ARVIDEO_INPUT_V4L2 }
const AR_VIDEO_V4L2_MODE_PAL                  = 0;
const AR_VIDEO_V4L2_MODE_NTSC                 = 1;
const AR_VIDEO_V4L2_MODE_SECAM                = 2;
const AR_VIDEO_V4L2_DEFAULT_DEVICE            = '/dev/video0';
const AR_VIDEO_V4L2_DEFAULT_WIDTH             = 640;
const AR_VIDEO_V4L2_DEFAULT_HEIGHT            = 480;
const AR_VIDEO_V4L2_DEFAULT_CHANNEL           = 0;
const AR_VIDEO_V4L2_DEFAULT_MODE              = AR_VIDEO_V4L2_MODE_NTSC;
const AR_VIDEO_V4L2_DEFAULT_FORMAT_CONVERSION = AR_PIXEL_FORMAT_BGRA;  // Options include AR_PIXEL_FORMAT_INVALID for no conversion, AR_PIXEL_FORMAT_BGRA, and AR_PIXEL_FORMAT_RGBA.
{$ENDIF}


{$IFDEF ARVIDEO_INPUT_LIBDC1394 }
type T_AR_VIDEO_1394_MODE = (
       AR_VIDEO_1394_MODE_320x240_YUV422 = 32,
       AR_VIDEO_1394_MODE_640x480_YUV411,
       AR_VIDEO_1394_MODE_640x480_YUV411_HALF,
       AR_VIDEO_1394_MODE_640x480_YUV422,
       AR_VIDEO_1394_MODE_640x480_RGB,
       AR_VIDEO_1394_MODE_640x480_MONO,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR2,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR3,
       AR_VIDEO_1394_MODE_640x480_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_800x600_RGB,
       AR_VIDEO_1394_MODE_800x600_MONO,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR2,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR3,
       AR_VIDEO_1394_MODE_800x600_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1024x768_RGB,
       AR_VIDEO_1394_MODE_1024x768_MONO,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1024x768_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1280x720_RGB,
       AR_VIDEO_1394_MODE_1280x720_MONO,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1280x720_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1280x960_RGB,
       AR_VIDEO_1394_MODE_1280x960_MONO,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1280x960_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1280x1024_RGB,
       AR_VIDEO_1394_MODE_1280x1024_MONO,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1280x1024_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1600x900_RGB,
       AR_VIDEO_1394_MODE_1600x900_MONO,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1600x900_MONO_COLOR_HALF3,
       AR_VIDEO_1394_MODE_1600x1200_RGB,
       AR_VIDEO_1394_MODE_1600x1200_MONO,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR2,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF2,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR3,
       AR_VIDEO_1394_MODE_1600x1200_MONO_COLOR_HALF3
     );
const AR_VIDEO_1394_FRAME_RATE_1_875 = 1;
const AR_VIDEO_1394_FRAME_RATE_3_75  = 2;
const AR_VIDEO_1394_FRAME_RATE_7_5   = 3;
const AR_VIDEO_1394_FRAME_RATE_15    = 4;
const AR_VIDEO_1394_FRAME_RATE_30    = 5;
const AR_VIDEO_1394_FRAME_RATE_60    = 6;
const AR_VIDEO_1394_FRAME_RATE_120   = 7;
const AR_VIDEO_1394_FRAME_RATE_240   = 8;
const AR_VIDEO_1394_SPEED_400        = 1;
const AR_VIDEO_1394_SPEED_800        = 2;

{$IF ARVIDEO_INPUT_LIBDC1394_DEFAULT_PIXEL_FORMAT = AR_PIXEL_FORMAT_MONO }
  {$IF defined( ARVIDEO_INPUT_LIBDC1394_USE_FLEA_XGA ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_1024x768_MONO;
  {$ELSE}
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_MONO;
  {$ENDIF}
{$ELSE}
  {$IF defined( ARVIDEO_INPUT_LIBDC1394_USE_DRAGONFLY ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_MONO_COLOR;
  {$ELSEIF defined( ARVIDEO_INPUT_LIBDC1394_USE_DF_EXPRESS ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_MONO_COLOR2;
  {$ELSEIF defined( ARVIDEO_INPUT_LIBDC1394_USE_FLEA ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_MONO_COLOR2;
  {$ELSEIF defined( ARVIDEO_INPUT_LIBDC1394_USE_FLEA_XGA ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_1024x768_MONO_COLOR;
  {$ELSEIF defined( ARVIDEO_INPUT_LIBDC1394_USE_DFK21AF04 ) }
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_MONO_COLOR3;
  {$ELSE}
    const AR_VIDEO_1394_DEFAULT_MODE = AR_VIDEO_1394_MODE_640x480_YUV411;
  {$ENDIF}
{$ENDIF}
const AR_VIDEO_1394_DEFAULT_FRAME_RATE = AR_VIDEO_1394_FRAME_RATE_30;
const AR_VIDEO_1394_DEFAULT_SPEED      = AR_VIDEO_1394_SPEED_400;
const AR_VIDEO_1394_DEFAULT_PORT       = 0;
{$ENDIF}

implementation //############################################################### ■

end. //######################################################################### ■
