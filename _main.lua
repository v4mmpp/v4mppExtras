--[[
    This file was generated automatically
    Credits. Author @RevengeBack_
    A part of v4mppExtras
    All rights reserved ©.
]]

local menuOpenned = false;
local menuSettings = { nil, nil }
local extraMenu = RageUI.CreateMenu("Extras", "MENU EXTRAS", table.unpack(menuSettings))
extraMenu.Closed = function()
    menuOpenned = false
end

---@private
---@author RevengeBack_
---@type function vehicleAreAllowed
local function vehicleAreAllowed(playerVehicle)
    local vehicleModel = GetEntityModel(playerVehicle)
    for _,v in pairs(extrasConfig.allowedVehicles) do
        if (vehicleModel == GetHashKey(v)) then
            return (true);
        end
    end
    return (false);
end

---@public
---@author RevengeBack_
---@type function openExtraMenu
function openExtraMenu()
    local haveExtras = false;

    if (menuOpenned) then
        menuOpenned = false
        RageUI.Visible(extraMenu, false)
        return;
    else
        menuOpenned = true
        RageUI.Visible(extraMenu, not RageUI.Visible(extraMenu))

        CreateThread(function()
            while (menuOpenned) do

                RageUI.IsVisible(extraMenu, function()
                    local pPed = PlayerPedId();
                    local pInVeh = IsPedInAnyVehicle(pPed, false)

                    if (pInVeh) then
                        local pVeh = GetVehiclePedIsIn(pPed, false)
                        
                        if (vehicleAreAllowed(pVeh)) then
                            for i=1, extrasConfig.maximumExtrasCount do
                                if (DoesExtraExist(pVeh, i)) then
                                    haveExtras = true;
    
                                    if (IsVehicleExtraTurnedOn(pVeh, i)) then
                                        RageUI.Button("~r~Desactiver~s~ " .. i, nil, {}, true, {
                                            onSelected = function()
                                                SetVehicleExtra(pVeh, i, true)
                                            end
                                        })
                                    else
                                        RageUI.Button("~g~Activer~s~ " .. i, nil, {}, true, {
                                            onSelected = function()
                                                SetVehicleExtra(pVeh, i, false)
                                            end
                                        })
                                    end
                                end
                            end
    
                            if (not haveExtras) then
                                RageUI.Separator("~r~Ce véhicule ne possède aucun extra")
                            end
                        else
                            RageUI.Separator("~r~Véhicule non autorisé") 
                        end
                    else
                        haveExtras = false;
                        RageUI.Separator("~r~Vous devez être a l'interieur d'un véhicule~s~")
                    end
                end)

                Wait(2.0)
            end
        end)
    end
end

if (extrasConfig.control.commande.active) then
    RegisterCommand(extrasConfig.control.commande.name, function()
        openExtraMenu();
    end)
end

if (extrasConfig.control.key.active) then
    Keys.Register(extrasConfig.control.key.key:lower(), extrasConfig.control.key.key:upper(), "Ouvrir menu extras véhicule", function()
        openExtraMenu();
    end)
end
