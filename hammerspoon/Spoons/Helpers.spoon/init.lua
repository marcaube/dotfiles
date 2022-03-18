hs.loadSpoon('ModalMgr')

local obj = {}
obj.__index = obj

function combo(modifiers, key)
    return function()
        hs.eventtap.keyStroke(modifiers, key)
    end
end

function key(key)
    return function()
        hs.eventtap.keyStroke({}, key)
    end
end

function keys(keys)
    return function()
        hs.eventtap.keyStrokes(keys)
    end
end

function chain(commands)
    return function ()
        for _, command in pairs(commands) do
            command()
        end
    end
end

function alfredSearch(keys)
    return function()
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "' .. keys ..' "')
    end
end

function alfredWorkflow(workflow, trigger)
    return function()
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"')
    end
end

function launch(bundleID)
    return function()
        hs.application.launchOrFocusByBundleID(bundleID)
    end
end

function modal(name, actions, onEnter, onExit)
    spoon.ModalMgr:new(name)
    local modal = spoon.ModalMgr.modal_list[name]
    modal:bind('', 'escape', 'Deactivate ' .. name .. ' modal', function()
        spoon.ModalMgr:deactivate({name})
    end)

    if (onEnter) then
        modal.entered = onEnter
    end
    if (onExit) then
        modal.exited = onExit
    end

    for key, action in pairs(actions) do
        modal:bind('', key, '', function()
            action()
            spoon.ModalMgr:deactivate({name})
        end)
    end

    return function()
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr:activate({name}, '#0000FF', false)
    end
end

return obj
