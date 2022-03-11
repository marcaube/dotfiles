gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function ()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end):start()

hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

hs.loadSpoon('Hyper')
hs.loadSpoon('Helpers')


-- slack = 'com.tinyspeck.slackmacgap'

-- hyper:app(slack)
--     :action('open', {
--         default = combo({'cmd'}, 'k'),
--     })

-- hyper:app('fallback')
--     :action('open', {
--         default = combo({'cmd'}, 'p'),
--     })
