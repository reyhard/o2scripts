//define parsing function
//param - IOStream, opened file, or another stream, return - array parsed paramfile;

paramFileRead=
{
        scopeName "paramFile.inc";
	private "_ReadClass";
	private "_ReadRawClass";
	private "_ReadArray";
	private "_ReadSimpleValue";
	private "_ReadSimpleItem";
	//localfunction _ReadClass
	//param - IOStream, return Array ["<name>","class",[....] ]

	_ReadClass=		//input: <class name> { ... };
	{
		private "_content";
	    private "_classname";
	    private "_result";
		eatWS _this;										//eat whitespaces
		if (_this explorefor "[_a-zA-Z0-9]+") then						//test stream for standard identifier
		{
		   _classname=_this get 0;							//get classname (get everything tested)
		   eatWS _this;										//eat whitespaces
		   if (_this exploreFor "{") then					//test stream if contains {
		   {
				_this ignore 1;								//ignore character {
				_content=_this call _ReadRawClass;			//Read content of class
				if ((!isnil "_content") && (_this exploreFor "}[\S]*;*[\s\n\r;]*")) then //test end of class }; [\S] is whitechar
				{
					_result=+[_classname,"class",_content];	//store values as result
					_this ignore 0;							//skip everything tested };
				}
				else
				{
					_result=nil							//error is nil
				};
		   }
		   else
		   {
				_result=nil;						//error is nil
		   };
		}
		else
		{
			_result=nil;							//error is nil
		};

	_result											//return result
	};

	_ReadEmptyClass=		//input: <class name> { ... };
	{
		private "_content";
	    private "_classname";
	    private "_result";
		eatWS _this;										//eat whitespaces
		if (_this explorefor "[_a-zA-Z0-9]+") then						//test stream for standard identifier
		{
		   _classname=_this get 0;							//get classname (get everything tested)
		   eatWS _this;										//eat whitespaces
		   _content= [];
			 _result=+[_classname,"EmptyClass",_content];	//store values as result
		   if(_this exploreFor "[\S]*;*[\s\n\r;]*") then
		    {
		     _this ignore 0;		//skip everything tested ;
		    };
		}
		else
		{
			_result=nil;							//error is nil
		};

	_result											//return result
	};

	_ReadDerivedClass=		//input: <class name> { ... };
	{
		private "_content";
	    private "_classname";
	    private "_result";
	    private "_derivename";
		eatWS _this;										//eat whitespaces
		if (_this explorefor "[_a-zA-Z0-9]+") then						//test stream for standard identifier
		{
		   _classname=_this get 0;							//get classname (get everything tested)
		   eatWS _this;										//eat whitespaces

		   if (_this exploreFor ":") then					//test stream if contains :
		   {
				_this ignore 1;								//ignore character {
  		  eatWS _this;
		    if (_this explorefor "[_a-zA-Z0-9]+") then						//test stream for standard identifier
	     	{
		     _derivename=_this get 0;							//get classname (get everything tested)
		     eatWS _this;										//eat whitespaces
   		   if (_this exploreFor "{") then					//test stream if contains {
  		   {
  				_this ignore 1;								//ignore character {
	  			_content=_this call _ReadRawClass;			//Read content of class
		  		if ((!isnil "_content") && (_this exploreFor "}[\S]*;*[\s\n\r;]*")) then //test end of class }; [\S] is whitechar
			  	{
				   _result=+[_classname,"class",_content,_derivename];	//store values as result
					 _this ignore 0;							//skip everything tested };
				  }
				  else
				  {
					 _result=nil							//error is nil
				  };
		     }
		     else
		     {
				  _result=nil;						//error is nil
		     };
		    };
		   }
		   else
		   {
				_result=nil;						//error is nil
		   };
		}
		else
		{
			_result=nil;							//error is nil
		};

	_result											//return result
	};


	_ReadSimpleValue= //input="any text which may represent value"
	{
		private "_value";
		eatWS _this;								//eat whitespwaces
		switch (true) do							//switch for true
		{
			case (_this exploreFor "_*[+-]*[0-9]+[.]?[0-9]*([eE][+-]?[0-9]+)?_*[,};]"):					//test for number

			{
				_value=val (_this get -1);			//it is number, get all and convertit
			};
			case (_this exploreFor "(""[^""]*"")+[^""]"): // "([^"]*)+[^"] - begins with ", endings with " and something which is not "
			{										//test for string
				_this ignore 1;						//ignore first quote
				_value=_this get -2;				//get remaining excluding 2 characters (quote and one extra character)
				_this ignore 1;						//ignore last quite
			};
			case (_this exploreFor "{"):			//subarray test for {
			{
				_this ignore 1;						//skip {
				eatWS _this;						//eat whitespaces
				private ["_arr","_subitem"];
				_arr=+[];							//prepare array
				_subitem=_this call _ReadSimpleValue;	//read first value
				eatWS _this;						//eat extra whitespaces
				while {_this exploreFor ","} do		//while additional values present
				{
					_this ignore 0;					//ignore all tested (comma ,)
					_arr set [count _arr,_subitem];	//store previous value
					_subitem=_this call _ReadSimpleValue;	//read next value
					eatWS _this;					//eat extra whitespaces
				};
				_arr set [count _arr,_subitem];		//store last value
				if (_this exploreFor "}") then		//test for end of array
				{
					_value=_arr;					//store result as value
					eatWS (_this ignore 1);			//ignore } and eat whitespaces
				}
				else								//error is nil
				{
					_value=nil;
				};
			};
			case (_this exploreFor "[^,;}]*"):
			{
				_value="#$flag:"+(_this get 0);
			};
			default {_value=nil;};					//we failed all tests, report error;
		};
	_value											//result
	};

	_ReadArray=	//input: name[]=[
	{
		private "_name";
		private "_content";
		private "_result";
		testIdentifier _this;	//get name without []
		_name=_this get 0;
		_this exploreFor "[^=]*="; //get everything until = (including =)
		_this ignore 0;
		eatWS _this;
		if (_this exploreFor "{") then
		   {
		   _content=_this call _ReadSimpleValue;
		   if (!isnil "_content") then
				{
				if (_this exploreFor ";") then
					{
					eatWS (_this ignore 1);
				   _result=+[_name,"array",_content];
					}
				else
					{
					_result=nil;
					};
				}
			else
				{
				_result=nil;
				};
		   }
		   else
		   {
				_result=nil;
		   };
	_result
	};

	_ReadSimpleItem=		//input: name=
	{
		private ["_name","_content","_result"];
		testIdentifier _this;
		_name=_this get 0;
		eatWS (eatWS _this ignore 1);
		_content=_this call _ReadSimpleValue;
		if (!isnil "_content") then
		{
			if (_this exploreFor ";") then
			{
				eatWS (_this ignore 1);
				_result=+[_name,"simple",_content];
			}
			else
			{
				_result=nil;
			};
		}
		else
		{
			_result=nil;
		};
	_result
	};

	//localfunction _ReadRawClass
	//param - IOStream, return Array, that represents inside of class (items)
	_ReadRawClass=
	{
		private ["_loop","_item","_result"];
		_result=+[];
		_loop=true;
		while {_loop} do
		{
                        eatWS _this;
			_item=nil;

			switch (true) do
			{
                                if (not (_this exploreFor "//[^\x0A^\x0D]*[\x0A\x0D]*")) then
                                {
	                                case (_this exploreFor "class "):               //in case class word
	                                {
	                                        _this ignore 0;
	                                        if ((_this exploreFor "[_a-zA-Z0-9]+[\S]*;") || (_this exploreFor "[_a-zA-Z0-9]+[\S]*:") ) then
	                                         {
	                                          if ((_this exploreFor "[_a-zA-Z0-9]+[\S]*;")) then
	                                           {
	                                                 _item=_this call _ReadEmptyClass ;
	                                           }
	                                          else
	                                           {
	                                             _item=_this call _ReadDerivedClass ;
	                                           };
	                                         }
	                                         else
	                                         {
	                                          _item=_this call _ReadClass ;
	                                         };
                                                 if (isnil "_item") then {_loop=false;};
	                                };
	                                case (_this exploreFor "[_a-zA-Z][_a-zA-Z0-9]*\[\]_*="):        //in case "name[]=" (_ - is whitespace without new line)
	                                {
	                                        _item=_this call _ReadArray ;
                                                if (isnil "_item") then {_loop=false;};
	                                };
	                                case (_this exploreFor "[_a-zA-Z][_a-zA-Z0-9]*_*="):  //in case "name=" (_ - is whitespace without new line)
	                                {
	                                        _item=_this call _ReadSimpleItem ;
                                                if (isnil "_item") then {_loop=false;};
	                                };
	                                default                                                         //in case we don't know
	                                {
	                                        _loop=false;
	                                };
                                }else{_this ignore 0;};
			};
			if !(isnil "_item") then { _result set [count _result,_item];};
		};
	_result
	};

	private "_content";

	_content=_this call _ReadRawClass;
	if (!eof(_this)) then {_content=nil;};
	_content
};

