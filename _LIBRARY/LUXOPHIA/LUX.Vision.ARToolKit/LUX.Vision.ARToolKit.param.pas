unit LUX.Vision.ARToolKit.param;

(*
 *  param.h
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
 *  Copyright 2003-2015 ARToolworks, Inc.
 *
 *  Author(s): Takeshi Mita, Shinsaku Hiura, Hirokazu Kato, Philip Lamb
 *
 *)
(*******************************************************
 *
 * Author: Takeshi Mita, Shinsaku Hiura, Hirokazu Kato
 *
 *         tmita@inolab.sys.es.osaka-u.ac.jp
 *         shinsaku@sys.es.osaka-u.ac.jp
 *         kato@sys.im.hiroshima-cu.ac.jp
 *
 * Revision: 5.0
 * Date: 03/08/13
 *
 *******************************************************)

interface //#################################################################### ■

uses LUX.Code.C,
     LUX.Vision.ARToolKit.ar;

(*!
    @file param.h
    @brief   ARToolKit functions for handling calibrated camera parameters.
    @details
*)
(*!
    @brief   Default version for functions accepting a "distortion function version" parameter.
    @details See function arParamObserv2Ideal() for discussion.
*)
const AR_DIST_FUNCTION_VERSION_DEFAULT = 4;
(*!
    @brief   Maximum version allowable for functions accepting a "distortion function version" parameter.
    @details See function arParamObserv2Ideal() for discussion.
*)
const AR_DIST_FUNCTION_VERSION_MAX = 4;
(*!
    @brief   Maximum number of values in a distortion factor array.
    @details See function arParamObserv2Ideal() for discussion.
*)
const AR_DIST_FACTOR_NUM_MAX = 9;
(*!
    @brief   Default padding added around a lookup-table based camera parameter.
    @details See function arParamLTCreate() for discussion.
*)
const AR_PARAM_LT_DEFAULT_OFFSET = 15;

(*!
    @brief   Structure holding camera parameters, including image size, projection matrix and lens distortion parameters.
    @details
        ARToolKit's tracking depends on accurate knowledge of the properties of the
        imaging system used to acquire input images. This structure holds the properties
        of an imaging system for internal use in ARToolKit. This information is used
        throughout the entire ARToolKit pipeline, including knowing the size of images
        being returned by the video library, marker detection and pose estimation,
        and warping of camera images for video-see-through registration.
    @see    arParamClear
    @see    arParamLoad
    @see    arParamSave
 *)
type T_ARParam = record
       xsize                 :T_int;                                               ///< The width in pixels of images returned by arVideoGetImage() for the camera.
       ysize                 :T_int;                                               ///< The height in pixels of images returned by arVideoGetImage() for the camera.
       mat                   :array [ 0..3-1, 0..4-1 ] of T_ARdouble;              ///< The projection matrix for the calibrated camera parameters. This can be converted to an OpenGL projection matrix by the function arglCameraFrustumRHf().
       dist_factor           :array [ 0..AR_DIST_FACTOR_NUM_MAX-1 ] of T_ARdouble; ///< See function arParamObserv2Ideal() for discussion.
       dist_function_version :T_int;                                               ///< See function arParamObserv2Ideal() for discussion. Must be last field in structure (as will not be written to disk).
     end;

type T_arParamVersionInfo_t = record
       dist_factor_num :T_int;
       ARParam_size    :T_int;
     end;
(*!
    @brief   Constant array with parameters applicable to each version of the camera parameter distortion function.
 *)
var arParamVersionInfo :array [ 0..AR_DIST_FUNCTION_VERSION_MAX-1 ] of T_arParamVersionInfo_t;

(*!
    @brief   Structure holding camera parameters, in lookup table form; floating point version.
    @see ARParamLT
 *)
type T_ARParamLTf = record
       i2o   :P_float; ///< Ideal-to-observed; for the location in the array corresponding to the idealised location, gives the location in the observed image.
       o2i   :P_float; ///< Observed-to-ideal; for the location in the array corresponding to the observed location, gives the location in the idealised image.
       xsize :T_int;   ///< The number of pixels in the array's x dimension, including the offset areas on the left and right sides, i.e. ARParam.xsize + xOff*2.
       ysize :T_int;   ///< The number of pixels in the array's x dimension, including the offset areas on the top and bottom.xsize, i.e. ARParam.ysize + yOff*2.
       xOff  :T_int;   ///< The number of pixels from the left edge of the array to column zero of the input.
       yOff  :T_int;   ///< The number of pixels from the top edge of the array to row zero of the input.
     end;
    
