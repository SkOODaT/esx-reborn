-- Copyright (c) Jérémie N'gadi
--
-- All rights reserved.
--
-- Even if 'All rights reserved' is very clear :
--
--   You shall not use any piece of this software in a commercial product / service
--   You shall not resell this software
--   You shall not provide any facility to install this particular software in a commercial product / service
--   If you redistribute this software, you must link to ORIGINAL repository at https://github.com/ESX-Org/esx-reborn
--   This copyright should appear in every part of the project code

M('command')

local addLicenseCommand = Command("addlicense", "admin", "Add a license to a player")
addLicenseCommand:addArgument("targetPlayer", "player", "The player to add the license to")
addLicenseCommand:addArgument("license", "string", "The license to add")
addLicenseCommand:setRconAllowed(true)
addLicenseCommand:setHandler(function(player, args)
  local license = args.license
  local targetPlayer = args.targetPlayer

  local targetIdentity = targetPlayer.identity

  if targetIdentity == nil then
    return emitClient("chat:addMessage", player.source, {args = {'^1SYSTEM', _U('commanderror_noidentity')}})
  end

  local result = targetIdentity:getLicenses():addLicense(license)

  if result then
    targetIdentity:save()
  end

end)

local removeLicenseCommand = Command("removelicense", "admin", "Removes a license from a player")
removeLicenseCommand:addArgument("targetPlayer", "player", "The player to remove the role from")
removeLicenseCommand:addArgument("license", "string", "The license to remove")
removeLicenseCommand:setRconAllowed(true)
removeLicenseCommand:setHandler(function(player, args)
  local license = args.license
  local targetPlayer = args.targetPlayer

  local targetIdentity = targetPlayer.identity

  if targetIdentity == nil then
    return emitClient("chat:addMessage", player.source, {args = {'^1SYSTEM', _U('commanderror_noidentity')}})
  end

  local result = targetIdentity:getLicenses():removeLicense(license)

  if result then
    targetIdentity:save()
  end

end)

addLicenseCommand:register()
removeLicenseCommand:register()
