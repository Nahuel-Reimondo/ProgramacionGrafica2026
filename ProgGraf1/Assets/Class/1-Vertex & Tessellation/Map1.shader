// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Map1"
{
	Properties
	{
		_amplitude("amplitude", Float) = 0
		_noiseScale("noiseScale", Float) = 0
		_stepNoise1("stepNoise1", Range( 0 , 1)) = 0
		_hightColor1("hightColor1", Color) = (0,0,0,0)
		_deepColor1("deepColor1", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _noiseScale;
		uniform float _amplitude;
		uniform float4 _deepColor1;
		uniform float4 _hightColor1;
		uniform float _stepNoise1;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, 0.4);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float simplePerlin2D16 = snoise( v.texcoord.xy*_noiseScale );
			simplePerlin2D16 = simplePerlin2D16*0.5 + 0.5;
			v.vertex.xyz += ( simplePerlin2D16 * _amplitude * float3(0,1,0) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float simplePerlin2D16 = snoise( i.uv_texcoord*_noiseScale );
			simplePerlin2D16 = simplePerlin2D16*0.5 + 0.5;
			float4 lerpResult20 = lerp( _deepColor1 , _hightColor1 , step( _stepNoise1 , simplePerlin2D16 ));
			o.Albedo = lerpResult20.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
345;-1007;1219;682;2679.546;1137.808;3.770591;True;False
Node;AmplifyShaderEditor.CommentaryNode;25;-1498.184,56.92143;Inherit;False;513.4149;314.0587;Noise;3;17;16;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;26;-925.1566,-6.748703;Inherit;False;471.0605;226.4859;Binary;2;23;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1387.236,254.98;Inherit;False;Property;_noiseScale;noiseScale;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-1448.184,106.9214;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;27;-815.3217,311.2356;Inherit;False;458.0677;344.0754;Height;3;14;11;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;16;-1199.769,180.7831;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-875.1566,43.2513;Inherit;False;Property;_stepNoise1;stepNoise1;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;22;-704.3156,-226.6406;Inherit;False;Property;_hightColor1;hightColor1;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-695.1113,-432.2158;Inherit;False;Property;_deepColor1;deepColor1;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;23;-606.0961,84.73724;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-765.3217,381.0277;Inherit;False;Property;_amplitude;amplitude;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;18;-764.8171,467.311;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-519.254,361.2356;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;7;-331.4001,469.0751;Inherit;False;1;0;FLOAT;0.4;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;20;-328.6524,-62.73237;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-112.3592,-2.265986;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Map1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;19;0
WireConnection;16;1;17;0
WireConnection;23;0;24;0
WireConnection;23;1;16;0
WireConnection;14;0;16;0
WireConnection;14;1;11;0
WireConnection;14;2;18;0
WireConnection;20;0;21;0
WireConnection;20;1;22;0
WireConnection;20;2;23;0
WireConnection;0;0;20;0
WireConnection;0;11;14;0
WireConnection;0;14;7;0
ASEEND*/
//CHKSM=18181CE61652585DEE487BA5BB2CC94975EEF22F