-- Helper functions


local M = {}
local floatx = 800 -- default x length of floating windows
local floaty = 500 -- default y length of floating windows
M.floater = function(hl_ctx)
hl_ctx.dispatch(hl_ctx.dsp.window.float({ action = "toggle" }))
    hl_ctx.dispatch(hl_ctx.dsp.window.resize({x=floatx,y=floaty,relative=false,window="active"}))
    hl_ctx.dispatch(hl_ctx.dsp.window.center())
end
return M