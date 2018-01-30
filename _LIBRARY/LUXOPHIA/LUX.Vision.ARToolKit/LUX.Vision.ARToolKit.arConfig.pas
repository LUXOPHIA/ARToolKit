unit LUX.Vision.ARToolKit.arConfig;

(*
 *  arConfig.h
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

(* for arDebug *)
const AR_DEBUG_DISABLE      = 0;
const AR_DEBUG_ENABLE       = 1;
const AR_DEFAULT_DEBUG_MODE = AR_DEBUG_DISABLE;

(* for arLabelingMode *)
const AR_LABELING_WHITE_REGION = 0;
const AR_LABELING_BLACK_REGION = 1;
const AR_DEFAULT_LABELING_MODE = AR_LABELING_BLACK_REGION;

(* for arlabelingThresh *)
const AR_DEFAULT_LABELING_THRESH = 100;

(* for arImageProcMode *)
const AR_IMAGE_PROC_FRAME_IMAGE  = 0;
const AR_IMAGE_PROC_FIELD_IMAGE  = 1;
const AR_DEFAULT_IMAGE_PROC_MODE = AR_IMAGE_PROC_FRAME_IMAGE;

(* for arPatternDetectionMode *)
const AR_TEMPLATE_MATCHING_COLOR            = 0;
const AR_TEMPLATE_MATCHING_MONO             = 1;
const AR_MATRIX_CODE_DETECTION              = 2;
const AR_TEMPLATE_MATCHING_COLOR_AND_MATRIX = 3;
const AR_TEMPLATE_MATCHING_MONO_AND_MATRIX  = 4;
const AR_DEFAULT_PATTERN_DETECTION_MODE     = AR_TEMPLATE_MATCHING_COLOR;

(* for arMarkerExtractionMode *)
const AR_USE_TRACKING_HISTORY           = 0;
const AR_NOUSE_TRACKING_HISTORY         = 1;
const AR_USE_TRACKING_HISTORY_V2        = 2;
const AR_DEFAULT_MARKER_EXTRACTION_MODE = AR_USE_TRACKING_HISTORY_V2;

(* for arGetTransMat *)
const AR_MAX_LOOP_COUNT    = 5;
const AR_LOOP_BREAK_THRESH = 0.5;

(* for arPatt**      *)
{$IF AR_ENABLE_MINIMIZE_MEMORY_FOOTPRINT }
const AR_PATT_NUM_MAX = 25;
{$ELSE}
const AR_PATT_NUM_MAX = 50;
{$ENDIF}
const AR_PATT_SIZE1            = 16;    // Default number of rows and columns in pattern when pattern detection mode is not AR_MATRIX_CODE_DETECTION. Must be 16 in order to be compatible with ARToolKit versions 1.0 to 5.1.6.
const AR_PATT_SIZE1_MAX        = 64;    // Maximum number of rows and columns allowed in pattern when pattern detection mode is not AR_MATRIX_CODE_DETECTION.
const AR_PATT_SIZE2_MAX        = 32;    // Maximum number of rows and columns allowed in pattern when pattern detection mode is AR_MATRIX_CODE_DETECTION.
const AR_PATT_SAMPLE_FACTOR1   = 4;     // Maximum number of samples per pattern pixel row / column when pattern detection mode is not AR_MATRIX_CODE_DETECTION.
const AR_PATT_SAMPLE_FACTOR2   = 3;     // Maximum number of samples per pattern pixel row / column when detection mode is AR_MATRIX_CODE_DETECTION.
const AR_PATT_CONTRAST_THRESH1 = 15.0;  // Required contrast over pattern space when pattern detection mode is AR_TEMPLATE_MATCHING_MONO or AR_TEMPLATE_MATCHING_COLOR.
const AR_PATT_CONTRAST_THRESH2 = 30.0;  // Required contrast between black and white barcode segments when pattern detection mode is AR_MATRIX_CODE_DETECTION.
const AR_PATT_RATIO            = 0.5;   // Default value for percentage of marker width or height considered to be pattern space. Equal to 1.0 - 2*borderSize. Must be 0.5 in order to be compatible with ARToolKit versions 1.0 to 4.4.

const AR_AREA_MAX          = 1000000;  // Maximum area (in pixels) of connected regions considered valid candidate for marker detection.
const AR_AREA_MIN          = 70;       // Minimum area (in pixels) of connected regions considered valid candidate for marker detection.
const AR_SQUARE_FIT_THRESH = 1.0;

const AR_LABELING_32_BIT = 0;  // 0 = 16 bits per label, 1 = 32 bits per label.
{$IF AR_LABELING_32_BIT = 1 }
const AR_LABELING_WORK_SIZE = 1024*32*16;
//type T_AR_LABELING_LABEL_TYPE = T_ARInt32;
//     P_AR_LABELING_LABEL_TYPE = ^T_AR_LABELING_LABEL_TYPE;
{$ELSE}
const AR_LABELING_WORK_SIZE = 1024*32;  // This number may not exceed 65535 when using 16-bits labels.
//type T_AR_LABELING_LABEL_TYPE = T_ARInt16;
//     P_AR_LABELING_LABEL_TYPE = ^T_AR_LABELING_LABEL_TYPE;
{$ENDIF}

{$IF AR_ENABLE_MINIMIZE_MEMORY_FOOTPRINT }
const AR_SQUARE_MAX = 30;  // Maxiumum number of marker squares per frame.
{$ELSE}
const AR_SQUARE_MAX = 60;  // Maxiumum number of marker squares per frame.
{$ENDIF}
const AR_CHAIN_MAX = 10000;

const AR_LABELING_THRESH_AUTO_INTERVAL_DEFAULT        = 7;  // Number of frames between auto-threshold calculations.
//const AR_LABELING_THRESH_MODE_DEFAULT                 = AR_LABELING_THRESH_MODE_MANUAL;
const AR_LABELING_THRESH_ADAPTIVE_KERNEL_SIZE_DEFAULT = 9;
const AR_LABELING_THRESH_ADAPTIVE_BIAS_DEFAULT        = -7;

const AR_CONFIDENCE_CUTOFF_DEFAULT = 0.5;
//const AR_MATRIX_CODE_TYPE_DEFAULT  = AR_MATRIX_CODE_3x3;

implementation //############################################################### ■

end. //######################################################################### ■
