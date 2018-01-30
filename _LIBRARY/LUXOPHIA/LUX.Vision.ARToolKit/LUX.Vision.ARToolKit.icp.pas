unit LUX.Vision.ARToolKit.icp;

(*
 *  icp.h
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
 *  Copyright 2004-2015 ARToolworks, Inc.
 *
 *  Author(s): Hirokazu Kato
 *
 *)

interface //#################################################################### ■

uses LUX.Code.C,
     LUX.Vision.ARToolKit.define,
     LUX.Vision.ARToolKit.icpCore;

const ICP_TRANS_MAT_IDENTITY = nil;

(*
 *  Point Data
 *)
type T_ICPDataT = record
       screenCoord :P_ICP2DCoordT;
       worldCoord  :P_ICP3DCoordT;
       num         :T_int;
     end;
     P_ICPDataT = ^T_ICPDataT;

type T_ICPStereoDataT = record
       screenCoordL :P_ICP2DCoordT;
       worldCoordL  :P_ICP3DCoordT;
       numL         :T_int;
       screenCoordR :P_ICP2DCoordT;
       worldCoordR  :P_ICP3DCoordT;
       numR         :T_int;
     end;
     P_ICPStereoDataT = ^T_ICPStereoDataT;

(*
 *  Handle
 *)
type T_ICPHandleT = record
       matXc2U                   :array [ 0..3-1, 0..4-1 ] of T_ARdouble;
       maxLoop                   :T_int;
       breakLoopErrorThresh      :T_ARdouble;
       breakLoopErrorRatioThresh :T_ARdouble;
       breakLoopErrorThresh2     :T_ARdouble;
       inlierProb                :T_ARdouble;
     end;
     P_ICPHandleT = ^T_ICPHandleT;
    PP_ICPHandleT = ^P_ICPHandleT;

type T_ICPStereoHandleT = record
       matXcl2Ul                 :array [ 0..3-1, 0..4-1 ] of T_ARdouble;
       matXcr2Ur                 :array [ 0..3-1, 0..4-1 ] of T_ARdouble;
       matC2L                    :array [ 0..3-1, 0..4-1 ] of T_ARdouble;
       matC2R                    :array [ 0..3-1, 0..4-1 ] of T_ARdouble;
       maxLoop                   :T_int;
       breakLoopErrorThresh      :T_ARdouble;
       breakLoopErrorRatioThresh :T_ARdouble;
       breakLoopErrorThresh2     :T_ARdouble;
       inlierProb                :T_ARdouble;
     end;
     P_ICPStereoHandleT = ^T_ICPStereoHandleT;
    PP_ICPStereoHandleT = ^P_ICPStereoHandleT;