//typedef struct {
//    short   *i2o;
//    short   *o2i;
//    int      xsize;
//    int      ysize;
//    int      xOff;
//    int      yOff;
//} ARParamLTi;

(*!
    @brief   Structure holding camera parameters, in lookup table form.
    @details
        ARToolKit's tracking depends on accurate knowledge of the properties of the
        imaging system used to acquire input images. This structure holds the properties
        of an imaging system for internal use in ARToolKit. This information is used
        throughout the entire ARToolKit pipeline, including knowing the size of images
        being returned by the video library, marker detection and pose estimation,
        and warping of camera images for video-see-through registration.

        This version of the structure contains a pre-calculated lookup table of
        values covering the camera image width and height, plus a padded border.
*)
type T_ARParamLT = record
       param    :T_ARParam;    ///< A copy of original ARParam from which the lookup table was calculated.
       paramLTf :T_ARParamLTf; ///< The lookup table.
     //paramLTi :T_ARParamLTi;
     end;
     P_ARParamLT = ^T_ARParamLT;

function arParamDisp( const ARParam *param ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Create a camera parameter structure representing an idealised lens.
    @details
        This function creates a camera parameter structure representing an idealised lens,
        that is, a lens with a symmetrical perspective projection and no distortion.
        This idealised lens is useful in cases where you wish to match the lens model
        of an OpenGL camera with the same window dimensions.
    @param param Pointer to an ARParam structure which will be filled out with
        the resulting camera parameters.
    @param xsize The horizontal dimension of the image.
    @param ysize The vertical dimension of the image.
    @param dist_function_version Allows creation of parameters with an older version
        of the lens distortion model. Pass AR_DIST_FUNCTION_VERSION_DEFAULT to create an ARParam
        with the current lens distortion model, or a lesser integer to use an earlier version.
    @result 0 if the function completed successfully, or -1 in case of error.
 *)
function arParamClear( param_:P_ARParam; xsize_:T_int; ysize_:T_int; dist_function_version_:T_int ) :T_int; stdcall; external _DLLNAME_;

function arParamDistFactorClear( dist_factor[AR_DIST_FACTOR_NUM_MAX]_:T_ARdouble; xsize_:T_int; ysize_:T_int; dist_function_version_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Create a camera parameter structure representing an idealised lens with specified field-of-view.
    @details
        This function creates a camera parameter structure representing an idealised lens,
        that is, a lens with a symmetrical perspective projection and no distortion.
        This idealised lens is useful in cases where you wish to match the lens model
        of an OpenGL camera with the same window dimensions.
    @param param Pointer to an ARParam structure which will be filled out with
        the resulting camera parameters.
    @param xsize The horizontal dimension of the image.
    @param ysize The vertical dimension of the image.
    @param FOVy Field-of-view in the vertical (Y) dimension, in radians. If you know
        only the value in degrees, pass that value multiplied by (M_PI/180.0f).
    @result 0 if the function completed successfully, or -1 in case of error.
 *)
