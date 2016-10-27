 Shader "MechMocha/Transparent" {
 Properties {
     _MainTex ("Main Image", 2D) = "white" {}
     _Color ("Color", Color) = (1,1,1,1)

 }
 
 SubShader {
     Tags {"Queue"="Transparent"}
     LOD 100

     Blend SrcAlpha OneMinusSrcAlpha
     Pass {
     		CGPROGRAM
     		#pragma vertex vert
     		#pragma fragment frag

     		#include "UnityCG.cginc"

     		struct appdata {
     			float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
     		};

     		struct v2f {
     			float4 vertex : SV_POSITION;
     			float2 uv : TEXCOORD0;
     		};

     		float4 _Color;
     		sampler2D _MainTex;
     		float4 _MainTex_ST;

     		v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float4 col = tex2D(_MainTex, i.uv);
				if (col.w >= 0) {
					col.x = _Color.x;
					col.y = _Color.y;
					col.z = _Color.z;
				}
				return col;
			}
			ENDCG
     	}
 }
 
 }