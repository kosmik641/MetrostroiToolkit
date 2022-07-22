Metrostroi = {}

Metrostroi.Version = 1623941696
Metrostroi.Loaded = false

-- Interior line scheme
Metrostroi.Skins = {["717_schemes"]={p={},m={}}}
function Metrostroi.AddPassSchemeTex(id,name,schTbl)
    id = id.."_schemes"
    if not Metrostroi.Skins[id] then
        Metrostroi.Skins[id] = {}
    end
    local tbl = Metrostroi.Skins[id]
    for k,v in ipairs(tbl) do
        if name == v.name then
            tbl[k] = schTbl
            tbl[k].name = name
            return
        end
    end
    tbl[table.insert(tbl,schTbl)].name = name
end

-- Last station sign
local defaults = {
    ["702_routes"] = {
        "models/metrostroi_schemes/destination_table_black/label_cross",
        "models/metrostroi_schemes/destination_table_black/label_dev",
        "models/metrostroi_schemes/destination_table_black/label_freight",
    },
    ["710_routes"] = {
        "models/metrostroi_train/81-710/route_empty",
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_dev",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    },
    ["717_routes"] = {
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_dev",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    },
    ["720_routes"] = {
        "models/metrostroi_train/81-720/labels/label_empty",
        "models/metrostroi_schemes/destination_table_white/label_cross",
        "models/metrostroi_schemes/destination_table_white/label_freight",
    }
}
function Metrostroi.AddLastStationTex(id,stIndex,texture)
    id = id.."_routes"
    if not Metrostroi.Skins[id] then
        Metrostroi.Skins[id] = {}
        if defaults[id] then
            if type(defaults[id]) == "table" then
                Metrostroi.Skins[id].default = defaults[id][1]
                for i=2,#defaults[id] do
                    Metrostroi.AddLastStationTex(id:sub(1,-8),1000+(i-1),defaults[id][i])
                end
            else
                Metrostroi.Skins[id].default = defaults[id]
            end
        end
    end
    local tbl = Metrostroi.Skins[id]
    for k,v in pairs(tbl) do
        if k == index then
            tbl[v] = texture
            return
        end
    end
    tbl[stIndex] = table.insert(tbl,texture)
end

-- ASNP
Metrostroi.AnnouncementsASNP = {}
Metrostroi.ASNPSetup = {}
function Metrostroi.AddANSPAnnouncer(name,soundtable,datatable)
	local id = table.insert(Metrostroi.AnnouncementsASNP,soundtable)
	Metrostroi.AnnouncementsASNP[id].name = name
	
	local id = table.insert(Metrostroi.ASNPSetup,datatable)
	Metrostroi.ASNPSetup[id].name = name
	
    -- Metrostroi.ASNPSetup[id].name = name
    -- if not soundtable or not datatable then Error("ASNP error add") return end
    -- for k,v in pairs(datatable) do
        -- if not istable(v) then goto continue end
        -- for k2,stbl in pairs(v) do
            -- if not istable(stbl) then goto continue end
            -- if stbl.have_inrerchange then stbl.have_interchange = true end
        -- end
		-- ::continue::
    -- end
    -- for k,v in pairs(Metrostroi.AnnouncementsASNP) do
        -- if v.name == name then
            -- Metrostroi.AnnouncementsASNP[k] = soundtable
            -- Metrostroi.AnnouncementsASNP[k].name = name
            -- Metrostroi.ASNPSetup[k] = datatable
            -- Metrostroi.ASNPSetup[k].name = name
            -- print("Metrostroi: Changed \""..name.."\" ASNP announcer.")
            -- return
        -- end
    -- end
    -- local id = table.insert(Metrostroi.AnnouncementsASNP,soundtable)
    -- Metrostroi.AnnouncementsASNP[id].name = name

    -- local id = table.insert(Metrostroi.ASNPSetup,datatable)
    -- Metrostroi.ASNPSetup[id].name = name
    -- print("Metrostroi: Added \""..name.."\" ASNP announcer.")
end

-- SarmatUPO
Metrostroi.AnnouncementsSarmatUPO = {}
Metrostroi.SarmatUPOSetup = {}
function Metrostroi.AddSarmatUPOAnnouncer(name,soundtable,datatable)
    if not soundtable or not datatable then return end
    for k,v in pairs(Metrostroi.AnnouncementsSarmatUPO) do
        if v.name == name then
            Metrostroi.AnnouncementsSarmatUPO[k] = soundtable
            Metrostroi.AnnouncementsSarmatUPO[k].name = name
            Metrostroi.SarmatUPOSetup[k] = datatable
            Metrostroi.SarmatUPOSetup[k].name = name
            print("Metrostroi: Changed \""..name.."\" Sarmat UPO(UPO2) announcer.")
            return
        end
    end
    local id = table.insert(Metrostroi.AnnouncementsSarmatUPO,soundtable)
    Metrostroi.AnnouncementsSarmatUPO[id].name = name

    local id = table.insert(Metrostroi.SarmatUPOSetup,datatable)
    Metrostroi.SarmatUPOSetup[id].name = name

    print("Metrostroi: Added \""..name.."\" Sarmat UPO(UPO2) announcer.")
end

-- UPO
Metrostroi.AnnouncementsUPO = {}
Metrostroi.UPOSetup = {}
function Metrostroi.SetUPOAnnouncer(soundtable,datatable)
    if not soundtable or not datatable then return end
    Metrostroi.AnnouncementsUPO = {soundtable}
    Metrostroi.UPOSetup = datatable
    --Generating noise
    for k,v in pairs(Metrostroi.UPOSetup or {}) do
        if v.noises and v.noiserandom < math.random() then
            v.noise = table.Random(v.noises)
        end
    end

    print("Metrostroi: Set UPO announcer and generated nosies.")
end

-- RRI
Metrostroi.AnnouncementsRRI = {}
Metrostroi.RRISetup = {}
function Metrostroi.SetRRIAnnouncer(soundtable,datatable)
    if not soundtable or not datatable then return end
    Metrostroi.AnnouncementsRRI = {soundtable}
    for k,v in pairs(datatable) do
        if not istable(v) then goto continue end
        for k2,stbl in pairs(v) do
            if not istable(stbl) then goto continue end
            if stbl.have_inrerchange then stbl.have_interchange = true end
        end
		::continue::
    end
    Metrostroi.RRISetup = datatable

    print("Metrostroi: Set RRI announcer.")
end

-- Internal Gmod functions
game = {}
function game.GetMap()
	return ""
end

Metrostroi.Loaded = true