paramFileReadPrep={ // "path_to_file" call paramFileReadPrep
 private ["_controlscript","_result","_output","_input","_memo","_cesta","_cestarozrez"];
 _cestarozrez = splitpath _this;
 _input = (_cestarozrez @ 2)+(_cestarozrez @ 3);
 _cesta = (_cestarozrez @ 0)+(_cestarozrez @ 1);
 _controlscript =
 {
	private "_soubor";
	private "_file";
	private "_memory";
	private "_zpracovano";
	_cestanew = _cesta + _this;
	_memory =  openMemoryStream "_memory";
  _soubor = openFile[_cestanew,1];
  while {!eof (_soubor)} do
  {
   _file=getLine _soubor;
   _memory<<_file;
   _memory<<eoln;
  };
  _zpracovano = getbuffer _memory;
  _zpracovano
 };

 _output = _input preprocFile _controlScript;
 _memo =  openMemoryStream _output;
 _result = _memo call paramFileRead;
 _result
};


paramFileWrite={  //[stream, paramFileArray, arrayFormating]
	private "_writeClass";
	private "_writeArray";
	private "_writeVariable";
	private "_writeValue";
	private "_writeInsideClass";
	private	"_out";
	private "_block";
	private "_formatovani";

	_out=_this select 0;
	_level=0;
	_block="";
  _countargu = count _this;
  if (_countargu == 3) then
  	{
  	 _formatovani = _this select 2;
  	}
  else
    {
     _formatovani = "row";
    };


	_writeValue={			//_this input is any variable

		switch (typeName _this) do
		{
			case "STRING":
			{
        if (_this=="") then
        	{
        		_out<<""""<<_this<<"""";
        	}
        else
        	{
  		 	   if (_this @ [0,7]=="#$flag:") then
			  	 {
					  _out<<_this @ [7];
			   	 }
				   else
				   {
					  _out<<""""<<_this<<"""";
				   };
         	};

			};
			case "SCALAR":{_out<<str(_this);};
			case "ARRAY":
			{
				switch (_formatovani) do
				{
				  case "row":
				  {
			   	 _out<<"{";
				   private "_comma";
				   _comma="";
				   {
					  _out<<_comma;
					  _x call _writeValue;
					  _comma=",";
				   } forEach _this;
				   _out<<"}";
				  };
				  case "column":
				  {
			   	 _out<<eoln<<_block<<"{";
				   private "_comma";
				   _comma="";
				   {
					  _out<<_comma<<eoln<<_block+"	";
					  _x call _writeValue;
					  _comma=",";
				   } forEach _this;
				   _out<<eoln<<_block<<"}";
				  };
				};

			};
			default {_out<<""""<<str(_this)<<"""";};
		};

	};

	_writeVariable={		//_this=[name,"simple",value]
		_out<<_block<<(_this select 0)<<"=";
		(_this select 2) call _writeValue;
		_out<<";"<<eoln;
	};

	_writeArray={			//_this=[name,"array",[values]]
		_out<<_block<<(_this select 0)<<"[]=";
		(_this select 2) call _writeValue;
		_out<<";"<<eoln;
	};

	_writeClass={			//_this=[name,"class",[values]]
		if ((count _this)== 4) then
			{
		  	_out<<_block<<"class "<<(_this select 0)<<": "<<(_this select 3)<<eoln<<_block<<"{"<<eoln;
			}
		else
			{
	    	_out<<_block<<"class "<<(_this select 0)<<eoln<<_block<<"{"<<eoln;
			};
		_block=_block+"    ";
		_writeInsideClass forEach (_this select 2);
		_block=_block @ [0,count _block-4];
		_out<<_block<<"};"<<eoln;
	};

	_writeEmptyClass={			//_this=[name,"Empty class"]
		_out<<_block<<"class "<<(_this select 0)<<";"<<eoln;
	};

	_writeInsideClass={		//_x=[name,type,value(s)]
		private "_this";
		_this=_x;
		switch (_this select 1) do
		{
			case "class": _writeClass;
			case "EmptyClass": _writeEmptyClass;
			case "array": _writeArray;
			case "simple": _writeVariable;
		};
	};


	_writeInsideClass forEach (_this select 1);

};


paramFileFind={		//_this=[paramFile,name1,name2,name3...]
	private "_pfile";
	private "_result";
	private "_paramFilePartialFind";

	_paramFilePartialFind={ //_this=[paramFile,name];
		private "_i";
		private "_found";
		private "_pfile";
		_pfile=_this select 0;
		for "_i" from 0 to count _pfile do
		{
			if ((_pfile select _i) select 0==_this select 1) then
			{
				_found=_pfile select _i;
				_i=nil;
			};
		};
		_found
	};

	_pfile=_this select 0;
	{
		if (!isnil "_pfile" && typeName _x=="STRING") then
		{
			_result=([_pfile,_x] call _paramFilePartialFind) ;
			_pfile=_result select 2
		};
	}
	forEach _this;
	_result
};