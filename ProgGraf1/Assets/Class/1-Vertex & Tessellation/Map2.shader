// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Map2"
{
	Properties
	{
		_amplitude("amplitude", Float) = 0
		_amplitude2("amplitude2", Float) = 0
		_noiseScale("noiseScale", Float) = 0
		_noiseScale2("noiseScale2", Float) = 0
		_water("water", Color) = (0,0,0,0)
		_Sand("Sand", Color) = (0,0,0,0)
		_Grass("Grass", Color) = (0,0,0,0)
		_baseNoiseStepMax("baseNoiseStepMax", Range( 0 , 1)) = 0
		_sandThreshold("sandThreshold", Range( 0 , 1)) = 0
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
		uniform float _noiseScale2;
		uniform float _amplitude2;
		uniform float _baseNoiseStepMax;
		uniform float4 _water;
		uniform float4 _Grass;
		uniform float4 _Sand;
		uniform float _sandThreshold;


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
			float simplePerlin2D32 = snoise( v.texcoord.xy*_noiseScale );
			simplePerlin2D32 = simplePerlin2D32*0.5 + 0.5;
			float baseNoise59 = simplePerlin2D32;
			float3 baseHeight62 = ( baseNoise59 * _amplitude * float3(0,1,0) );
			float simplePerlin2D44 = snoise( v.texcoord.xy*_noiseScale2 );
			simplePerlin2D44 = simplePerlin2D44*0.5 + 0.5;
			float secondNoise67 = simplePerlin2D44;
			float3 secondHeight68 = ( secondNoise67 * _amplitude2 * float3(0,1,0) );
			float3 temp_output_40_0 = ( baseHeight62 + secondHeight68 );
			float smoothstepResult49 = smoothstep( 0.1 , _baseNoiseStepMax , baseNoise59);
			float baseHeightStep64 = smoothstepResult49;
			float3 lerpResult39 = lerp( baseHeight62 , temp_output_40_0 , baseHeightStep64);
			v.vertex.xyz += lerpResult39;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float simplePerlin2D32 = snoise( i.uv_texcoord*_noiseScale );
			simplePerlin2D32 = simplePerlin2D32*0.5 + 0.5;
			float baseNoise59 = simplePerlin2D32;
			float4 lerpResult108 = lerp( _Grass , _Sand , step( baseNoise59 , _sandThreshold ));
			float smoothstepResult49 = smoothstep( 0.1 , _baseNoiseStepMax , baseNoise59);
			float baseHeightStep64 = smoothstepResult49;
			float4 lerpResult102 = lerp( _water , lerpResult108 , baseHeightStep64);
			o.Albedo = lerpResult102.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
345;-1007;1219;682;2952.323;1102.167;3.180884;True;False
Node;AmplifyShaderEditor.CommentaryNode;41;-2998.199,502.3203;Inherit;False;513.4149;314.0587;Noise;3;44;43;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;28;-2607.509,-785.3514;Inherit;False;513.4149;314.0587;Noise;3;32;30;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;43;-2948.199,552.3202;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;-2887.251,700.3788;Inherit;False;Property;_noiseScale2;noiseScale2;3;0;Create;True;0;0;0;False;0;False;0;8.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2496.561,-587.2927;Inherit;False;Property;_noiseScale;noiseScale;2;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;30;-2557.509,-735.3514;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;32;-2309.094,-661.4897;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;44;-2699.782,626.1819;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;31;-2142.074,-434.7121;Inherit;False;458.0677;344.0754;Height;3;37;35;36;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;45;-2215.463,594.8748;Inherit;False;458.0677;344.0754;Height;3;48;47;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-2426.074,625.6673;Inherit;False;secondNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-2057.369,-655.5317;Inherit;False;baseNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;36;-2089.028,-250.6755;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;46;-2192.457,696.57;Inherit;False;Property;_amplitude2;amplitude2;1;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2092.075,-364.9202;Inherit;False;Property;_amplitude;amplitude;0;0;Create;True;0;0;0;False;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;48;-2162.415,778.9115;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;73;-1814.515,-540.7;Inherit;False;Property;_baseNoiseStepMax;baseNoiseStepMax;7;0;Create;True;0;0;0;False;0;False;0;0.452;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1846.007,-384.7122;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1919.394,644.8748;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;109;-866.9863,-46.79882;Inherit;False;59;baseNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-919.5759,42.43988;Inherit;False;Property;_sandThreshold;sandThreshold;9;0;Create;True;0;0;0;False;0;False;0;0.57;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;75;-977.0227,550.041;Inherit;False;733.5854;495.2019;Total Height;5;72;63;66;40;39;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-1630.972,-374.446;Inherit;False;baseHeight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;49;-1552.251,-669.1788;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-1711.243,643.2233;Inherit;False;secondHeight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-905.6975,772.9933;Inherit;False;68;secondHeight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-1376.679,-673.5551;Inherit;False;baseHeightStep;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-927.0227,603.228;Inherit;False;62;baseHeight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;90;-785.3813,-601.0296;Inherit;False;Property;_Grass;Grass;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.1766587,0.5377356,0.06341206,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;89;-758.3032,-294.445;Inherit;False;Property;_Sand;Sand;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.9433962,0.8519979,0.155749,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;111;-573.9863,-71.79883;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-616.3219,929.2429;Inherit;False;64;baseHeightStep;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-653.1839,741.9975;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;88;-185.982,-544.8102;Inherit;False;Property;_water;water;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.05098016,0.4592786,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;103;-10.19067,-67.58533;Inherit;False;64;baseHeightStep;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;108;-370.0637,-321.8259;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;14;274.1688,368.0909;Inherit;False;1;0;FLOAT;0.4;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;102;169.4238,-317.9572;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1509.882,-814.0536;Inherit;False;Property;_sandPerc;sandPerc;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;-425.4376,600.041;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-175.9189,731.8474;Inherit;False;maxHeight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;490.8394,-127.7528;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Map2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;30;0
WireConnection;32;1;29;0
WireConnection;44;0;43;0
WireConnection;44;1;42;0
WireConnection;67;0;44;0
WireConnection;59;0;32;0
WireConnection;37;0;59;0
WireConnection;37;1;35;0
WireConnection;37;2;36;0
WireConnection;47;0;67;0
WireConnection;47;1;46;0
WireConnection;47;2;48;0
WireConnection;62;0;37;0
WireConnection;49;0;59;0
WireConnection;49;2;73;0
WireConnection;68;0;47;0
WireConnection;64;0;49;0
WireConnection;111;0;109;0
WireConnection;111;1;112;0
WireConnection;40;0;63;0
WireConnection;40;1;72;0
WireConnection;108;0;90;0
WireConnection;108;1;89;0
WireConnection;108;2;111;0
WireConnection;102;0;88;0
WireConnection;102;1;108;0
WireConnection;102;2;103;0
WireConnection;39;0;63;0
WireConnection;39;1;40;0
WireConnection;39;2;66;0
WireConnection;76;0;40;0
WireConnection;0;0;102;0
WireConnection;0;11;39;0
WireConnection;0;14;14;0
ASEEND*/
//CHKSM=9CBCA6CAE436FB990CDB4224EDA1DD7529487389