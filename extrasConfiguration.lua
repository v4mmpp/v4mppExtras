---@public
---@class extrasConfig
---@author RevengeBack_
extrasConfig = {
    control = { 
        key = { active = true, key = "f3" },
        commande = { active = false, name = "extras" } 
    },

    maximumExtrasCount = 9, -- (9 max);
    allowedVehicles = {
        active = false, vehicles = { -- Vehicles model names
            'police',
            'ambulance',
            'buffalo',
        }
    };
};
