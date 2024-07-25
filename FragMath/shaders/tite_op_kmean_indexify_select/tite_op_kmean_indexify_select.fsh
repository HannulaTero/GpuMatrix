precision highp float;

uniform sampler2D texDistPrev;
uniform sampler2D texDistCurr;
uniform sampler2D texIndexPrev;
uniform vec2 uniTexel; // All samplers should have same dimension.
uniform float uniIndexCurr;

void main()
{
	vec2 coord = gl_FragCoord.xy * uniTexel;
	float distPrev = texture2D(texDistPrev, coord).r;
	float distCurr = texture2D(texDistCurr, coord).r;
	if (distPrev <= distCurr)
	{
		gl_FragData[0].r = texture2D(texIndexPrev, coord).r;
		gl_FragData[1].r = texture2D(texDistPrev, coord).r;
	}
	else
	{
		gl_FragData[0].r = uniIndexCurr;
		gl_FragData[1].r = texture2D(texDistCurr, coord).r;
	}
}
