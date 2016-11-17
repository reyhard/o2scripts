//this file specified constants for testing flags at faces of points
// use setPointFlags [index,POINT_XXX_MASK, POINT_XXXX]

#define POINT_LAND_MASK [0,3]

#define POINT_ONLAND    1
#define POINT_UNDERLAND 2
#define POINT_ABOVELAND 4
#define POINT_KEEPLAND  8

#define POINT_NOLIGHT    1
#define POINT_AMBIENT    2
#define POINT_FULLLIGHT  4
#define POINT_HALFLIGHT  8
#define POINT_LIGHT_MASK [4,7]

#define POINT_DECAL      1
#define POINT_VDECAL     2
#define POINT_DECAL_MASK [8,9]

#define POINT_NOFOG     1
#define POINT_SKYFOG    2
#define POINT_FOG_MASK  [12,13]


#define POINT_SPECIAL_HIDDEN 1
#define POINT_SPECIAL_LOCKNORMAL 2 //Objectiv normal calculation - used only for smoothed vertices
#define POINT_SPECIAL_MASK [24,27]

//use setFaceFlags [index,POINT_USER_MASK,u] - where u is user value 0-255
#define POINT_USER_MASK  [16,23]

//use setFaceFlags [FACE_XXXX,a] - where a is 0=off, 1=on

#define FACE_NOLIGHT             0 // active colors
#define FACE_AMBIENT             1
#define FACE_FULLLIGHT           2
#define FACE_BOTHSIDESLIGHT      5 // Objektiv normal calculation
#define FACE_SKYLIGHT            7 //
#define FACE_REVERSELIGHT       20 // Objektiv normal calculation
#define FACE_FLATLIGHT          21 // Objektiv normal calculation

#define FACE_LIGHT_MASK  [0,2]

//use setFaceFlags [FACE_XXXX_MASK,FACE_XXX]
#define FACE_ISSHADOW     1
#define FACE_NOSHADOW     2
#define FACE_SHADOW_MASK  [3,4]

//use setFaceFlags[FACE_Z_BIAS_MASK,bias] - where bias is 0-3
#define FACE_Z_BIAS_MASK [8,9]

//use setFaceFlags[FACE_DISABLE_TEXMERGE,a] - where a is 0=off, 1=on
#define FACE_DISABLE_TEXMERGE 24

//use setFaceFlags[FACE_USER_MASK ,u] - where u is user value 0-127
#define FACE_USER_MASK [25,31]

//use setFaceFlags[FACE_COLORIZE_MASK,u] - where u is color value 0-15
#define FACE_COLORIZE_MASK [12,15]