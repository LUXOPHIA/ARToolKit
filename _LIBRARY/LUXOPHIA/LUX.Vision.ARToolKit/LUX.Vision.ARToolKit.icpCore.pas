unit LUX.Vision.ARToolKit.icpCore;

(*
 *  icpCore.h
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
     LUX.Vision.ARToolKit.define;

{$IFNDEF M_PI }
const M_PI = 3.14159265358979323846;
{$ENDIF}

const ICP_DEBUG                         = 0;
const ICP_MAX_LOOP                      = 10;
const ICP_BREAK_LOOP_ERROR_THRESH       = 0.1;
const ICP_BREAK_LOOP_ERROR_RATIO_THRESH = 0.99;
const ICP_BREAK_LOOP_ERROR_THRESH2      = 4.0;
const ICP_INLIER_PROBABILITY            = 0.50;

type T_ICP2DCoordT = record
       x :T_ARdouble;
       y :T_ARdouble;
     end;
     P_ICP2DCoordT = ^T_ICP2DCoordT;

type T_ICP3DCoordT = record
       x :T_ARdouble;
       y :T_ARdouble;
       z :T_ARdouble;
     end;
     P_ICP3DCoordT = ^T_ICP3DCoordT;

type T_ICP2DLineT = record
       a :T_ARdouble;
       b :T_ARdouble;
       c :T_ARdouble;
     end;
     P_ICP2DLineT = ^T_ICP2DLineT;

type T_ICP2DLineSegT = record
       p1 :T_ICP2DCoordT;
       p2 :T_ICP2DCoordT;
     end;
     P_ICP2DLineSegT = ^T_ICP2DLineSegT;

type T_ICP3DLineSegT = record
       p1 :T_ICP3DCoordT;
       p2 :T_ICP3DCoordT;
     end;
     P_ICP3DLineSegT = ^T_ICP3DLineSegT;

function icpGetXc_from_Xw_by_MatXw2Xc( Xc_:P_ICP3DCoordT; matXw2Xc_:T_ARdouble34; Xw_:P_ICP3DCoordT ) :T_int; stdcall; external _DLLNAME_;
function icpGetU_from_X_by_MatX2U( u_:P_ICP2DCoordT; matX2U_:T_ARdouble34; coord3d_:P_ICP3DCoordT ) :T_int; stdcall; external _DLLNAME_;
function icpGetJ_U_S( J_U_S_:T_ARdouble26; matXc2U_:T_ARdouble34; matXw2Xc_:T_ARdouble34; worldCoord_:P_ICP3DCoordT ) :T_int; stdcall; external _DLLNAME_;
function icpGetDeltaS( S_:T_ARdouble6; dU_:array of T_ARdouble; J_U_S_:array of T_ARdouble6; n_:T_int ) :T_int; stdcall; external _DLLNAME_;
function icpUpdateMat( matXw2Xc_:T_ARdouble34; dS_:T_ARdouble6 ) :T_int; stdcall; external _DLLNAME_;

procedure icpDispMat( title_:P_char; mat_:P_ARdouble; row_:T_int; clm_:T_int ); stdcall; external _DLLNAME_;

implementation //############################################################### ■

end. //######################################################################### ■
