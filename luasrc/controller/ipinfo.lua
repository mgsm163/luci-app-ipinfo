-- ipinfo.lua: LuCI module for IP information using 2ip.ru API

local http = require "luci.http"
local json = require "luci.jsonc"
local uci = require "luci.model.uci".cursor()

module("luci.controller.ipinfo", package.seeall)

function index()
    entry({"admin", "network", "ipinfo"}, cbi("ipinfo"), "Информация об IP", 60)
end

function get_ip_info(ip)
    local url = "https://api.2ip.ru/geo.json?ip=" .. (ip or "")
    local response = http.fetch(url)
    
    if response then
        local data = json.parse(response)
        if data and data.ip then
            return {
                ip = data.ip,
                country = data.country or "N/A",
                region = data.region or "N/A",
                city = data.city or "N/A",
                isp = data.isp or "N/A",
                zip_code = data.zip_code or "N/A"
            }
        end
    end
    return nil
end
