precision highp float;
uniform sampler2D texA;
uniform sampler2D texLUT;
uniform vec2 uniTexelA;
uniform vec2 uniTexelLUT;
uniform vec2 uniFactor;

void main()
{
	// Get the input value.
	vec4 res;
	vec4 lhs = texture2D(texA, gl_FragCoord.xy * uniTexelA);
	
	// Get the output value from lookup table.
	// Normalize the input value to the lut range.
	lhs = (lhs - uniFactor[0]) * uniFactor[1];
	res = vec4(texture2D(texLUT, vec2(lhs.x, 0.5) * uniTexelLUT)[0]);
	
	// Store the result.
	gl_FragData[0] = res;
}

