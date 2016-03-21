Shader "Custom/TestCurved" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	_What("what",float) = 200
	}

		SubShader{
		Pass
	{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

		sampler2D _MainTex;
		float _What;

		struct v2f {
			float4 pos : POSITION;
			float4 uv  : TEXCOORD0;
		};

		v2f vert(appdata_full v)
		{
			v2f o;
			float4 vPos = mul(UNITY_MATRIX_MV, v.vertex);
			float zOff = vPos.z / _What;
			vPos += float4(-15,0,0,0)*zOff*zOff;
			o.pos = mul(UNITY_MATRIX_P, vPos);
			o.uv = v.texcoord;
			return o;
		}

		half4 frag(v2f i) : COLOR
		{
			half4 col = tex2D(_MainTex, i.uv.xy);
			return col;
		}
			ENDCG
		}
	}

		FallBack "Diffuse"
}