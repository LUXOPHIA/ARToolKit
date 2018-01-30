unit LUX.Vision.ARToolKit.ar;

(*
 *  ar.h
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
(*******************************************************
 *
 * Author: Hirokazu Kato
 *
 *         kato@sys.im.hiroshima-cu.ac.jp
 *
 * Revision: 4.01
 * Date: 2003/11/07
 *
 *******************************************************)

(*!
    @file ar.h
    @brief ARToolKit core routines.
    @details
        This header declares essential types and API for the entire
        ARToolKit SDK.

        For compile-time per-machine configuration, see &lt;AR/config.h&gt;.
        For compile-time ARToolKit configuration, see &lt;AR/arConfig.h&gt;.
    @copyright 2015-2016 Daqri, LLC.
 *)

interface //#################################################################### ■

//#include <stdio.h>
//#include <stdlib.h>
//#include <stdint.h>
//#include <string.h>
uses LUX.Code.C,
     LUX.Vision.ARToolKit.define,
     LUX.Vision.ARToolKit.icp,
     LUX.Vision.ARToolKit.config,
     LUX.Vision.ARToolKit.arConfig,
     LUX.Vision.ARToolKit.param,
     LUX.Vision.ARToolKit.arImageProc;
//{$IFDEF __ANDROID__ }
//#  include <jni.h>
//{$ENDIF}
//#include <ARUtil/log.h>

//{$IFDEF __cplusplus }
//extern "C" {
//{$ENDIF}


//#define arMalloc(V,T,S)  \
//{ if( ((V) = (T *)malloc( sizeof(T) * (S) )) == NULL ) \
//{ARLOGe("Out of memory!!\n"); exit(1);} }

//#define arMallocClear(V,T,S)  \
//{ if( ((V) = (T *)calloc( (S), sizeof(T) )) == NULL ) \
//{ARLOGe("Out of memory!!\n"); exit(1);} }

(*
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
*)

///// LUX.Vision.ARToolKit.arConfig
{$IF AR_LABELING_32_BIT = 1 }
type T_AR_LABELING_LABEL_TYPE = T_ARInt32;
     P_AR_LABELING_LABEL_TYPE = ^T_AR_LABELING_LABEL_TYPE;
{$ELSE}
type T_AR_LABELING_LABEL_TYPE = T_ARInt16;
     P_AR_LABELING_LABEL_TYPE = ^T_AR_LABELING_LABEL_TYPE;
{$ENDIF}

//{$IFNDEF TRUE }
//  const TRUE  = 1;
//{$ENDIF}
//{$IFNDEF FALSE }
//  const FALSE = 0;
//{$ENDIF}

//{$IFDEF __cplusplus }
//}
//{$ENDIF}

//#include <AR/matrix.h>
//#include <AR/icp.h>

//{$IFDEF __cplusplus }
//extern "C" {
//{$ENDIF}

(* --------------------------------------------------*)

(*!
    @brief A structure to hold a timestamp in seconds and microseconds, with arbitrary epoch.
 *)
type T_AR2VideoTimestampT = record
       sec  :T_uint64_t;
       usec :T_uint32_t;
     end;

(*!
    @brief A structure which carries information about a video frame retrieved by the video library.
    @see arVideoGetPixelFormat arVideoGetPixelFormat
 *)
type T_AR2VideoBufferT = record
       buff          :P_ARUint8;             ///< A pointer to the packed video data for this video frame. The video data pixel format is as specified by arVideoGetPixelFormat(). For multi-planar frames, this pointer is a copy of bufPlanes[0].
       bufPlanes     :PP_ARUint8;            ///< For multi-planar video frames, this must be an array of length bufPlaneCount of (ARUint8*), into which will be copied pointers to the packed video data for each plane. For single-plane formats, this will be NULL.
       bufPlaneCount :T_unsigned_int;        ///< For multi-planar video frames, this is the number of frame planes. For single-plane formats, this will be 0.
       buffLuma      :P_ARUint8;             ///< A pointer to a luminance-only version of the image. For luminance-only video formats this pointer is a copy of buff. For multi-planar formats which include a luminance-only plane, this pointer is a copy of one of the bufPlanes[] pointers. In all other cases, this pointer points to a buffer containing a copy of the video frame converted to luminance only.
       fillFlag      :T_int;                 ///< Set non-zero when buff is valid.
       time          :T_AR2VideoTimestampT;  ///< Time at which buff was filled.
     end;
     P_AR2VideoBufferT = ^T_AR2VideoBufferT;

(*!
    @brief Values controlling the labeling thresholding mode.
 *)
type T_AR_LABELING_THRESH_MODE = (
       AR_LABELING_THRESH_MODE_MANUAL          = 0, ///< Manual threshold selection via arSetLabelingThresh.
       AR_LABELING_THRESH_MODE_AUTO_MEDIAN        , ///< Automatic threshold selection via full-image histogram median.
       AR_LABELING_THRESH_MODE_AUTO_OTSU          , ///< Automatic threshold selection via Otsu's method for foreground/background selection.
       AR_LABELING_THRESH_MODE_AUTO_ADAPTIVE      , ///< Adaptive thresholding.
       AR_LABELING_THRESH_MODE_AUTO_BRACKETING      ///< Automatic threshold selection via heuristic-based exposure bracketing.
     );
     P_AR_LABELING_THRESH_MODE = ^T_AR_LABELING_THRESH_MODE;

///// LUX.Vision.ARToolKit.arConfig
const AR_LABELING_THRESH_MODE_DEFAULT = AR_LABELING_THRESH_MODE_MANUAL;

(*!
    @brief Captures detail of a trapezoidal region which is a candidate for marker detection.
 *)
type T_ARMarkerInfo2 = record
       area      :T_int;                                 ///< Area in pixels.
       pos       :array [ 0..2-1 ] of T_ARdouble;        ///< Center.
       coord_num :T_int;                                 ///< Number of coordinates in x_coord, y_coord.
       x_coord   :array [ 0..AR_CHAIN_MAX-1 ] of T_int;  ///< X values of coordinates.
       y_coord   :array [ 0..AR_CHAIN_MAX-1 ] of T_int;  ///< Y values of coordinates.
       vertex    :array [ 0..5-1 ] of T_int;             ///< Vertices.
     end;
     P_ARMarkerInfo2 = ^T_ARMarkerInfo2;

(*!
    @brief Result codes returned by arDetectMarker to report state of individual detected trapezoidal regions.

    When detecting markers, all trapezoidal regions in the incoming image are considered for
    marker matching. Various heuristics are used to reject regions judged to be non-markers.
    The code will, as far as possible, report rejection by placing one of these constants
    into the ARMarkerInfo.cutoffPhase field of regions rejected during the arDetectMarker() call.
    Note that the ARMarkerInfo.id of such rejected regions will be -1.
 *)
type T_AR_MARKER_INFO_CUTOFF_PHASE = (
       AR_MARKER_INFO_CUTOFF_PHASE_NONE                              ,  ///< Marker OK.
       AR_MARKER_INFO_CUTOFF_PHASE_PATTERN_EXTRACTION                ,  ///< Failure during pattern extraction.
       AR_MARKER_INFO_CUTOFF_PHASE_MATCH_GENERIC                     ,  ///< Generic error during matching phase.
       AR_MARKER_INFO_CUTOFF_PHASE_MATCH_CONTRAST                    ,  ///< Insufficient contrast during matching.
       AR_MARKER_INFO_CUTOFF_PHASE_MATCH_BARCODE_NOT_FOUND           ,  ///< Barcode matching could not find correct barcode locator pattern.
       AR_MARKER_INFO_CUTOFF_PHASE_MATCH_BARCODE_EDC_FAIL            ,  ///< Barcode matching error detection/correction found unrecoverable error.
       AR_MARKER_INFO_CUTOFF_PHASE_MATCH_CONFIDENCE                  ,  ///< Matching confidence cutoff value not reached.
       AR_MARKER_INFO_CUTOFF_PHASE_POSE_ERROR                        ,  ///< Maximum allowable pose error exceeded.
       AR_MARKER_INFO_CUTOFF_PHASE_POSE_ERROR_MULTI                  ,  ///< Multi-marker pose error value exceeded.
       AR_MARKER_INFO_CUTOFF_PHASE_HEURISTIC_TROUBLESOME_MATRIX_CODES   ///< Heuristic-based rejection of troublesome matrix code which is often generated in error.
     );

const AR_MARKER_INFO_CUTOFF_PHASE_DESCRIPTION_COUNT = 10;
var arMarkerInfoCutoffPhaseDescriptions :array [ 0..AR_MARKER_INFO_CUTOFF_PHASE_DESCRIPTION_COUNT-1 ] of P_char;

(*!
    @brief   Describes a detected trapezoidal area (a candidate for a marker match).
    @details
        After marker detection, a number of trapezoidal areas in the camera image will have been identified. An
        ARMarkerInfo struct is returned for each area so matched. Trapezoidal areas which have been matched
        with marker images (in pattern mode) or barcodes (in matrix mode) will have valid values assigned to the
        appropriate id field.
 *)
type T_ARMarkerInfo = record
       area           :T_int;                                   ///< Area in pixels of the largest connected region, comprising the marker border and regions connected to it. Note that this is not the same as the actual onscreen area inside the marker border.
       id             :T_int;                                   ///< If pattern detection mode is either pattern mode OR matrix but not both, will be marker ID (>= 0) if marker is valid, or -1 if invalid.
       idPatt         :T_int;                                   ///< If pattern detection mode includes a pattern mode, will be marker ID (>= 0) if marker is valid, or -1 if invalid.
       idMatrix       :T_int;                                   ///< If pattern detection mode includes a matrix mode, will be marker ID (>= 0) if marker is valid, or -1 if invalid.
       dir            :T_int;                                   ///< If pattern detection mode is either pattern mode OR matrix but not both, and id != -1, will be marker direction (range 0 to 3, inclusive).
       dirPatt        :T_int;                                   ///< If pattern detection mode includes a pattern mode, and id != -1, will be marker direction (range 0 to 3, inclusive).
       dirMatrix      :T_int;                                   ///< If pattern detection mode includes a matrix mode, and id != -1, will be marker direction (range 0 to 3, inclusive).
       cf             :T_ARdouble;                              ///< If pattern detection mode is either pattern mode OR matrix but not both, will be marker matching confidence (range 0.0 to 1.0 inclusive) if marker is valid, or -1.0 if marker is invalid.
       cfPatt         :T_ARdouble;                              ///< If pattern detection mode includes a pattern mode, will be marker matching confidence (range 0.0 to 1.0 inclusive) if marker is valid, or -1.0 if marker is invalid.
       cfMatrix       :T_ARdouble;                              ///< If pattern detection mode includes a matrix mode, will be marker matching confidence (range 0.0 to 1.0 inclusive) if marker is valid, or -1.0 if marker is invalid.
       pos            :array [ 0..2-1 ] of T_ARdouble;          ///< 2D position (in camera image coordinates, origin at top-left) of the centre of the marker.
       line           :array [ 0..4-1, 0..3-1 ] of T_ARdouble;  ///< Line equations for the 4 sides of the marker.
       vertex         :array [ 0..4-1, 0..2-1 ] of T_ARdouble;  ///< 2D positions (in camera image coordinates, origin at top-left) of the corners of the marker. vertex[(4 - dir)%4][] is the top-left corner of the marker. Other vertices proceed clockwise from this. These are idealised coordinates (i.e. the onscreen position aligns correctly with the undistorted camera image.)
       markerInfo2Ptr :P_ARMarkerInfo2;                         ///< Pointer to source region info for this marker.
       cutoffPhase    :T_AR_MARKER_INFO_CUTOFF_PHASE;           ///< If a trapezoidal region is detected, but is eliminated from the candidates for tracking, this field is filled out with the tracking phase at which the marker was cut off. An English-language description of the phase can be obtained by indexing into the C-string array arMarkerInfoCutoffPhaseDescriptions[].
       errorCorrected :T_int;                                   ///< For marker types including error detection and correction, the numbers of errors detected and corrected.
       globalID       :T_uint64_t;                              ///< If arPattDetectionMode is a matrix mode, matrixCodeType is AR_MATRIX_CODE_GLOBAL_ID, and idMatrix >= 0, will contain the globalID.
     end;
     P_ARMarkerInfo = ^T_ARMarkerInfo;

(*!
    @brief   (description)
    @details (description)
 *)
type T_ARTrackingHistory = record
       marker :T_ARMarkerInfo;  ///< 
       count   :T_int;          ///< 
     end;

(*!
    @brief   (description)
    @details (description)
 *)
type T_ARLabelInfo = record
       labelImage :P_AR_LABELING_LABEL_TYPE;
{$IF not AR_DISABLE_LABELING_DEBUG_MODE }
       bwImage    :P_ARUint8;
{$ENDIF}
       label_num  :T_int;
       area       :array [ 0..AR_LABELING_WORK_SIZE-1 ] of T_int;
       clip       :array [ 0..AR_LABELING_WORK_SIZE-1, 0..4-1 ] of T_int;
       pos        :array [ 0..AR_LABELING_WORK_SIZE-1, 0..2-1 ] of T_ARdouble;
       work       :array [ 0..AR_LABELING_WORK_SIZE-1 ] of T_int;
       work2      :array [ 0..AR_LABELING_WORK_SIZE*7-1 ] of T_int; ///< area, pos[2], clip[4].
     end;
     P_ARLabelInfo = ^T_ARLabelInfo;

(* --------------------------------------------------*)

(*!
    @brief   A structure which holds descriptions of trained patterns for template matching.
    @details Template (picture)-based pattern matching requires details of the pattern
        to be supplied to the matching functions. This structure holds such details. It is
        generally setup by loading pattern files from disk.
*)
type T_ARPattHandle = record
       patt_num     :T_int;       ///< Number of valid patterns in the structure.
       patt_num_max :T_int;       ///< Maximum number of patterns that may be loaded in this structure.
       pattf        :P_int;       ///< 0 = no pattern loaded at this position. 1 = pattern loaded and activated. 2 = pattern loaded but deactivated.
       patt         :PP_int;      ///< Array of 4 different orientations of each pattern's colour values, in 1-byte per component BGR order.
       pattpow      :P_ARdouble;  ///< Root-mean-square of the pattern intensities.
       pattBW       :PP_int;      ///< Array of 4 different orientations of each pattern's 1-byte luminosity values.
       pattpowBW    :P_ARdouble;  ///< Root-mean-square of the pattern intensities.
     //pattRatio    :T_ARdouble;  ///<
       pattSize     :T_int;       ///< Number of rows/columns in the pattern.
     end;
     P_ARPattHandle = ^T_ARPattHandle;

(*!
    @brief Defines a pattern rectangle as a sub-portion of a marker image.
    @details A complete marker image has coordinates {0.0f, 0.0f, 1.0f, 1.0f}.
        A standard ARToolKit marker with a pattern ratio of 0.5 has coordinates
        {0.25f, 0.25f, 0.75f, 0.75f}.
 *)
type T_ARPattRectInfo = record
       topLeftX     :T_float;  ///< Horizontal coordinate of the top left corner of the pattern space, in range 0.0f-1.0f.
       topLeftY     :T_float;  ///< Vertical coordinate of the top left corner of the pattern space, in range 0.0f-1.0f.
       bottomRightX :T_float;  ///< Horizontal coordinate of the bottom right corner of the pattern space, in range 0.0f-1.0f.
       bottomRightY :T_float;  ///< Vertical coordinate of the bottom right corner of the pattern space, in range 0.0f-1.0f.
     end;
     P_ARPattRectInfo = ^T_ARPattRectInfo;

(* --------------------------------------------------*)

//{$IFDEF __cplusplus }
//}
//{$ENDIF}

//#include <AR/param.h>
//#include <AR/arImageProc.h>

//{$IFDEF __cplusplus }
//extern "C" {
//{$ENDIF}

const AR_MATRIX_CODE_TYPE_SIZE_MASK    = $000000ff; ///< Mask value, bitwise-OR with matrix code type to find matrix code size.
const AR_MATRIX_CODE_TYPE_ECC_NONE     = $00000000; ///< No error detection or correction.
const AR_MATRIX_CODE_TYPE_ECC_PARITY   = $00000100; ///< Single-bit parity.
const AR_MATRIX_CODE_TYPE_ECC_HAMMING  = $00000200; ///< Hamming code with Hamming distance of 3.
const AR_MATRIX_CODE_TYPE_ECC_BCH___3  = $00000300; ///< BCH code with Hamming distance of 3.
const AR_MATRIX_CODE_TYPE_ECC_BCH___5  = $00000400; ///< BCH code with Hamming distance of 5.
const AR_MATRIX_CODE_TYPE_ECC_BCH___7  = $00000500; ///< BCH code with Hamming distance of 7.
const AR_MATRIX_CODE_TYPE_ECC_BCH___9  = $00000600; ///< BCH code with Hamming distance of 9.
const AR_MATRIX_CODE_TYPE_ECC_BCH___11 = $00000700; ///< BCH code with Hamming distance of 11.
const AR_MATRIX_CODE_TYPE_ECC_BCH___19 = $00000b00; ///< BCH code with Hamming distance of 19.

(*!
    @brief Values specifying the type of matrix code in use.
 *)
type T_AR_MATRIX_CODE_TYPE = (
       AR_MATRIX_CODE_3x3             = $03                                    ,  ///< Matrix code in range 0-63.
       AR_MATRIX_CODE_3x3_PARITY65    = $03 or AR_MATRIX_CODE_TYPE_ECC_PARITY  ,  ///< Matrix code in range 0-31.
       AR_MATRIX_CODE_3x3_HAMMING63   = $03 or AR_MATRIX_CODE_TYPE_ECC_HAMMING ,  ///< Matrix code in range 0-7.
       AR_MATRIX_CODE_4x4             = $04                                    ,  ///< Matrix code in range 0-8191.
       AR_MATRIX_CODE_4x4_BCH_13_9_3  = $04 or AR_MATRIX_CODE_TYPE_ECC_BCH___3 ,  ///< Matrix code in range 0-511.
       AR_MATRIX_CODE_4x4_BCH_13_5_5  = $04 or AR_MATRIX_CODE_TYPE_ECC_BCH___5 ,  ///< Matrix code in range 0-31.
       AR_MATRIX_CODE_5x5_BCH_22_12_5 = $05 or AR_MATRIX_CODE_TYPE_ECC_BCH___5 ,  ///< Matrix code in range 0-4095.
       AR_MATRIX_CODE_5x5_BCH_22_7_7  = $05 or AR_MATRIX_CODE_TYPE_ECC_BCH___7 ,  ///< Matrix code in range 0-127.
       AR_MATRIX_CODE_5x5             = $05                                    ,  ///< Matrix code in range 0-4194303.
       AR_MATRIX_CODE_6x6             = $06                                    ,  ///< Matrix code in range 0-8589934591.
       AR_MATRIX_CODE_GLOBAL_ID       = $0e or AR_MATRIX_CODE_TYPE_ECC_BCH___19
     );
     P_AR_MATRIX_CODE_TYPE = ^T_AR_MATRIX_CODE_TYPE;

///// LUX.Vision.ARToolKit.arConfig
const AR_MATRIX_CODE_TYPE_DEFAULT = AR_MATRIX_CODE_3x3;

(*!
    @brief   Structure holding state of an instance of the square marker tracker.
    @details
        This is the master object holding the current state of an intance of the square
        marker tracker, including tracker configuration, working variables, and results.
    @see        arCreateHandle
    @see        arDeteleHandle
 *)
type T_ARHandle = record
       arDebug                          :T_int;
       arPixelFormat                    :T_AR_PIXEL_FORMAT;
       arPixelSize                      :T_int;
       arLabelingMode                   :T_int;
       arLabelingThresh                 :T_int;
       arImageProcMode                  :T_int;  ///< To query this value, call arGetImageProcMode(). To set this value, call arSetImageProcMode().
       arPatternDetectionMode           :T_int;
       arMarkerExtractionMode           :T_int;
       arParamLT                        :P_ARParamLT;
       xsize                            :T_int;
       ysize                            :T_int;
       marker_num                       :T_int;
       markerInfo                       :array [ 0..AR_SQUARE_MAX-1 ] of T_ARMarkerInfo;
       marker2_num                      :T_int;
       markerInfo2                      :array [ 0..AR_SQUARE_MAX-1 ] of T_ARMarkerInfo2;
       history_num                      :T_int;
       history                          :array [ 0..AR_SQUARE_MAX-1 ] of T_ARTrackingHistory;
       labelInfo                        :T_ARLabelInfo;
       pattHandle                       :P_ARPattHandle;
       arLabelingThreshMode             :T_AR_LABELING_THRESH_MODE;
       arLabelingThreshAutoInterval     :T_int;
       arLabelingThreshAutoIntervalTTL  :T_int;
       arLabelingThreshAutoBracketOver  :T_int;
       arLabelingThreshAutoBracketUnder :T_int;
       arImageProcInfo                  :P_ARImageProcInfo;
       pattRatio                        :T_ARdouble;             ///< A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
       matrixCodeType                   :T_AR_MATRIX_CODE_TYPE;  ///< When matrix code pattern detection mode is active, indicates the type of matrix code to detect.
     end;
     P_ARHandle = ^T_ARHandle;

(* --------------------------------------------------*)

(*!
    @brief   Structure holding state of an instance of the monocular pose estimator.
    @details (description)
*)
type T_AR3DHandle = record
       icpHandle :P_ICPHandleT;
     end;
     P_AR3DHandle = ^T_AR3DHandle;
    PP_AR3DHandle = ^P_AR3DHandle;

const AR_TRANS_MAT_IDENTITY = ICP_TRANS_MAT_IDENTITY;

(*!
    @brief   Structure holding state of an instance of the stereo pose estimator.
    @details (description)
*)
type T_AR3DStereoHandle = record
       icpStereoHandle :P_ICPStereoHandleT;
     end;
     P_AR3DStereoHandle = ^T_AR3DStereoHandle;
    PP_AR3DStereoHandle = ^P_AR3DStereoHandle;

(***********************************)
(*                                 *)
(*    For square detection         *)
(*                                 *)
(***********************************)

(*!
    @functiongroup "Square detection".
 *)
(*!
    @brief   Create a handle to hold settings for an ARToolKit tracker instance.
    @details
        ARHandle is the primary structure holding the settings for a single ARToolKit
        square marker tracking instance. Settings include expected video stream image
        size and pixel format, tracking modes, loaded markers and more.

        Expected video stream image size is taken directly from the supplied ARParamLT
        structure's xsize and ysize fields. Video stream image pixel format must be set
        by a subsequent call to arSetPixelFormat() to set the correct format.

        After creation of the ARHandle, tracking settings should be set via appropriate
        calls to other arSet*() functions.

        The ARHandle should be disposed of via a call to arDeleteHandle when tracking
        with this instance is complete.
    @param      paramLT The created handle will hold a pointer to the calibrated
        camera parameters specified by this parameter. This parameter uses the new
        lookup-table based form of the camera parameters introduced in ARToolKit v5.
        An ARParamLT structure may be created from an ARParam structure via the
        call:
        <code>ARParamLT *paramLT = arParamLTCreate(&param, AR_PARAM_LT_DEFAULT_OFFSET);</code>
        Note that the pointer is only copied, and so the ARParamLT structure must remain
        valid until the ARHandle is disposed of by calling arDeleteHandle.
    @result     An ARHandle which should be passed to other functions which
        deal with the operations of the ARToolKit tracker.
    @see arSetPixelFormat
    @see arDeleteHandle
*)
function arCreateHandle( paramLT_:P_ARParamLT ) :P_ARHandle; stdcall; external _DLLNAME_;

(*!
    @brief   Delete a handle which holds settings for an ARToolKit tracker instance.
    @details The calibrated camera parameters pointed to by the handle are
        NOT deleted by this operation.
    @param      handle The handle to delete, as created by arCreateHandle();
    @result     0 if no error occured.
    @see arCreateHandle
*)
function arDeleteHandle( handle_:P_ARHandle ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Enable or disable ARToolKit's debug mode.
    @details In debug mode, ARToolKit offers additional error reporting. Use
        this function to enable or disable debug mode at runtime.

        Additionally, in debug mode, ARToolKit creates a mono (8-bit grayscale)
        image of the thresholded video input, and makes this available
        through the field ARHandle->labelInfo.bwImage.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its debug mode.
    @param      mode
        Options for this field are:
        AR_DEBUG_DISABLE
        AR_DEBUG_ENABLE
        The default mode is AR_DEBUG_DISABLE.
    @result     0 if no error occured.
    @see        arGetDebugMode
*)
function arSetDebugMode( handle_:P_ARHandle; mode_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Find out whether ARToolKit's debug mode is enabled.
    @details See arSetDebugMode() for more info.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its mode.
    @param        mode Pointer into which will be placed the
        value representing the mode.
    @result     0 if no error occured.
    @see        arSetDebugMode
*)
function arGetDebugMode( handle_:P_ARHandle; mode_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Select between detection of black markers and white markers.
    @details
        ARToolKit's labelling algorithm can work with both black-bordered
        markers on a white background (AR_LABELING_BLACK_REGION) or
        white-bordered markers on a black background (AR_LABELING_WHITE_REGION).
        This function allows you to specify the type of markers to look for.
        Note that this does not affect the pattern-detection algorith
        which works on the interior of the marker.
    @param      handle An ARHandle referring to the current AR tracker
        to have its labeling mode set.
    @param      mode
        Options for this field are:
        AR_LABELING_WHITE_REGION
        AR_LABELING_BLACK_REGION
        The default mode is AR_LABELING_BLACK_REGION.
    @result     0 if no error occured.
 *)
function arSetLabelingMode( handle_:P_ARHandle; mode_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Enquire whether detection is looking for black markers or white markers.
    @details See discussion for arSetLabelingMode.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its labeling mode.
    @param        mode Pointer into which will be placed the
        value representing the mode.
    @result     0 if no error occured.
*)
function arGetLabelingMode( handle_:P_ARHandle; mode_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the labeling threshhold.
    @details
        This function forces sets the threshold value.
        The default value is AR_DEFAULT_LABELING_THRESH which is 100,
        unless edited in arConfig.h.

        The current threshold mode is not affected by this call.
        Typically, this function is used when labeling threshold mode
        is AR_LABELING_THRESH_MODE_MANUAL.

        The threshold value is not relevant if threshold mode is
        AR_LABELING_THRESH_MODE_AUTO_ADAPTIVE.

        Background: The labeling threshold is the value which
        the AR library uses to differentiate between black and white
        portions of an ARToolKit marker. Since the actual brightness,
        contrast, and gamma of incoming images can vary signficantly
        between different cameras and lighting conditions, this
        value typically needs to be adjusted dynamically to a
        suitable midpoint between the observed values for black
        and white portions of the markers in the image.
    @param      handle An ARHandle referring to the current AR tracker
        to have its labeling threshold value set.
    @param      thresh An integer in the range [0,255] (inclusive).
    @result     0 if no error occured.
*)
function arSetLabelingThresh( handle_:P_ARHandle; thresh_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the current labeling threshold.
    @details
        This function queries the current labeling threshold. For,
        AR_LABELING_THRESH_MODE_AUTO_MEDIAN, AR_LABELING_THRESH_MODE_AUTO_OTSU,
        and AR_LABELING_THRESH_MODE_AUTO_BRACKETING
        the threshold value is only valid until the next auto-update.

        The current threshold mode is not affected by this call.

        The threshold value is not relevant if threshold mode is
        AR_LABELING_THRESH_MODE_AUTO_ADAPTIVE.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its labeling threshold value.
    @param        thresh Pointer into which will be placed the
        value of the labeling threshhold.
        An integer in the range [0,255] (inclusive)
    @result     0 if no error occured.
    @see arSetLabelingThresh
*)
function arGetLabelingThresh( handle_:P_ARHandle; thresh_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the labeling threshold mode (auto/manual).
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its labeling threshold mode.
    @param        mode An integer specifying the mode. One of:
        AR_LABELING_THRESH_MODE_MANUAL,
        AR_LABELING_THRESH_MODE_AUTO_MEDIAN,
        AR_LABELING_THRESH_MODE_AUTO_OTSU,
        AR_LABELING_THRESH_MODE_AUTO_ADAPTIVE,
        AR_LABELING_THRESH_MODE_AUTO_BRACKETING
    @result     0 if no error occured.
    @see arSetLabelingThresh
 *)
function arSetLabelingThreshMode( handle_:P_ARHandle; const mode_:T_AR_LABELING_THRESH_MODE ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the labeling threshold mode (auto/manual).
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its labeling threshold value.
    @param        mode_p Pointer into which will be placed the
        value of the labeling threshold mode, one of:
        AR_LABELING_THRESH_MODE_MANUAL,
        AR_LABELING_THRESH_MODE_AUTO_MEDIAN,
        AR_LABELING_THRESH_MODE_AUTO_OTSU,
        AR_LABELING_THRESH_MODE_AUTO_ADAPTIVE,
        AR_LABELING_THRESH_MODE_AUTO_BRACKETING
    @result     0 if no error occured.
    @see arSetLabelingThresh
 *)
function arGetLabelingThreshMode( const handle_:P_ARHandle; mode_p_:P_AR_LABELING_THRESH_MODE ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the number of frames between auto-threshold calculations.
    @details
        This is the number of frames BETWEEN calculations, meaning that the
        calculation occurs every (interval + 1) frames.
    @param      handle An ARHandle referring to the current AR tracker
        for which the labeling threshold auto interval will be set.
    @param        interval The interval, specifying the number of frames between
        automatic updates to the threshold.
        An integer in the range [0,INT_MAX] (inclusive). Default
        value is AR_LABELING_THRESH_AUTO_INTERVAL_DEFAULT.
    @result     0 if no error occured.
    @see arGetLabelingThreshModeAutoInterval
 *)
function arSetLabelingThreshModeAutoInterval( handle_:P_ARHandle; const interval_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the number of frames between auto-threshold calculations.
    @details
        This is the number of frames BETWEEN calculations, meaning that the
        calculation occurs every (interval + 1) frames.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its labeling threshold auto interval value.
    @param        interval_p Pointer into which will be placed the
        value of the labeling threshhold auto interval.
        An integer in the range [0,INT_MAX] (inclusive)
    @result     0 if no error occured.
    @see arSetLabelingThreshModeAutoInterval
 *)
function arGetLabelingThreshModeAutoInterval( const handle_:P_ARHandle; interval_p_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the image processing mode.
    @details
        When ARthe image processing mode is AR_IMAGE_PROC_FRAME_IMAGE,
        ARToolKit processes all pixels in each incoming image
        to locate markers. When the mode is AR_IMAGE_PROC_FIELD_IMAGE,
        ARToolKit processes pixels in only every second pixel row and
        column. This is useful both for handling images from interlaced
        video sources (where alternate lines are assembled from alternate
        fields and thus have one field time-difference, resulting in a
        "comb" effect) such as Digital Video cameras.
        The effective reduction by 75% in the pixels processed also
        has utility in accelerating tracking by effectively reducing
        the image size to one quarter size, at the cost of pose accuraccy.
    @param      handle An ARHandle referring to the current AR tracker
        to have its mode set.
    @param      mode
        Options for this field are:
        AR_IMAGE_PROC_FRAME_IMAGE
        AR_IMAGE_PROC_FIELD_IMAGE
        The default mode is AR_IMAGE_PROC_FRAME_IMAGE.
    @result     0 if no error occured.
*)
function arSetImageProcMode( handle_:P_ARHandle; mode_:T_int ) :T_int; stdcall; external _DLLNAME_;
(*!
    @brief   Get the image processing mode.
    @details
        See arSetImageProcMode() for a complete description.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its mode.
    @param        mode Pointer into which will be placed the
        value representing the current image processing mode.
    @result     0 if no error occured.
*)
function arGetImageProcMode( handle_:P_ARHandle; mode_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the pattern detection mode
    @details
        The pattern detection determines the method by which ARToolKit
        matches detected squares in the video image to marker templates
        and/or IDs. ARToolKit v4.x can match against pictorial "template" markers,
        whose pattern files are created with the mk_patt utility, in either colour
        or mono, and additionally can match against 2D-barcode-type "matrix"
        markers, which have an embedded marker ID. Two different two-pass modes
        are also available, in which a matrix-detection pass is made first,
        followed by a template-matching pass.
    @param      handle An ARHandle referring to the current AR tracker
        to have its mode set.
    @param      mode
        Options for this field are:
        AR_TEMPLATE_MATCHING_COLOR
        AR_TEMPLATE_MATCHING_MONO
        AR_MATRIX_CODE_DETECTION
        AR_TEMPLATE_MATCHING_COLOR_AND_MATRIX
        AR_TEMPLATE_MATCHING_MONO_AND_MATRIX
        The default mode is AR_TEMPLATE_MATCHING_COLOR.
    @result     0 if no error occured.
*)
function arSetPatternDetectionMode( handle_:P_ARHandle; mode_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the pattern detection mode
    @details
        See arSetPatternDetectionMode() for a complete description.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its mode.
    @param        mode Pointer into which will be placed the
        value representing the mode.
    @result     0 if no error occured.
*)
function arGetPatternDetectionMode( handle_:P_ARHandle; mode_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the size and ECC algorithm to be used for matrix code (2D barcode) marker detection.
    @details
        When matrix-code (2D barcode) marker detection is enabled (see arSetPatternDetectionMode)
        then the size of the barcode pattern and the type of error checking and correction (ECC)
        with which the markers were produced can be set via this function.

        This setting is global to a given ARHandle; It is not possible to have two different matrix
        code types in use at once.
    @param      handle An ARHandle referring to the current AR tracker to have its mode set.
    @param      type The type of matrix code (2D barcode) in use. Options include:
        AR_MATRIX_CODE_3x3
        AR_MATRIX_CODE_3x3_HAMMING63
        AR_MATRIX_CODE_3x3_PARITY65
        AR_MATRIX_CODE_4x4
        AR_MATRIX_CODE_4x4_BCH_13_9_3
        AR_MATRIX_CODE_4x4_BCH_13_5_5
        AR_MATRIX_CODE_5x5_BCH_22_12_5
        AR_MATRIX_CODE_5x5_BCH_22_7_7
        The default mode is AR_MATRIX_CODE_3x3.
    @see arSetPatternDetectionMode
    @see arGetMatrixCodeType
    @result     0 if no error occured.
*)
function arSetMatrixCodeType( handle_:P_ARHandle; const type_:T_AR_MATRIX_CODE_TYPE ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the size and ECC algorithm being used for matrix code (2D barcode) marker detection.
    @details See the description for arSetMatrixCodeType().
    @param      handle An ARHandle referring to the current AR tracker to be queried for its mode.
    @param        type_p Pointer into which will be placed the value representing the mode.
    @see    arGetPatternDetectionMode
    @see    arSetMatrixCodeType
    @result     0 if no error occured.
*)
function arGetMatrixCodeType( handle_:P_ARHandle; type_p_:P_AR_MATRIX_CODE_TYPE ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the marker extraction mode
    @details (description)
    @param      handle An ARHandle referring to the current AR tracker to have its mode set.
    @param      mode
        Options for this field are:
        AR_USE_TRACKING_HISTORY
        AR_NOUSE_TRACKING_HISTORY
        AR_USE_TRACKING_HISTORY_V2
        The default mode is AR_USE_TRACKING_HISTORY_V2.
    @result     0 if no error occured.
 *)
function arSetMarkerExtractionMode( handle_:P_ARHandle; mode_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the marker extraction mode
    @details (description)
    @param      handle An ARHandle referring to the current AR tracker to be queried for its mode.
    @param        mode Pointer into which will be placed the value representing the mode.
    @result     0 if no error occured.
 *)
function arGetMarkerExtractionMode( handle_:P_ARHandle; mode_:P_int ) :T_int; stdcall; external _DLLNAME_;

(*!
     @brief   Set the border size.
     @details N.B. Deprecated in favour of arSetPattRatio(), but retained for
        backwards compatibility.
     @param      handle An ARHandle referring to the current AR tracker
        to have its border size set.
     @param      borderSize The border size. To set the default, pass (1.0 - 2*AR_PATT_RATIO).
        If compatibility with ARToolKit verions 1.0 through 4.4 is required, this value
        must be 0.25.
     @result     0 if no error occured.
 *)
function arSetBorderSize( handle_:P_ARHandle; const borderSize_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the border size.
    @details N.B. Deprecated in favour of arGetPattRatio(), but retained for
        backwards compatibility.
    @param      handle An ARHandle referring to the current AR tracker
        to be queried for its border size.
    @param        borderSize Pointer into which will be placed the
        value representing the border size. The default border size for newly-created
        ARHandle structures is AR_BORDER_SIZE_DEFAULT.
    @result     0 if no error occured.
 *)
function arGetBorderSize( handle_:P_ARHandle; borderSize_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the width/height of the marker pattern space, as a proportion of marker width/height.
    @details N.B. Supercedes arSetBorderSize().
    @param      handle An ARHandle referring to the current AR tracker to be modified.
    @param        pattRatio The the width/height of the marker pattern space, as a proportion of marker
        width/height. To set the default, pass AR_PATT_RATIO.
        If compatibility with ARToolKit verions 1.0 through 4.4 is required, this value
        must be 0.5.
    @result     0 if no error occured.
 *)
function arSetPattRatio( handle_:P_ARHandle; const pattRatio_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the width/height of the marker pattern space, as a proportion of marker width/height.
    @details N.B. Supercedes arGetBorderSize().
    @param      handle An ARHandle referring to the current AR tracker to be queried.
    @param        pattRatio Pointer into which will be placed the
        value representing the width/height of the marker pattern space, as a proportion of marker
        width/height. The default border size for newly-created ARHandle structures is AR_PATT_RATIO.
    @result     0 if no error occured.
 *)
function arGetPattRatio( handle_:P_ARHandle; pattRatio_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Set the expected pixel format for video frames being passed to arDetectMarker
    @details
        This function must be used at least once after creation of an ARHandle, to set the pixel
        format with which images will be passed to arDetectMarker(). If the pixel format of
        incoming video images changes, this function must be called again to update the value.
    @param      handle Handle to settings structure in which to set the pixel format.
    @param      pixFormat Value representing the format of pixels to be
        processed by the ARToolKit detection routines. See AR_PIXEL_FORMAT
        reference for more information.
    @result     0 if no error occured.
    @see arGetPixelFormat
    @see arCreateHandle
    @see arDetectMarker
 *)
function arSetPixelFormat( handle_:P_ARHandle; pixFormat_:T_AR_PIXEL_FORMAT ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the expected pixel format for video frames being passed to arDetectMarker
    @details
        See discussion for arSetPixelFormat().
    @param      handle Handle to AR settings structure from which to retrieve the pixel format.
    @param        pixFormat Pointer into which will be placed the
        value representing the format of pixels being
        processed by the ARToolKit detection routines. See AR_PIXEL_FORMAT
        reference for more information.
    @result     0 if no error occured.
    @see arSetPixelFormat
    @see arCreateHandle
    @see arDetectMarker
 *)
function arGetPixelFormat( handle_:P_ARHandle; pixFormat_:P_AR_PIXEL_FORMAT ) :T_int; stdcall; external _DLLNAME_;


(*!
    @brief   Detect markers in a video frame.
    @details
        This is the core ARToolKit marker detection function. It calls through to a set of
        internal functions to perform the key marker detection steps of binarization and
        labelling, contour extraction, and template matching and/or matrix code extraction.

        Typically, the resulting set of detected markers is retrieved by calling arGetMarkerNum
        to get the number of markers detected and arGetMarker to get an array of ARMarkerInfo
        structures with information on each detected marker, followed by a step in which
        detected markers are possibly examined for some measure of goodness of match (e.g. by
        examining the match confidence value) and pose extraction.

    @param      arHandle Handle to initialised settings, including camera parameters,
        incoming video image size and pixel format, markers, detection modes and other information.
    @param        frame Pointer to an AR2VideoBufferT structure which contains the pixel
        data for the image  frame which is to be processed for marker detection. The format of
        pixels in the frame is specified by arSetPixelFormat(). The width and height of
        the image are specified by the xsize and ysize parameters of the camera parameters
        held in arHandle.
    @result     0 if the function proceeded without error, or a value less than 0 in case of error.
        A result of 0 does not however, imply any markers were detected.
    @see arCreateHandle
    @see arGetMarkerNum
    @see arGetMarker
 *)
function arDetectMarker( arHandle_:P_ARHandle; frame_:P_AR2VideoBufferT ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the number of markers detected in a video frame.
    @result     The number of detected markers in the most recent image passed to arDetectMarker.
        Note that this is actually a count, not an index. A better name for this function would be
        arGetDetectedMarkerCount, but the current name lives on for historical reasons.
    @param      arHandle Handle upon which arDetectMarker has been called.
    @see arGetMarker
    @see ARMarkerInfo
    @see arDetectMarker
 *)
function arGetMarkerNum( arHandle_:P_ARHandle ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get information on the markers detected in a video frame.
    @result     An array (of length arGetMarkerNum(arHandle)) of ARMarkerInfo structs.
        A better name for this function would be arGetDetectedMarkerInfo, but the current name lives
        on for historical reasons.
    @param      arHandle Handle upon which arDetectMarker has been called.
    @see arGetMarkerNum
    @see ARMarkerInfo
    @see arDetectMarker
 *)
function arGetMarker( arHandle_:P_ARHandle ) :P_ARMarkerInfo; stdcall; external _DLLNAME_;

(* ------------------------------ *)

function arLabeling( imageLuma_:P_ARUint8; xsize_:T_int; ysize_:T_int; debugMode_:T_int; labelingMode_:T_int; labelingThresh_:T_int; imageProcMode_:T_int; labelInfo_:P_ARLabelInfo; image_thresh_:P_ARUint8 ) :T_int; stdcall; external _DLLNAME_;
function arDetectMarker2( xsize_:T_int; ysize_:T_int; labelInfo_:P_ARLabelInfo; imageProcMode_:T_int; areaMax_:T_int; areaMin_:T_int; squareFitThresh_:T_ARdouble; markerInfo2_:P_ARMarkerInfo2; marker2_num_:P_int ) :T_int; stdcall; external _DLLNAME_;
(*!
    @brief   Examine a set of detected squares for match with known markers.
    @details
        Performs the intermediate marker-detection stage of taking detected squares in a processed image, and
        matching the interior of these squares against known marker templates, or extracting matrix codes from
        the interior of the square.
    @param      image Image in which squares were detected.
    @param      xsize Horizontal dimension of image, in pixels.
    @param      ysize Vertical dimension of image, in pixels.
    @param      pixelFormat Format of pixels in image. See &lt;AR/config.h&gt; for values.
    @param      markerInfo2 Pointer to an array of ARMarkerInfo2 structures holding information on detected squares which are candidates for marker matching.
    @param      marker2_num Size of markerInfo2 array.
    @param      pattHandle Handle to loaded patterns for template matching against detected squares.
    @param      imageProcMode Indicates whether square detection was performed treating the image as a frame or a field.
    @param      pattDetectMode Whether to perform color/mono template matching, matrix code detection, or both.
    @param      arParamLTf Lookup table for the camera parameters for the optical source from which the image was acquired. See arParamLTCreate.
    @param      pattRatio A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
    @param      markerInfo Output: Pointer to an array of ARMarkerInfo structures holding information on successful matches.
    @param      marker_num Output: Size of markerInfo array.
    @param      matrixCodeType When matrix code pattern detection mode is active, indicates the type of matrix code to detect.
    @result     0 in case of no error, or -1 otherwise.
    @see    arParamLTCreate
 *)
function arGetMarkerInfo( image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_int; markerInfo2_:P_ARMarkerInfo2; marker2_num_:T_int; pattHandle_:P_ARPattHandle; imageProcMode_:T_int; pattDetectMode_:T_int; arParamLTf_:P_ARParamLTf; pattRatio_:T_ARdouble; markerInfo_:P_ARMarkerInfo; marker_num_:P_int; const matrixCodeType_:T_AR_MATRIX_CODE_TYPE ) :T_int; stdcall; external _DLLNAME_;

function arGetContour( lImage_:P_AR_LABELING_LABEL_TYPE; xsize_:T_int; ysize_:T_int; label_ref_:P_int; label_:T_int; clip_:T_int4; marker_info2_:P_ARMarkerInfo2 ) :T_int; stdcall; external _DLLNAME_;
function arGetLine( x_coord_:array of T_int; y_coord_:array of T_int; coord_num_:T_int; vertex_:array of T_int; paramLTf_:P_ARParamLTf; line_:T_ARdouble43; v_:T_ARdouble42 ) :T_int; stdcall; external _DLLNAME_;


(***********************************)
(*                                 *)
(*    For pattern identification   *)
(*                                 *)
(***********************************)

(*!
    @functiongroup "Pattern identification".
 *)
(*!
    @brief   Allocate a pattern handle.
    @details Allocates an empty pattern handle, into which patterns can
        be loaded by calling arPattLoad().
        When the pattern handle is no longer needed, it should be
        freed by calling arPattDeleteHandle().

        Note that a pattern handle is NOT required when using only matrix-
        code (2D barcode) markers.
    @see    arPattLoad
    @see    arPattDeleteHandle
    @result     The created pattern handle, or NULL in case of error.
*)
function arPattCreateHandle :P_ARPattHandle; stdcall; external _DLLNAME_;

(*!
    @brief   Allocate a pattern handle and set pattern template size and maximum number of patterns loadable.
    @details Allocates an empty pattern handle, into which patterns can
        be loaded by calling arPattLoad().
        When the pattern handle is no longer needed, it should be
        freed by calling arPattDeleteHandle().

        Note that a pattern handle is NOT required when using only matrix-
        code (2D barcode) markers.
    @param pattSize For any square template (pattern) markers, the number of rows and
        columns in the template. May not be less than 16 or more than AR_PATT_SIZE1_MAX.

        Pass AR_PATT_SIZE1 for the same behaviour as arPattCreateHandle().
    @param patternCountMax For any square template (pattern) markers, the maximum number of
        markers that may be loaded for a single matching pass. Must be > 0.

        Pass AR_PATT_NUM_MAX for the same behaviour as arPattCreateHandle().
    @see    arPattLoad
    @see    arPattDeleteHandle
    @result     The created pattern handle, or NULL in case of error.
*)

function arPattCreateHandle2( const pattSize_:T_int; const patternCountMax_:T_int ) :P_ARPattHandle; stdcall; external _DLLNAME_;

(*!
    @brief   Free all loaded patterns and pattern handle.
    @details Frees a pattern handle, freeing (unloading)
        any patterns loaded into the handle in the process.
    @param      pattHandle The handle to free.
    @result     0 on success, or -1 if trying to free a NULL handle.
*)
function arPattDeleteHandle( pattHandle_:P_ARPattHandle ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Load a pattern file into a pattern handle.
    @details
        This function loads a pattern template from a file on disk, and attaches
        it to the given ARPattHandle so making it available for future pattern-matching.
        Additional patterns can be loaded by calling again with the same
        ARPattHandle (however no more than AR_PATT_NUM_MAX patterns can be attached
        to a single ARPattHandle). Patterns are initially loaded
        in an active state.

        Note that matrix-code (2D barcode) markers do not have any associated
        pattern file and do not need to be loaded.
    @param      pattHandle Pattern handle, as generated by arPattCreateHandle(),
        into which the pattern file infomation will be loaded.
    @param      filename Pathname of pattern file to load. The pattern file
        is typically generated by the make_patt program. The pathname is
        relative to the current working directory, which is operating system-
        specific.
    @see arPattCreateHandle
    @see arPattActivate
    @see arPattDeactivate
    @see arPattFree
    @result     Returns the index number of the loaded pattern, in the range
        [0, AR_PATT_NUM_MAX - 1], or -1 if the pattern could not be loaded
        because the maximum number of patterns (AR_PATT_NUM_MAX) has already been
        loaded already into this handle.
*)
function arPattLoad( pattHandle_:P_ARPattHandle; const filename_:P_char ) :T_int; stdcall; external _DLLNAME_;

function arPattLoadFromBuffer( pattHandle_:P_ARPattHandle; const buffer_:P_char ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Save a pattern to a pattern file.
    @details This function is used by the make_patt utility. See the
        sourcecode to mk_patt for usage.
    @param      image (description)
    @param      xsize (description)
    @param      ysize (description)
    @param      pixelFormat (description)
    @param      paramLTf (description)
    @param      imageProcMode (description)
    @param      marker_info (description)
    @param      pattRatio A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
    @param      pattSize The number of rows and columns to create in the pattern. Normally AR_PATT_SIZE1.
    @param      filename (description)
    @result     (description)
 *)
function arPattSave( image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_int; paramLTf_:P_ARParamLTf; imageProcMode_:T_int; marker_info_:P_ARMarkerInfo; pattRatio_:T_ARdouble; pattSize_:T_int; const filename_:P_char ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Frees (unloads) a pattern file from memory.
    @details Unloads a pattern from a pattern handle, freeing that
        slot for another pattern to be loaded, if necessary.
    @param      pattHandle The pattern handle to unload from.
    @param        patno The index into the pattern handle's array of
        patterns to the pattern to be unloaded.
    @result     0 if the pattern was successfully unloaded, or -1
        if there was no pattern loaded.
    @see    arPattLoad
 *)
function arPattFree( pattHandle_:P_ARPattHandle; patno_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Activate a previously deactivated pattern.
    @details When a pattern is activated, is becomes available
        for recognition in a scene. This is the default state
        for a loaded pattern.
    @param      pattHandle The handle holding the loaded pattern
        which is to be reactivated.
    @param        patno The index into the pattern handle's array of
        patterns to the pattern to be reactivated.
    @result     0 on success, or -1 if the pattern was already
        activated or no pattern was loaded.
    @see    arPattDeactivate
*)
function arPattActivate( pattHandle_:P_ARPattHandle; patno_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Deactivate a previously activated pattern.
    @details When a pattern is activated, is becomes unavailable
        for recognition in a scene. Deactivating unused patterns
        can speed up recognition time and accuracy when there are
        multiple patterns in a scene, and it is also useful for
        controlling interactivity in a scene.
    @param      pattHandle The handle holding the loaded pattern
        which is to be deactivated.
    @param        patno The index into the pattern handle's array of
        patterns to the pattern to be deactivated.
    @result     0 on success, or -1 if the pattern was already
        deactivated or no pattern was loaded.
    @see    arPattActivate
*)
function arPattDeactivate( pattHandle_:P_ARPattHandle; patno_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief    Associate a set of patterns with an ARHandle.
    @details Associating a set of patterns with an ARHandle makes
        the patterns the set which will be searched when marker
        identification is performed on an image associated with the
        same ARHandle.
    @param      arHandle (description)
    @param      pattHandle (description)
    @see    arPattDetach
    @result     Returns 0 in the case of success, or -1 if the specified
        ARHandle already has an ARPattHandle attached, or if arHandle is NULL.
*)
function arPattAttach( arHandle_:P_ARHandle; pattHandle_:P_ARPattHandle ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Reset an ARHandle to no pattern association.
    @details See arPattAttach() for more information.
    @param      arHandle (description)
    @see    arPattAttach
    @result     Returns 0 in the case of success, or -1 if the specified
        ARHandle has no ARPattHandle attached, or if arHandle is NULL.
*)
function arPattDetach( arHandle_:P_ARHandle ) :T_int; stdcall; external _DLLNAME_;

//function arPattGetPattRatio( pattHandle_:P_ARPattHandle; ratio_:P_float ) :T_int; stdcall; external _DLLNAME_;
//function arPattSetPattRatio( pattHandle_:P_ARPattHandle; ratio_:T_float ) :T_int; stdcall; external _DLLNAME_;

(* ------------------------------ *)

{$IF not AR_DISABLE_NON_CORE_FNS }
function arPattGetID( pattHandle_:P_ARPattHandle; imageProcMode_:T_int; pattDetectMode_:T_int; image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_AR_PIXEL_FORMAT; x_coord_:P_int; y_coord_:P_int; vertex_:P_int; pattRatio_:T_ARdouble; code_:P_int; dir_:P_int; cf_:P_ARdouble; const matrixCodeType_:T_AR_MATRIX_CODE_TYPE ) :T_int; stdcall; external _DLLNAME_;
function arPattGetImage( imageProcMode_:T_int; pattDetectMode_:T_int; patt_size_:T_int; sample_size_:T_int; image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_AR_PIXEL_FORMAT; x_coord_:P_int; y_coord_:P_int; vertex_:P_int; pattRatio_:T_ARdouble; ext_patt_:P_ARUint8 ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Match the interior of a detected square against known patterns.
    @param      pattHandle Handle contained details of known patterns, i.e. loaded templates, or valid barcode IDs.
    @param      imageProcMode See discussion of arSetImageProcMode().
    @param      pattDetectMode See discussion of arSetPatternDetectionMode().
    @param      image Pointer to packed raw image data.
    @param      xsize Horizontal pixel dimension of raw image data.
    @param      ysize Vertical pixel dimension of raw image data.
    @param      pixelFormat Pixel format of raw image data.
    @param      arParamLTf Lookup table for the camera parameters for the optical source from which the image was acquired. See arParamLTCreate.
    @param      vertex 4x2 array of points which correspond to the x and y locations of the corners of the detected marker square.
    @param      pattRatio A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
    @param      codePatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the ID of the pattern from pattHandle, or -1 if not identified.
    @param      dirPatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the direction (up, right, down, left) of the pattern from pattHandle.
    @param      cfPatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the confidence factor of the match (range [0.0 - 1.0]).
    @param      codeMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the ID of the pattern, or -1 if not identified.
    @param      dirMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the direction (up, right, down, left) of the pattern.
    @param      cfMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the confidence factor of the match (range [0.0 - 1.0]).
    @param      matrixCodeType When matrix code pattern detection mode is active, indicates the type of matrix code to detect.
    @result     0 if the function was able to correctly match, or -1 in case of error or no match.
    @see    arParamLTCreate
 *)
function arPattGetID2( pattHandle_:P_ARPattHandle; imageProcMode_:T_int; pattDetectMode_:T_int; image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_AR_PIXEL_FORMAT; arParamLTf_:P_ARParamLTf; vertex[4][2]_:T_ARdouble; pattRatio_:T_ARdouble; codePatt_:P_int; dirPatt_:P_int; cfPatt_:P_ARdouble; codeMatrix_:P_int; dirMatrix_:P_int; cfMatrix_:P_ARdouble; const matrixCodeType_:T_AR_MATRIX_CODE_TYPE ) :T_int; stdcall; external _DLLNAME_;
{$ENDIF} // !AR_DISABLE_NON_CORE_FNS

(*!
    @brief   Match the interior of a detected square against known patterns with variable border width.
    @param      pattHandle Handle contained details of known patterns, i.e. loaded templates, or valid barcode IDs.
    @param      imageProcMode See discussion of arSetImageProcMode().
    @param      pattDetectMode See discussion of arSetPatternDetectionMode().
    @param      image Pointer to packed raw image data.
    @param      xsize Horizontal pixel dimension of raw image data.
    @param      ysize Vertical pixel dimension of raw image data.
    @param      pixelFormat Pixel format of raw image data.
    @param      arParamLTf Lookup table for the camera parameters for the optical source from which the image was acquired. See arParamLTCreate.
    @param      vertex 4x2 array of points which correspond to the x and y locations of the corners of the detected marker square.
    @param      pattRatio A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
    @param      codePatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the ID of the pattern from pattHandle, or -1 if not identified.
    @param      dirPatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the direction (up, right, down, left) of the pattern from pattHandle.
    @param      cfPatt Where the pattern matching mode includes template (picture) matching, and a valid template is matched, the confidence factor of the match (range [0.0 - 1.0]).
    @param      codeMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the ID of the pattern, or -1 if not identified.
    @param      dirMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the direction (up, right, down, left) of the pattern.
    @param      cfMatrix Where the pattern matching mode includes matrix (barcode) matching, and a valid matrix is matched, the confidence factor of the match (range [0.0 - 1.0]).
    @param      matrixCodeType When matrix code pattern detection mode is active, indicates the type of matrix code to detect.
    @param      errorCorrected Pointer to an integer which will be filled out with the number of errors detected and corrected during marker identification, or NULL if this information is not required.
    @param      codeGlobalID_p Pointer to uint64_t which will be filled out with the global ID, or NULL if this value is not required.
    @result     0 if the function was able to correctly match, or -1 in case of error or no match.
    @see    arParamLTCreate
 *)
function arPattGetIDGlobal( pattHandle_:P_ARPattHandle; imageProcMode_:T_int; pattDetectMode_:T_int; image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_AR_PIXEL_FORMAT; arParamLTf_:P_ARParamLTf; vertex_:T_ARdouble42; pattRatio_:T_ARdouble; codePatt_:P_int; dirPatt_:P_int; cfPatt_:P_ARdouble; codeMatrix_:P_int; dirMatrix_:P_int; cfMatrix_:P_ARdouble; const matrixCodeType_:T_AR_MATRIX_CODE_TYPE; errorCorrected_:P_int; codeGlobalID_p_:P_uint64_t ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Extract the image (i.e. locate and unwarp) of the pattern-space portion of a detected square.
    @param      imageProcMode See discussion of arSetImageProcMode().
    @param      pattDetectMode See discussion of arSetPatternDetectionMode().
    @param      patt_size The number of horizontal and vertical units to subdivide the pattern-space into.
    @param      sample_size At present, must always be the square of patt_size.
    @param      image Pointer to packed raw image data.
    @param      xsize Horizontal pixel dimension of raw image data.
    @param      ysize Vertical pixel dimension of raw image data.
    @param      pixelFormat Pixel format of raw image data.
    @param      arParamLTf Lookup table for the camera parameters for the optical source from which the image was acquired. See arParamLTCreate.
    @param      vertex 4x2 array of points which correspond to the x and y locations of the corners of the detected marker square.
    @param      pattRatio A value between 0.0 and 1.0, representing the proportion of the marker width which constitutes the pattern. In earlier versions, this value was fixed at 0.5.
    @param      ext_patt Pointer to an array of appropriate size (i.e. patt_size*patt_size*3), which will be filled with the extracted image. Where a colour image is available, it will be supplied in BGR byte order.
    @result     0 if the function was able to correctly get the image, or -1 in case of error or no match.
    @see    arParamLTCreate
 *)
function arPattGetImage2( imageProcMode_:T_int; pattDetectMode_:T_int; patt_size_:T_int; sample_size_:T_int; image_:P_ARUint8; xsize_:T_int; ysize_:T_int; pixelFormat_:T_AR_PIXEL_FORMAT; arParamLTf_:P_ARParamLTf; vertex_:T_ARdouble42; pattRatio_:T_ARdouble; ext_patt_:P_ARUint8 ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Extract the image (i.e. locate and unwarp) of an arbitrary portion of a detected square.
    @details Use this function to obtain an image of the marker pattern space for display to the user.
    @param      arHandle The ARHandle structure associated with the current tracking data.
    @param      markerNo The marker number (in range 0 to arHandle->marker_num - 1, inclusive) from which to extract the pattern.
    @param      image The source video image.
    @param      rect Pointer to an ARPattRectInfo structure which defines the portion of the marker image to extract.
    @param      xsize Width of the output image, in pixels.
    @param      ysize Height of the output image, in pixels.
    @param      overSampleScale Number of samples to acquire per destination pixel, e.g. 2.
    @param      outImage Pointer to a buffer, at least xsize*ysize*arUtilGetPixelSize(arHandle->arPixelFormat) bytes in size, which will be filled out with the marker image.
    @result     0 if the function was able to correctly get the image, or -1 in case of error or no match.
    @see    ARPattRectInfo
 *)
function arPattGetImage3( arHandle_:P_ARHandle; markerNo_:T_int; image_:P_ARUint8; rect_:P_ARPattRectInfo; xsize_:T_int; ysize_:T_int; overSampleScale_:T_int; outImage_:P_ARUint8 ) :T_int; stdcall; external _DLLNAME_;


(***********************************)
(*                                 *)
(*    For 3D calculation           *)
(*                                 *)
(***********************************)

(*!
    @functiongroup "3D calculation".
 *)

(*!
    @brief   Create handle used for 3D calculation from calibrated camera parameters.
    @details
        An AR3DHandle holds data structures used in calculating the 3D pose of a
        marker from the 2D location of its corners (i.e. pose estimation).
    @param      arParam (description)
    @result     The handle. When no more ar3D*() functions need be called, the handle should be deleted
        by calling ar3DDeleteHandle().
    @see    ar3DCreateHandle2
    @see    ar3DDeleteHandle
*)
function ar3DCreateHandle( const arParam_:P_ARParam ) :P_AR3DHandle; stdcall; external _DLLNAME_;

(*!
    @brief   Create handle used for 3D calculation from an intrinsic parameters matrix.
    @details
        An AR3DHandle holds data structures used in calculating the 3D pose of a
        marker from the 2D location of its corners (i.e. pose estimation).
    @param      cpara (description)
    @result     The handle. When no more ar3D*() functions need be called, the handle should be deleted
        by calling ar3DDeleteHandle().
    @see    ar3DCreateHandle
    @see    ar3DDeleteHandle
*)
function ar3DCreateHandle2( const cpara_:T_ARdouble34 ) :P_AR3DHandle; stdcall; external _DLLNAME_;

(*!
    @brief   Delete handle used for 3D calculation.
    @details When no more ar3D*() functions need be called, the handle should be deleted
        by calling ar3DDeleteHandle().
    @param      handle A pointer to the 3D handle. On success, the contents of this location will be set to NULL.
    @result     0 if the handle was successfully deleted, -1 otherwise.
    @see    ar3DDeleteHandle
*)
function ar3DDeleteHandle( handle_:PP_AR3DHandle ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      cpara (description)
    @result     (description)
*)
function ar3DChangeCpara( handle_:P_AR3DHandle; const cpara_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      maxLoopCount (description)
    @result     (description)
*)
function ar3DChangeMaxLoopCount( handle_:P_AR3DHandle; maxLoopCount_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      loopBreakThresh (description)
    @result     (description)
*)
function ar3DChangeLoopBreakThresh( handle_:P_AR3DHandle; loopBreakThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      loopBreakThreshRatio (description)
    @result     (description)
*)
function ar3DChangeLoopBreakThreshRatio( handle_:P_AR3DHandle; loopBreakThreshRatio_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      marker_info (description)
    @param      width (description)
    @param      conv (description)
    @result     (description)
*)
function arGetTransMatSquare( handle_:P_AR3DHandle; marker_info_:P_ARMarkerInfo; width_:T_ARdouble; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      marker_info (description)
    @param      initConv (description)
    @param      width (description)
    @param      conv (description)
    @result     (description)
*)
function arGetTransMatSquareCont( handle_:P_AR3DHandle; marker_info_:P_ARMarkerInfo; initConv_:T_ARdouble34; width_:T_ARdouble; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      initConv (description)
    @param      pos2d (description)
    @param      pos3d (description)
    @param      num (description)
    @param      conv (description)
    @result     (description)
*)
function arGetTransMat( handle_:P_AR3DHandle; initConv_:T_ARdouble34; pos2d_:T_ARdouble02; pos3d_:T_ARdouble03; num_:T_int; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;

(*!
    @brief   (description)
    @details (description)
    @param      handle (description)
    @param      initConv (description)
    @param      pos2d (description)
    @param      pos3d (description)
    @param      num (description)
    @param      conv (description)
    @result     (description)
*)
function arGetTransMatRobust( handle_:P_AR3DHandle; initConv_:T_ARdouble34; pos2d_:T_ARdouble02; pos3d_:T_ARdouble03; num_:T_int; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;


(***********************************)
(*                                 *)
(*    For 3D calculation by Stereo *)
(*                                 *)
(***********************************)

(*!
    @functiongroup "3D calculation by Stereo".
 *)

function ar3DStereoCreateHandle( const arParamL_:P_ARParam; const arParamR_:P_ARParam; const transL_:T_ARdouble34; const transR_:T_ARdouble34 ) :P_AR3DStereoHandle; stdcall; external _DLLNAME_;
function ar3DStereoCreateHandle2( const cparaL_:T_ARdouble34; const cparaR_:T_ARdouble34; const transL_:T_ARdouble34; const transR_:T_ARdouble34 ) :P_AR3DStereoHandle; stdcall; external _DLLNAME_;
function ar3DStereoDeleteHandle( handle_:PP_AR3DStereoHandle ) :T_int; stdcall; external _DLLNAME_;
function ar3DStereoChangeMaxLoopCount( handle_:P_AR3DStereoHandle; maxLoopCount_:T_int ) :T_int; stdcall; external _DLLNAME_;
function ar3DStereoChangeLoopBreakThresh( handle_:P_AR3DStereoHandle; loopBreakThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function ar3DStereoChangeLoopBreakThreshRatio( handle_:P_AR3DStereoHandle; loopBreakThreshRatio_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function ar3DStereoChangeCpara( handle_:P_AR3DStereoHandle; cparaL_:T_ARdouble34; cparaR_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function ar3DStereoChangeTransMat( handle_:P_AR3DStereoHandle; transL_:T_ARdouble34; transR_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;

function arGetTransMatSquareStereo( handle_:P_AR3DStereoHandle; marker_infoL_:P_ARMarkerInfo; marker_infoR_:P_ARMarkerInfo; width_:T_ARdouble; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;
function arGetTransMatSquareContStereo( handle_:P_AR3DStereoHandle; marker_infoL_:P_ARMarkerInfo; marker_infoR_:P_ARMarkerInfo; prev_conv_:T_ARdouble34; width_:T_ARdouble; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;
function arGetTransMatStereo( handle_:P_AR3DStereoHandle; initConv_:T_ARdouble34; pos2dL_:T_ARdouble02; pos3dL_:T_ARdouble03; numL_:T_int; pos2dR_:T_ARdouble02; pos3dR_:T_ARdouble03; numR_:T_int; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;
function arGetTransMatStereoRobust( handle_:P_AR3DStereoHandle; initConv_:T_ARdouble34; pos2dL_:T_ARdouble02; pos3dL_:T_ARdouble03; numL_:T_int; pos2dR_:T_ARdouble02; pos3dR_:T_ARdouble03; numR_:T_int; conv_:T_ARdouble34 ) :T_ARdouble; stdcall; external _DLLNAME_;

function arGetStereoMatchingErrorSquare( handle_:P_AR3DStereoHandle; marker_infoL_:P_ARMarkerInfo; marker_infoR_:P_ARMarkerInfo ) :T_ARdouble; stdcall; external _DLLNAME_;
function arGetStereoMatchingError( handle_:P_AR3DStereoHandle; pos2dL_:T_ARdouble2; pos2dR_:T_ARdouble2 ) :T_ARdouble; stdcall; external _DLLNAME_;
function arGetStereoMatching( handle_:P_AR3DStereoHandle; pos2dL_:T_ARdouble2; pos2dR_:T_ARdouble2; pos3d_:T_ARdouble3 ) :T_int; stdcall; external _DLLNAME_;

(***********************************)
(*                                 *)
(*    Utility                      *)
(*                                 *)
(***********************************)

(*!
    @functiongroup "Utility".
 *)

(*!
    @brief   Get the ARToolKit version information in numberic and string format.
    @details
        As of version 2.72, ARToolKit now allows querying of the version number
        of the toolkit available at runtime. It is highly recommended that
        any calling program that depends on features in a certain
        ARToolKit version, check at runtime that it is linked to a version
        of ARToolKit that can supply those features. It is NOT sufficient
        to check the ARToolKit SDK header versions, since with ARToolKit implemented
        in dynamically-loaded libraries, there is no guarantee that the
        version of ARToolKit installed on the machine at run-time will be as
        recent as the version of the ARToolKit SDK which the host
        program was compiled against.

        The version information is reported in binary-coded decimal format,
        and optionally in an ASCII string.

        A increase in the major version number indicates the removal of functionality
        previously provided in the API. An increase in the minor version number
        indicates that new functionality has been added. A change in the tiny version
        number indicates changes (e.g. bug fixes) which do not affect the API. See
        the comments in the config.h header for more discussion of the definition of
        major, minor, tiny and build version numbers.

    @param      versionStringRef
        If non-NULL, the location pointed to will be filled
        with a pointer to a string containing the version information.
        Fields in the version string are separated by spaces. As of version
        2.72.0, there is only one field implemented, and this field
        contains the major, minor and tiny version numbers
        in dotted-decimal format. The string is guaranteed to contain
        at least this field in all future versions of the toolkit.
        Later versions of the toolkit may add other fields to this string
        to report other types of version information. The storage for the
        string is malloc'ed inside the function. The caller is responsible
        for free'ing the string.
    @result
        Returns the full version number of the ARToolKit in
        binary coded decimal (BCD) format.
        BCD format allows simple tests of version number in the caller
        e.g. if ((arGetVersion(NULL) >> 16) > 0x0272) printf("This release is later than 2.72\n");
        The major version number is encoded in the most-significant byte
        (bits 31-24), the minor version number in the second-most-significant
        byte (bits 23-16), the tiny version number in the third-most-significant
        byte (bits 15-8), and the build version number in the least-significant
        byte (bits 7-0).
 *)
function arGetVersion( versionStringRef_:PP_char ) :T_ARUint32; stdcall; external _DLLNAME_;

function arUtilMatInv( const s_:T_ARdouble34; d_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function arUtilMatMul( const s1_:T_ARdouble34; const s2_:T_ARdouble34; d_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;

{$IFDEF ARDOUBLE_IS_FLOAT }
#define arUtilMatInvf arUtilMatInv
#define arUtilMatMulf arUtilMatMul
#define arUtilMatMuldff arUtilMatMul
{$ELSE}
function arUtilMatInvf( const s_:T_float34; d_:T_float34 ) :T_int; stdcall; external _DLLNAME_;
function arUtilMatMulf( const s1_:T_float34; const s2_:T_float34; d_:T_float34 ) :T_int; stdcall; external _DLLNAME_;
function arUtilMatMuldff( const s1_:T_ARdouble34; const s2_:T_float34; d_:T_float34 ) :T_int; stdcall; external _DLLNAME_;
{$ENDIF}
function arUtilMat2QuatPos( const m_:T_ARdouble34; q_:T_ARdouble4; p_:T_ARdouble3 ) :T_int; stdcall; external _DLLNAME_;
function arUtilQuatPos2Mat( const q_:T_ARdouble4; const p_:T_ARdouble3; m_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function arUtilQuatNorm( q_:T_ARdouble4 ) :T_int; stdcall; external _DLLNAME_;

function arUtilReplaceExt( filename_:P_char; n_:T_int; ext_:P_char ) :T_int; stdcall; external _DLLNAME_;
function arUtilRemoveExt( filename_:P_char ) :T_int; stdcall; external _DLLNAME_;
function arUtilDivideExt( const filename_:P_char; s1_:P_char; s2_:P_char ) :T_int; stdcall; external _DLLNAME_;

function arUtilGetSquareCenter( vertex_:T_ARdouble42; x_:P_ARdouble; y_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arUtilSortLabel( mask_:array of T_int; m_:T_int; n_:T_int; pos_:T_ARdouble02; area_:array of T_int; label_num_:T_int; l1_:T_int; x1_:T_int; y1_:T_int; l2_:T_int; x2_:T_int; y2_:T_int; label_:array of T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get the size in bytes of a single pixel for a given pixel format.
    @details
        Different pixel formats have different sizes in bytes, and therefore
        different storage requirements per row of pixels. Use this function
        to calculate the number of bytes required to store a single pixel
        of the given type.
    @param      arPixelFormat The pixel type whose size is to be measured.
    @result     Number of bytes required to store 1 pixel of the given type.
*)
function arUtilGetPixelSize( const arPixelFormat_:T_AR_PIXEL_FORMAT ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Get a string holding a descriptive name for a given pixel format enumeration.
    @details
        On occasions it can be useful to display to the user the format of the pixels
        which ARToolKit is processing. This funtion converts a pixel-format number
        into a human-readable string description.
    @param      arPixelFormat Enumerated pixel format number for which to retrieve a name.
    @result     A constant c-string holding a descriptive name for the pixel format.
        The string returned matches the constants used in the definition of the type
        AR_PIXEL_FORMAT, e.g. "AR_PIXEL_FORMAT_RGB".
*)
function arUtilGetPixelFormatName( const arPixelFormat_:T_AR_PIXEL_FORMAT ) :P_char; stdcall; external _DLLNAME_;

(*
    @brief Get the filename portion of a full pathname.
    @details
        Given a full or partial pathname passed in string path,
        returns a pointer to the first char of the filename
        portion of path.
 *)
function arUtilGetFileNameFromPath( const path_:P_char ) :P_char; stdcall; external _DLLNAME_;


(*!
    @brief Get file base name from a path.
    @details
        Given a full or partial pathname passed in string path,
        returns a string with the base name portion of path,
        i.e. the text between the rightmost path separator and the
        the rightmost '.' character, if any.
        If the filename contains no '.', returns the filename.
    @param path Full or partial pathname.
    @param convertToLowercase If convertToLowercase is TRUE, uppercase
        ASCII characters in the basename will be converted to lowercase.
    @result A string with the basename portion of path.
        NB: The returned string must be freed by the caller.
 *)
function arUtilGetFileBasenameFromPath( const path_:P_char; const convertToLowercase_:T_int ) :P_char; stdcall; external _DLLNAME_;

(*!
    @brief Get file extension from a path.
    @details
        Given a full or partial pathname passed in string path,
        returns a string with the extension portion of path,
        i.e. the text after the rightmost '.' character, if any.
        If the filename contains no '.', NULL is returned.
    @param path Full or partial pathname.
    @param convertToLowercase If convertToLowercase is TRUE, uppercase
        ASCII characters in the extension will be converted to lowercase.
    @result A string with the extension portion of path.
        NB: The returned string must be freed by the caller.
 *)
function arUtilGetFileExtensionFromPath( const path_:P_char; const convertToLowercase_:T_int ) :P_char; stdcall; external _DLLNAME_;

    (*
     @brief Get the directory portion of a full pathname.
     @details
        Given a full or partial pathname passed in string path,
        returns a string with the directory name portion of path.
        The string is placed into the buffer of size n pointed to by dir.
        If the string and its terminating null byte cannot be accomodated by the
        buffer, NULL is returned, otherwise dir is returned.
        The string is terminated by the directory separator if addSeparator != 0.
 *)
function arUtilGetDirectoryNameFromPath( dir_:P_char; const path_:P_char; const n_:T_size_t; const addSeparator_:T_int ) :P_char; stdcall; external _DLLNAME_;

(*!
    @brief Get a path as a file URI.
    @details
        Given a full or partial pathname passed in string path,
        returns a string with the file URI for that path.

        Partial pathnames are handled by concatening with the
        process's current working directory.
    @param path Full or partial pathname.

        On Windows, both partial pathnames, full pathnames including
        the drive letter, or UNC pathnames (beginning with "\\" are
        all OK.
    @result A string with the the file URI for that path, or NULL
        in the case of error.
        NB: The returned string must be freed by the caller (by
        calling free() once its use is complete).
 *)
function arUtilGetFileURI( const path_:P_char ) :P_char; stdcall; external _DLLNAME_;

(*!
    @brief Options for controlling the behavior of arUtilGetResourcesDirectoryPath and arUtilChangeToResourcesDirectory.
    @see arUtilGetResourcesDirectoryPath
    @see arUtilChangeToResourcesDirectory
 *)
type T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR = (
       (*!
           Use a platform-dependent recommended-best option.
           Note the this behavior is subject to change in future versions of ARToolKit.
           At present, on macOS and iOS, this will change to the Apple-provided resources directory inside the application bundle.
           At present, on other platforms, this will change to the same directory as the executable.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_BEST = 0,
       (*!
           Use the current working directory. For arUtilChangeToResourcesDirectory, this will leave the current working directory unchanged.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_CWD,
       (*!
           Change to the working directory specified.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_SUPPLIED_PATH,
       (*!
           Change to the same directory as the executable.
           On OS X and iOS, this corresponds to the directory of the binary executable inside the app bundle, not the directory containing the app bundle.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_EXECUTABLE_DIR,
       (*!
           Change to the resources directory.
           On macOS and iOS, this is the Resources directory inside the application bundle.
           On Linux, this is a directory formed by taking the path to the directory containing
           the executable, appending "/../share" to it, and then pointing to a subdirectory under
           this path with the same name as the executable. Note that the existence of this path
           is not guaranteed. E.g. for an executable at path '/usr/bin/myapp' the returned path
           will be '/usr/bin/../share/myapp'.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_BUNDLE_RESOURCES_DIR,
       (*!
           Change to the root of the implementation-dependent user-writable root.
           On iOS and sandboxed macOS, this is equivalent to the root of the application sandbox.
           On Linux and non-sandboxed macOS, this is equivalent to the "~" user home.
           On Android, this is the root of the "external" storage (e.g. an SD card).
           On Windows, this is the user home directory, typically "C:\Documents and Settings\USERNAME" or "C:\Users\USERNAME".
           On Windows UWP
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_USER_ROOT,
       (*!
           Change to a writable cache directory, i.e. a directory which is not normally shown to the user, in which files which may be subject to deletion by the system or the user.
           On Android, this is the applications's (internal) cache directory, and a valid instance of Android/Context must be passed in the instanceofAndroidContext parameter.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_APP_CACHE_DIR,
       (*!
           Change to a writable data directory, i.e. a directory which is not normally shown to the user, but in which files are retained permanently.
           On Android, this is the applications's (internal) files directory, and a valid instance of Android/Context must be passed in the instanceofAndroidContext parameter.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_APP_DATA_DIR,
       (*!
        Change to a writable temporary directory, i.e. a directory which is not normally shown to the user, and from which files may be deleted at the end of program execution.
        On Android, this is the applications's (internal) cache directory, and a valid instance of Android/Context must be passed in the instanceofAndroidContext parameter.
        *)
       AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_TMP_DIR
     );

(*!
    @brief   Get the path to the resources directory using the specified behavior.
    @details
        ARToolKit uses relative paths to locate several types of resources, including
        camera parameter files, pattern files, multimarker files and others.
        This function provides the convenience of finding an appropriate value for your
        application.

        On Android only, the function has an optional parameter 'instanceOfAndroidContext'.
        If behavior is AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_APP_CACHE_DIR, this
        parameter must be an instance of a class derived from android/content/Context.
        In all other cases, pass NULL for this parameter.
    @param behavior See AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR type for allowed values.
    @result NULL in the case of error, or the path otherwise. Must be free()d by the caller.
 *)
{$IFDEF ANDROID }
function arUtilGetResourcesDirectoryPath( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR; instanceOfAndroidContext_:T_jobject ) :P_char; stdcall; external _DLLNAME_;
{$ELSE}
function arUtilGetResourcesDirectoryPath( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR ) :P_char; stdcall; external _DLLNAME_;
{$ENDIF}

(*!
    @brief   Get the path to the resources directory using the specified behavior, creating the path if it doesn't already exist.
    @details
        ARToolKit uses relative paths to locate several types of resources, including
        camera parameter files, pattern files, multimarker files and others.
        This function provides the convenience of finding an appropriate value for your
        application.

        On Android only, the function has an optional parameter 'instanceOfAndroidContext'.
        If behavior is AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_APP_CACHE_DIR, this
        parameter must be an instance of a class derived from android/content/Context.
        In all other cases, pass NULL for this parameter.
    @param behavior See AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR type for allowed values.
    @result NULL in the case of error, or the path otherwise. Must be free()d by the caller.
 *)
{$IFDEF ANDROID }
function arUtilGetAndCreateResourcesDirectoryPath( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR; instanceOfAndroidContext_:T_jobject ) :P_char; stdcall; external _DLLNAME_;
{$ELSE}
function arUtilGetAndCreateResourcesDirectoryPath( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR ) :P_char; stdcall; external _DLLNAME_;
{$ENDIF}

{$IFNDEF _WINRT }
(*!
    @brief   Change to the resources directory using the specified behavior.
    @details
        ARToolKit uses relative paths to locate several types of resources, including
        camera parameter files, pattern files, multimarker files and others.
        This function provides the convenience of setting the current process
        working directory to the appropriate value for your application.

        On Android only, the function has an optional parameter 'instanceOfAndroidContext'.
        If behavior is AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_APP_CACHE_DIR, this
        parameter must be an instance of a class derived from android/content/Context.
        In all other cases, pass NULL for this parameter.
    @param behavior See AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR type for allowed values.
    @param path When behavior is AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR_USE_SUPPLIED_PATH,
        the path to change to (absolute or relative to current working directory). In all
        other cases, if this parameter is non-NULL, it will be taken as a subdirectory
        of the desired path and to which the working directory should be changed.
    @result -1 in the case of error, or 0 otherwise.
    @since Not available on Windows Runtime (WinRT).
 *)
{$IFDEF ANDROID }
function arUtilChangeToResourcesDirectory( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR; const path_:P_char; instanceOfAndroidContext_:T_jobject ) :T_int; stdcall; external _DLLNAME_;
{$ELSE}
function arUtilChangeToResourcesDirectory( behavior_:T_AR_UTIL_RESOURCES_DIRECTORY_BEHAVIOR; const path_:P_char ) :T_int; stdcall; external _DLLNAME_;
{$ENDIF}
{$ENDIF} // !_WINRT

(*!
    @brief   Prints a transformation matrix via ARLOG(...).
    @param trans The transformation matrix to print.
 *)
procedure arUtilPrintTransMat( const trans_:T_ARdouble34 ); stdcall; external _DLLNAME_;

(*!
    @brief   Prints a 4x4 row-major matrix via ARLOG(...).
    @param mtx16 The matrix to print.
 *)
procedure arUtilPrintMtx16( const mtx16_:T_ARdouble16 ); stdcall; external _DLLNAME_;

{$IFDEF ANDROID }
    //Call from native code to do the following in Java source:
    //    import android.provider.Settings.Secure;
    //    private String android_id = Secure.getString(getContext().getContentResolver(),
    //                                                 Secure.ANDROID_ID);
    char* arUtilGetAndroidDevID();
{$ENDIF} //#ifdef ANDROID

//{$IFDEF __cplusplus }
//}
//{$ENDIF} //#ifdef __cplusplus

implementation //############################################################### ■

end. //######################################################################### ■
