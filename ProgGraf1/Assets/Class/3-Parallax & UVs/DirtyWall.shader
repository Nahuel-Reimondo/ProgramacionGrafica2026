// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DirtyWall"
{
	Properties
	{
		_baseTex("baseTex", 2D) = "white" {}
		_baseColor("baseColor", Color) = (0,0,0,0)
		_dirtTex("dirtTex", 2D) = "white" {}
		_dirtColor("dirtColor", Color) = (0,0,0,0)
		_dirtScaleOffset("dirtScaleOffset", Vector) = (0,0,0,0)
		_dirtYLimit("dirtYLimit", Float) = 0
		_dirtMaxStep("dirtMaxStep", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float4 _baseColor;
		uniform sampler2D _baseTex;
		uniform float4 _baseTex_ST;
		uniform float4 _dirtColor;
		uniform float _dirtMaxStep;
		uniform float _dirtYLimit;
		uniform sampler2D _dirtTex;
		uniform float4 _dirtScaleOffset;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_baseTex = i.uv_texcoord * _baseTex_ST.xy + _baseTex_ST.zw;
			float4 temp_cast_0 = (_dirtMaxStep).xxxx;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult15 = (float2(_dirtScaleOffset.x , _dirtScaleOffset.y));
			float2 appendResult16 = (float2(_dirtScaleOffset.z , _dirtScaleOffset.w));
			float4 smoothstepResult23 = smoothstep( float4( 0,0,0,0 ) , temp_cast_0 , ( ( _dirtYLimit + ( 1.0 - ase_worldPos.y ) ) * tex2D( _dirtTex, ((ase_worldPos).xy*appendResult15 + appendResult16) ) ));
			float4 lerpResult10 = lerp( ( _baseColor * tex2D( _baseTex, uv_baseTex ) ) , _dirtColor , smoothstepResult23);
			o.Albedo = lerpResult10.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
403;-1007;1160.8;682;1529.448;273.5721;1.452387;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1613.318,320.4484;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector4Node;14;-1640.127,476.5872;Inherit;False;Property;_dirtScaleOffset;dirtScaleOffset;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;2;-1424.318,318.4484;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-1390.127,644.5872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1406.127,417.5872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;11;-1227.127,325.5872;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;18;-1188.888,174.2325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1156.888,57.23251;Inherit;False;Property;_dirtYLimit;dirtYLimit;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1031.252,278.973;Inherit;True;Property;_dirtTex;dirtTex;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-961.8876,132.2325;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-400.8378,-370.8383;Inherit;False;Property;_baseColor;baseColor;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-412.8378,-192.8385;Inherit;True;Property;_baseTex;baseTex;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-654.1581,245.2195;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-595.5637,429.3833;Inherit;False;Property;_dirtMaxStep;dirtMaxStep;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-110.8375,-262.8386;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;9;-830.2213,-30.69533;Inherit;False;Property;_dirtColor;dirtColor;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;23;-403.3048,260.1177;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;10;-50.29858,117.5512;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;193,25;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;DirtyWall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;16;0;14;3
WireConnection;16;1;14;4
WireConnection;15;0;14;1
WireConnection;15;1;14;2
WireConnection;11;0;2;0
WireConnection;11;1;15;0
WireConnection;11;2;16;0
WireConnection;18;0;1;2
WireConnection;7;1;11;0
WireConnection;19;0;20;0
WireConnection;19;1;18;0
WireConnection;17;0;19;0
WireConnection;17;1;7;0
WireConnection;4;0;5;0
WireConnection;4;1;3;0
WireConnection;23;0;17;0
WireConnection;23;2;24;0
WireConnection;10;0;4;0
WireConnection;10;1;9;0
WireConnection;10;2;23;0
WireConnection;0;0;10;0
ASEEND*/
//CHKSM=25C92D3D0BC9A68B40F627410426D098D4269FB8