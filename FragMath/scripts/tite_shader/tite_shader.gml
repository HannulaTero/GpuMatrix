

/// @func	tite_begin();
/// @desc	Changes gpu states to more suitable for calculations.
function tite_begin()
{
	tite_forceinline;
	
	gpu_push_state();
	gpu_set_alphatestenable(false);
	gpu_set_tex_filter(false);
	gpu_set_tex_repeat(false);
	array_push(global.tite.previousShader, shader_current());
	
	if (global.tite.cumulative) 
	{
		gpu_set_blendenable(true);
		gpu_set_blendmode_ext(bm_one, bm_one);
	} 
	else 
	{
		gpu_set_blendenable(false);
		gpu_set_blendmode_ext(bm_one, bm_zero);
	}
}


/// @func	tite_end();
/// @desc	Returns previous gpu state.
function tite_end()
{
	tite_forceinline;
	gpu_pop_state();
	var _shader = array_pop(global.tite.previousShader);
	if (_shader != -1)
	{
		shader_set(_shader);
	}
	else
	{
		shader_reset();
	}
	global.tite.cumulative = false;
}


/// @func	tite_shader(_shader);
/// @desc	Select tite operation.
/// @param	{Asset.GMShader} _shader
function tite_shader(_shader) 
{
	tite_forceinline;
	shader_set(_shader);
}


/// @func	tite_set_cumulative(_bool);
/// @desc	Whether results are "set" or "add" to destination. 
/// @param	{Bool} _additive
function tite_set_cumulative(_additive=true) 
{
	tite_forceinline;
	global.tite.cumulative = _additive;
}


/// @func	tite_sample(_name, _src);
/// @desc	Set matrix as texture sampler, input for operation.
/// @param	{String}				_name
/// @param	{Struct.TiteData}	_src
function tite_sample(_name, _src)
{
	var _shader = shader_current();
	var _sampler = shader_get_sampler_index(_shader, _name);
	gpu_set_tex_filter_ext(_sampler, _src.interpolate);
	gpu_set_tex_repeat_ext(_sampler, _src.repetive);
	texture_set_stage(_sampler, _src.Texture());
}
	
	
/// @func	tite_render();
/// @desc	Do the calculation, updates whole target.
function tite_render()
{
	tite_forceinline;
	vertex_submit(global.tite.vertexBuffer, pr_trianglestrip, -1);
}


/// @func	tite_target(_src);
/// @desc	Set matrix as destination for calculations
/// @param	{Struct.TiteData}	_src
function tite_target(_src)
{
	tite_forceinline;
	surface_set_target(_src.Surface());
}


/// @func	tite_finish();
/// @desc	Computing to target is finished. As separate if other functionality is later added.
function tite_finish()
{
	tite_forceinline;
	surface_reset_target();
}