(*------------ icpUtil.c --------------*)
function icpGetInitXw2Xc_from_PlanarData( matXc2U_:T_ARdouble34; screenCoord_:array of T_ICP2DCoordT; worldCoord_:array of T_ICP3DCoordT; num_:T_int; initMatXw2Xc_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;

(*------------ icpPoint.c --------------*)
function icpCreateHandle( matXc2U_:T_ARdouble34 ) :P_ICPHandleT; stdcall; external _DLLNAME_;
function icpDeleteHandle                 ( handle_:PP_ICPHandleT ) :T_int; stdcall; external _DLLNAME_;
function icpSetMatXc2U                   ( handle_:P_ICPHandleT; matXc2U_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpGetMatXc2U                   ( handle_:P_ICPHandleT; matXc2U_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpSetMaxLoop                   ( handle_:P_ICPHandleT; maxLoop_:T_int ) :T_int; stdcall; external _DLLNAME_;
function icpGetMaxLoop                   ( handle_:P_ICPHandleT; maxLoop_:P_int ) :T_int; stdcall; external _DLLNAME_;
function icpSetBreakLoopErrorThresh      ( handle_:P_ICPHandleT; breakLoopErrorThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpGetBreakLoopErrorThresh      ( handle_:P_ICPHandleT; breakLoopErrorThresh_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpSetBreakLoopErrorRatioThresh ( handle_:P_ICPHandleT; breakLoopErrorThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpGetBreakLoopErrorRatioThresh ( handle_:P_ICPHandleT; breakLoopErrorThresh_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpSetBreakLoopErrorThresh2     ( handle_:P_ICPHandleT; breakLoopErrorThresh2_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpGetBreakLoopErrorThresh2     ( handle_:P_ICPHandleT; breakLoopErrorThresh2_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpSetInlierProbability         ( handle_:P_ICPHandleT; inlierProbability_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpGetInlierProbability         ( handle_:P_ICPHandleT; inlierProbability_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpPoint                        ( handle_:P_ICPHandleT; data_:P_ICPDataT; initMatXw2Xc_:T_ARdouble34; matXw2Xc_:T_ARdouble34; err_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpPointRobust                  ( handle_:P_ICPHandleT; data_:P_ICPDataT; initMatXw2Xc_:T_ARdouble34; matXw2Xc_:T_ARdouble34; err_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;

(*------------ icpPointStereo.c --------------*)
function icpStereoCreateHandle( matXcl2Ul_:T_ARdouble34; matXcr2Ur_:T_ARdouble34; matC2L_:T_ARdouble34; matC2R_:T_ARdouble34 ) :P_ICPStereoHandleT; stdcall; external _DLLNAME_;
function icpStereoDeleteHandle                 ( handle_:PP_ICPStereoHandleT ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetMatXcl2Ul                 ( handle_:P_ICPStereoHandleT; matXcl2Ul_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetMatXcr2Ur                 ( handle_:P_ICPStereoHandleT; matXcr2Ur_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetMatXcl2Ul                 ( handle_:P_ICPStereoHandleT; matXcl2Ul_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetMatXcr2Ur                 ( handle_:P_ICPStereoHandleT; matXcr2Ur_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetMatC2L                    ( handle_:P_ICPStereoHandleT; matC2L_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetMatC2R                    ( handle_:P_ICPStereoHandleT; matC2R_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetMatC2L                    ( handle_:P_ICPStereoHandleT; matC2L_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetMatC2R                    ( handle_:P_ICPStereoHandleT; matC2R_:T_ARdouble34 ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetMaxLoop                   ( handle_:P_ICPStereoHandleT; maxLoop_:T_int ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetMaxLoop                   ( handle_:P_ICPStereoHandleT; maxLoop_:P_int ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetBreakLoopErrorThresh      ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetBreakLoopErrorThresh      ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetBreakLoopErrorRatioThresh ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetBreakLoopErrorRatioThresh ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetBreakLoopErrorThresh2     ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh2_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetBreakLoopErrorThresh2     ( handle_:P_ICPStereoHandleT; breakLoopErrorThresh2_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoSetInlierProbability         ( handle_:P_ICPStereoHandleT; inlierProbability_:T_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoGetInlierProbability         ( handle_:P_ICPStereoHandleT; inlierProbability_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoPoint                        ( handle_:P_ICPStereoHandleT; data_:P_ICPStereoDataT; initMatXw2Xc_:T_ARdouble34; matXw2Xc_:T_ARdouble34; err_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;
function icpStereoPointRobust                  ( handle_:P_ICPStereoHandleT; data_:P_ICPStereoDataT; initMatXw2Xc_:T_ARdouble34; matXw2Xc_:T_ARdouble34; err_:P_ARdouble ) :T_int; stdcall; external _DLLNAME_;

{$IF False }
int                icpRobustGetXw2Xc( ICPHandleT   *handle,
                                      ICPDataT     *data,
                                      ARdouble        initMatXw2Xc[3][4],
                                      ARdouble        matXw2Xc[3][4],
                                      ARdouble       *err );

int                icpGetXw2XcFromLineAndPoint( ICPHandleT       *handle, 
                                                ICPLinesDataT    *linesData,
                                                ICPDataT         *pointData,
                                                ARdouble            initMatXw2Xc[3][4],
                                                ARdouble            matXw2Xc[3][4],
                                                ARdouble           *err );


int                icpStereoCheckErr( ARdouble S[6], ARdouble matXcl2Ul[3][4], ARdouble matXcl2Ur[3][4], ICPStereoDataT *data, ARdouble *err );
int                icpRobustCheckErr( ARdouble S[6], ARdouble matXc2U[3][4], ICPDataT *data, ARdouble *weight, ARdouble *err );
int                icpRobustUpdateWeight( ARdouble S[6], ARdouble matXc2U[3][4], ICPDataT *data, ARdouble sd2, ARdouble *weight );


int                icpGetJ_E_S( ARdouble J_E_S[6], ICP2DLineT *line, ICP2DLineSegT *lineSeg, ARdouble matXc2U[3][4], ARdouble q[7], ARdouble s[6],
                                ICP3DLineSegT *cameraCoord, ICP3DLineSegT *worldCoord, ICP2DCoordT *observedScreenCoord );
int                icpGetJ_E_L( ARdouble J_E_L[3], ICP2DLineT *line, ICP2DCoordT *screenCoord );
int                icpGetJ_L_X( ARdouble J_L_X[3][4], ICP2DLineSegT *lineSeg );
int                icpGetLine( ICP2DLineT *line, ICP2DLineSegT *lineSeg );
int                icpGetdE( ARdouble *dE, ICP2DLineT *line, ICP2DCoordT *screenCoord );
int                icpLineCheckErr( ARdouble S[6], ARdouble matXc2U[3][4], ICPLinesDataT *data,  ARdouble *err );
{$ENDIF}

implementation //############################################################### ■

end. //######################################################################### ■
