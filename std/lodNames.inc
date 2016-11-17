#ifndef _LODNAMES_INC_
#define _LODNAMES_INC_
#include "SpecialLod.hpp"
lodNameGetName={ //_this = level
	private "_name";
	switch (_this) do
	{
		case LOD_MEMORY: {_name="Memory";};
		case LOD_LANDCONTACT: {_name="Land Contact";};
		case LOD_ROADWAY: {_name="Roadway";};
		case LOD_PATHS : {_name="Paths";};
		case LOD_HPOINTS : {_name="HitPoints";};
		case LOD_VIEWGEO : {_name="View G.";};
		case LOD_FIREGEO : {_name="Fire G.";};
		case LOD_VIEW_CARGO_GEOMETRY : {_name="Cargo G.";};
		case LOD_VIEW_CARGO_FGEOMETRY : {_name="Cargo F.G.";};
		case LOD_VIEW_COMMANDER : {_name="Commander";};
		case LOD_VIEW_COMM_GEOMETRY : {_name="Commander G.";};
		case LOD_VIEW_COMM_FGEOMETRY : {_name="Commander F.G.";};
		case LOD_VIEW_PILOT_GEOMETRY : {_name="Pilot G.";};
		case LOD_VIEW_PILOT_FGEOMETRY : {_name="Pilot G.";};
		case LOD_VIEW_GUNNER_GEOMETRY : {_name="Gunner G.";};
		case LOD_VIEW_GUNNER_FGEOMETRY : {_name="Gunner G.";};
		case LOD_VIEW_GUNNER: {_name="Gunner";};
		case LOD_VIEW_PILOT: {_name="Pilot";};
		case LOD_VIEW_CARGO: {_name="Cargo";};
		case LOD_GEOMETRY: {_name="Geometry";};
                case LOD_SHADOW_VIEW_CARGO:{_name="Shadow view Cargo";};
                case LOD_SHADOW_VIEW_PILOT:{_name="Shadow view Pilot";};  
                case LOD_SHADOW_VIEW_GUNNER:{_name="Shadow view Gunner";};   
		case LOD_SUB_PARTS: {_name="Sub Parts";};
		default {
				if (_this>=LOD_SHADOW_MIN && _this<LOD_SHADOW_MAX) then
				{
					_name="Shadow "+str(LOD_SHADOW(_this));
				}
				else
				{
					if (_this>=LOD_EDIT_MIN && _this<LOD_EDIT_MAX) then 
                                        {
                                        	_name="Edit "+str(LOD_EDIT(_this)); 
                                        }
                                        else 
                                        {
                                        	_name=str(_this);
                                        };
				};
			};
	};
	_name
};
#endif