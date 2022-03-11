local obj = {}
obj.__index = obj

function frontApp()
    return hs.application.frontmostApplication():bundleID()
end

function focusedWindowIs(bundle)
    return hs.window.focusedWindow():application():bundleID() == bundle
end

hyperKeys = {}

hyper = {
    appToMap = '',
}

function firstOrInsert(mappings, key)
    if (mappings[key]) then
        return mappings[key]
    end

    mappings[key] = {}
    return mappings[key]
end

function hyper:action(action, mappings)
    for target, closure in pairs(mappings) do
        firstOrInsert(hyperKeys, action)
        firstOrInsert(hyperKeys[action], target)
        firstOrInsert(hyperKeys[action][target], self.appToMap)
        hyperKeys[action][target][self.appToMap] = closure
    end
    return self
end

function hyper:app(app)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.appToMap = app
    return o
end

hs.urlevent.bind('hyper', function(_, params)
    if (
        not hyperKeys[params.action] or
        not hyperKeys[params.action][params.target]
    ) then
        return
    end

    command = hyperKeys[params.action][params.target][frontApp()]
    if (command == nil) then
        command = hyperKeys[params.action][params.target]['fallback']
    end

    if (command ~= nil) then
        command()
    end
end)

return obj
