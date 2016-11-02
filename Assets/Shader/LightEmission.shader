Shader "MechMocha/LightEmission" {
	Properties {
		_MainTex ("Main Texture", 2D) = "white" {}
		_LightTex ("Light Info Texture", 2D) = "black" {}
		_TargetColor ("Target Color", Color) = (1,1,1,1)
		_ReplaceColor ("Replace Color", Color) = (1,1,1,1)
		_Intensity ("Intensity", Range(0.0, 1.0)) = 1.0
	}

	SubShader {
       Tags { "Queue"="Transparent" }
       LOD 100

   		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _LightTex;
			float4 _MainTex_ST;
			float4 _TargetColor;
			float4 _ReplaceColor;
			float _Intensity;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float4 col = tex2D(_MainTex, i.uv);
				float4 lightcol = tex2D(_LightTex, i.uv);
				
				if (distance(col, _TargetColor) < 0.3) col = _ReplaceColor * col.a;
				//if (lightcol.a > 0) col += _ReplaceColor*lightcol.a*_Intensity;
				col += _ReplaceColor*lightcol*_Intensity;
				return col;
			}
			ENDCG
		}


    }
}
