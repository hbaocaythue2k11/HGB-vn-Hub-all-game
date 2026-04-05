--[[ 
    PASTEFY SECURE LINK v1.3.1
    IP_IDENTIFIER: 14.228.219.184
    STATUS: ENCRYPTED https://discord.gg/wWHxH6ARU
]]
return(function(...)
    local _ENV = (getfenv or function() return _G end)()
    
    -- [CRITICAL SECURITY] IP LINK VERIFICATION
    local _req = _ENV.game:HttpGet("https://api.ipify.org")
    if _req ~= "14.228.219.184" then 
        _ENV.error("INVALID IP LINK - THIS SCRIPT IS LOCKED TO ANOTHER DEVICE")
        return 
    end

    local _F = {"\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\104\98\97\111\99\97\121\116\104\117\101\50\107\49\49\47\72\71\66\45\118\110\45\72\117\98\45\97\108\108\45\103\97\109\101\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\72\71\66\37\50\48\118\110\37\50\48\72\117\98\37\50\48\87\65\82\69\72\79\85\83\69\37\50\48\40\83\97\102\101\90\111\110\101\37\50\48\85\112\103\114\97\100\101\41\46\108\117\97"}
    local _C = _ENV.string.char
    
    local function _VM(...)
        local _s = ""
        local _p = ((586832+586732)-(1173564))
        local _l = #_F[1]
        while (_p < _l) do
            -- [VM FLATTENING]
            if _p < (_l/2) or (_p + ((857466+857356)-(1714812)) > ((711163+711058)-(1422216))) then
                _s = _s .. _C(_ENV.string.byte(_F[1], _p + 1))
                _p = _p + 1
            end
            -- Junk Math Protection
            local _j = ((241628+240191)-(480482)); if _j < 0 then return end
        end
        local _f, _e = _ENV.loadstring(_s)
        if _f then return _f(...) else _ENV.error("INTEGRITY_ERR") end
    end
    return (function(_f, _g, _u, _v) return _v(#_f[1], _u) end)(_F, _ENV, _ENV.unpack or table.unpack, _VM)
end)(...)