function arParamClearWithFOVy( param_:P_ARParam; xsize_:T_int; ysize_:T_int; FOVy_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arParamChangeSize( source_:P_ARParam; xsize_:T_int; ysize_:T_int; newparam_:P_ARParam ) :T_int; stdcall; external _DLLNAME_;

function arParamDecomp( const source_:P_ARParam; icpara_:P_ARParam; trans[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arParamDecompMat( const source[3][4]_:T_ARdouble; cpara[3][4]_:T_ARdouble; trans[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

{$IFDEF ARDOUBLE_IS_FLOAT }
#define arParamDecompMatf arParamDecompMat
{$ELSE}
function arParamDecompMatf( const source[3][4]_:T_ARdouble; cpara[3][4]_:T_float; trans[3][4]_:T_float ) :T_int; stdcall; external _DLLNAME_;
{$ENDIF}

(*!
    @brief   Use lens distortion parameters to convert idealised (zero-distortion) window coordinates to observed (distorted) coordinates.
    @details
        See function arParamObserv2Ideal() for full discussion.
 
        This function is the output function of the pair. It's inputs are
        idealised coordinates, e.g. taken from OpenGL. The outputs are the
        location where in a distorted image where the same point would lie.
    @param      dist_factor An array of ARdouble values holding the lens distortion
        parameters. These values are generated as part of the camera calibration
        process in ARToolKit. The exact number of values from the array used by the
        function is determined by the distortion function version, but does not
        exceed AR_DIST_FACTOR_NUM_MAX.
    @param      ix Input idealised normalised window coordinate x axis value.
    @param      iy Input idealised normalised window coordinate y axis value.
    @param      ox Pointer to ARdouble, which on return will hold the observed normalised window coordinate x axis value.
    @param      oy Pointer to ARdouble, which on return will hold the observed normalised window coordinate y axis value.
    @param      dist_function_version An integer, in the range [1, AR_DIST_FUNCTION_VERSION_MAX] which determines the
        algorithm used to interpret the dist_factor values.
 
        See function arParamObserv2Ideal() for full discussion.
    @result     0 in case of function success, or -1 if an error occured. At
        present the only error possible is an invalid value of dist_function_version.
    @see arParamObserv2Ideal
    @see arParamObserv2IdealLTf
*)
function arParamIdeal2Observ( const dist_factor[AR_DIST_FACTOR_NUM_MAX]_:T_ARdouble; const ix_:T_ARdouble; const iy_:T_ARdouble; ox_:P_ARdouble; oy_:P_ARdouble; const dist_function_version_:T_int ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Use lens distortion parameters to convert observed (distorted) window coordinates to idealised (zero-distortion) coordinates.
    @details
        This function is used by ARToolKit to convert for the
        the effects of lens distortion in images which have been acquired
        from lens-based optical systems. All lenses introduce some amount
        of lens distortion. ARToolKit includes calibration utilities to
        measure the centre of distortion and the radial distortion factors
        in the x and y dimensions. This calibration information is saved
        as part of the camera parameters.

        This function is one of a pair of functions which convert between
        OBSERVED window coordinates (i.e. the location of a known reference
        point, as measured in the x-y viewing plane of an image containing
        lens distortion) and IDEALISED coordinates (i.e. the location of the
        same reference point as measured in an image containing no radial
        distortion, e.g. an image rendered using OpenGL's viewing model.)
 
        This function is the input function of the pair. It's inputs are
        distorted coordinates, e.g. taken from an image acquired from a camera
        The outputs are the location where in an idealised image (e.g. generated
        with OpenGL) where the same point would lie.
 
    @param      dist_factor An array of ARdouble values holding the lens distortion
        parameters. These values are generated as part of the camera calibration
        process in ARToolKit. The exact number of values from the array used by the
        function is determined by the distortion function version, but does not
        exceed AR_DIST_FACTOR_NUM_MAX.
    @param      ix Input observed normalised window coordinate x axis value.
    @param      iy Input observed normalised window coordinate y axis value.
    @param      ox Pointer to ARdouble, which on return will hold the idealised normalised window coordinate x axis value.
    @param      oy Pointer to ARdouble, which on return will hold the idealised normalised window coordinate y axis value.
    @param      dist_function_version An integer, in the range [1, AR_DIST_FUNCTION_VERSION_MAX] which determines the
        algorithm used to interpret the dist_factor values.
 
        The values correspond to the following algorithms:
 
        version 1: The original ARToolKit lens model, with a single radial distortion factor, plus center of distortion.<br>
        version 2: Improved distortion model, introduced in ARToolKit v4.0. This algorithm adds a quadratic term to the radial distortion factor of the version 1 algorithm.<br>
        version 3: Improved distortion model with aspect ratio, introduced in ARToolKit v4.0. The addition of an aspect ratio to the version 2 algorithm allows for non-square pixels, as found e.g. in DV image streams.<br>
        version 4: OpenCV-based distortion model, introduced in ARToolKit v4.3. This differs from the standard OpenCV model by the addition of a scale factor, so that input values do not exceed the range [-1.0, 1.0] in either forward or inverse conversions.
    @result     0 in case of function success, or -1 if an error occured. At
        present the only error possible is an invalid value of dist_function_version.
    @see arParamIdeal2Observ
    @see arParamIdeal2ObservLTf
*)
function arParamObserv2Ideal( const dist_factor[AR_DIST_FACTOR_NUM_MAX]_:T_ARdouble; const ox_:T_ARdouble; const oy_:T_ARdouble; ix_:P_ARdouble; iy_:P_ARdouble; const dist_function_version_:T_int ) :T_int; stdcall; external _DLLNAME_;
(*!
    @brief Save lens parameters to a file.
    @details
        See the discussion under ARParam for more info.
    @param filename Path to file to which to save the parameters.
        The file pointed to may later be reloaded with arParamLoad.
    @param num Number of ARParams to be saved, normally 1.
    @param param Pointer to the ARParam structure to save.
    @result 0 if successful, or -1 if an error occured.
    @see ARParam
    @see arParamLoad
    @see arParamLoadFromBuffer
 *)
function arParamSave( const filename_:P_char; const num_:T_int; const param_:P_ARParam ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief Load lens parameters from a file.
    @details
        See the discussion under ARParam for more info.
    @param filename Path to file from which to load the parameters.
        The file pointed to should be a file saved with arParamSave.
    @param num Number of ARParams to be loaded, normally 1.
    @param param Pointer to the ARParam structure into which the parameters will be read.
    @result 0 if successful, or -1 if an error occured.
    @see ARParam
    @see arParamLoadFromBuffer
    @see arParamSave
 *)
function arParamLoad( const filename_:P_char; num_:T_int; param_:P_ARParam ) :T_int; stdcall; external _DLLNAME_;

    (*!
      @brief Load lens parameters from a buffer.
     @details
        See the discussion under ARParam for more info.
     @param buffer Buffer from which the parameter(s) will be loaded.
        The buffer could be (for example) the contents of a parameter file read with fread().
     @param bufsize Size of the contents of buffer.
     @param param Pointer to the ARParam structure into which the parameters will be read.
     @result 0 if successful, or -1 if an error occured.
     @see ARParam
     @see arParamLoad
     @see arParamSave
     *)
function arParamLoadFromBuffer( const buffer_:P_void; bufsize_:T_size_t; param_:P_ARParam ) :T_int; stdcall; external _DLLNAME_;
    
function arParamGetPerspectiveMat( global[][3]_:T_ARdouble; idealScreen[][2]_:T_ARdouble; data_num_:T_int; mat[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arParamSaveExt( const filename_:P_char; para[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamLoadExt( const filename_:P_char; para[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamLoadExtFromBuffer( const buffer_:P_void; bufsize_:T_size_t; para[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamDispExt( para[3][4]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arParamSaveOptical( const filename_:P_char; const fovy_:T_ARdouble; const aspect_:T_ARdouble; const m[16]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamLoadOptical( const filename_:P_char; fovy_p_:P_ARdouble; aspect_p_:P_ARdouble; m[16]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamLoadOpticalFromBuffer( const buffer_:P_void; bufsize_:T_size_t; fovy_p_:P_ARdouble; aspect_p_:P_ARdouble; m[16]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function arParamDispOptical( const fovy_:T_ARdouble; const aspect_:T_ARdouble; const m[16]_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;

function arParamLTSave( filename_:P_char; ext_:P_char; paramLT_:P_ARParamLT ) :T_int; stdcall; external _DLLNAME_;
function arParamLTLoad( filename_:P_char; ext_:P_char ) :P_ARParamLT; stdcall; external _DLLNAME_;

(*!
    @brief Allocate and calculate a lookup-table camera parameter from a standard camera parameter.
    @details A lookup-table based camera parameter offers significant performance
        savings in certain ARToolKit operations (including unwarping of pattern spaces)
        compared to use of the standard camera parameter.
    
        The original ARParam camera parameters structure is copied into the ARParamLT
        structure, and is available as paramLT->param.
    @param param A pointer to an ARParam structure from which the lookup table will be generaeted.
        This ARParam structure will be copied, and the original may be disposed of.
    @param offset An integer value which specifies how much the lookup table values will be
        padded around the original camera parameters size. Normally, the default value
        AR_PARAM_LT_DEFAULT_OFFSET (defined elsewhere in this header) should be used. However,
        when using a camera with a large amount of lens distortion, a higher value may be
        required to cope with the corners or sides of the camera image frame.
    @result A pointer to a newly-allocated ARParamLT structure, or NULL if an error
        occurred. Once the ARParamLT is no longer needed, it should be disposed
        of by calling arParamLTFree() on it.
    @see arParamLTFree
 *)
function arParamLTCreate( param_:P_ARParam; offset_:T_int ) :P_ARParamLT; stdcall; external _DLLNAME_;

(*!
    @brief Dispose of a memory allocated to a lookup-table camera parameter.
    @param paramLT_p Pointer to a pointer to the paramLT structure to be disposed of.
        On return, the location pointed to will be set to NULL.
    @result -1 if an error occurred, or 0 in the case of no error.
    @see arParamLTCreate
 *)
function arParamLTFree( paramLT_p_:PP_ARParamLT ) :T_int; stdcall; external _DLLNAME_;

(*!
    @brief   Use a lookup-table camera parameter to convert idealised (zero-distortion) window coordinates to observed (distorted) coordinates.
    @details
        See function arParamObserv2IdealLTf() for full discussion.
 
        This function is the output function of the pair. It's inputs are
        idealised coordinates, e.g. taken from OpenGL. The outputs are the
        location where in a distorted image where the same point would lie.
    @param      paramLTf A lookup-table based version of the lens distortion
        parameters. These values are generated as part of the camera calibration
        process in ARToolKit, and converted to a lookup table by arParamLTCreate().
    @param      ix Input idealised normalised window coordinate x axis value.
    @param      iy Input idealised normalised window coordinate y axis value.
    @param      ox Pointer to ARdouble, which on return will hold the observed normalised window coordinate x axis value.
    @param      oy Pointer to ARdouble, which on return will hold the observed normalised window coordinate y axis value.
    @result     0 in case of function success, or -1 if an error occured. One possible
        error condition is the case where the input portion of the pair is outside the
        range of coordinates covered by the lookup table.
    @see arParamLTCreate
    @see arParamIdeal2Observ
    @see arParamObserv2IdealLTf
*)

function arParamIdeal2ObservLTf( const paramLTf_:P_ARParamLTf; const ix_:T_float; const iy_:T_float; ox_:P_float; oy_:P_float ) :T_int; stdcall; external _DLLNAME_;

    
(*!
    @brief   Use a lookup-table camera parameter to convert observed (distorted) window coordinates to idealised (zero-distortion) coordinates.
    @details
        This function is used by ARToolKit to convert for the
        the effects of lens distortion in images which have been acquired
        from lens-based optical systems. All lenses introduce some amount
        of lens distortion. ARToolKit includes calibration utilities to
        measure the centre of distortion and the radial distortion factors
        in the x and y dimensions. This calibration information is saved
        as part of the camera parameters.

        This function is one of a pair of functions which convert between
        OBSERVED window coordinates (i.e. the location of a known reference
        point, as measured in the x-y viewing plane of an image containing
        lens distortion) and IDEALISED coordinates (i.e. the location of the
        same reference point as measured in an image containing no radial
        distortion, e.g. an image rendered using OpenGL's viewing model.)
 
        This function is the input function of the pair. It's inputs are
        distorted coordinates, e.g. taken from an image acquired from a camera
        The outputs are the location where in an idealised image (e.g. generated
        with OpenGL) where the same point would lie.
 
    @param      paramLTf A lookup-table based version of the lens distortion
        parameters. These values are generated as part of the camera calibration
        process in ARToolKit, and converted to a lookup table by arParamLTCreate().
    @param      ix Input observed normalised window coordinate x axis value.
    @param      iy Input observed normalised window coordinate y axis value.
    @param      ox Pointer to ARdouble, which on return will hold the idealised normalised window coordinate x axis value.
    @param      oy Pointer to ARdouble, which on return will hold the idealised normalised window coordinate y axis value.
    @result     0 in case of function success, or -1 if an error occured. One possible
        error condition is the case where the input portion of the pair is outside the
        range of coordinates covered by the lookup table.
    @see arParamObserv2Ideal
    @see arParamIdeal2ObservLTf
*)
function arParamObserv2IdealLTf( const paramLTf_:P_ARParamLTf; const ox_:T_float; const oy_:T_float; ix_:P_float; iy_:P_float ) :T_int; stdcall; external _DLLNAME_;

//function arParamIdeal2ObservLTi( const paramLTi_:P_ARParamLTi; const ix_:T_int; const iy_:T_int; ox_:P_int; oy_:P_int ) :T_int; stdcall; external _DLLNAME_;

//function arParamObserv2IdealLTi( const paramLTi_:P_ARParamLTi; const ox_:T_int; const oy_:T_int; ix_:P_int; iy_:P_int ) :T_int; stdcall; external _DLLNAME_;

implementation //############################################################### ■

end. //######################################################################### ■
