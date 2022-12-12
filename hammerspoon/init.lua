-- Automagically™ recompile Karabiner's configs using Goku
gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({ title = 'Karabiner Config', informativeText = output }):send()
end):start()

-- Automagically™ reload Hammerspoon's configs
hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()
hs.notify.new({ title = 'Hammerspoon', informativeText = 'Config loaded' }):send()


hs.loadSpoon('Hyper')
hs.loadSpoon('Helpers')

-- Use `osascript -e 'id of app "Slack"'` to find the ID of an app
slack = 'com.tinyspeck.slackmacgap'
discord = 'com.hnc.Discord'
bear = 'net.shinyfrog.bear'
intellij = 'com.jetbrains.intellij'
fellow = 'com.electron.fellow'

hyper:app(slack)
    :action('open', {
        default = combo({ 'cmd' }, 'k'),
    })

hyper:app(discord)
    :action('open', {
        default = combo({ 'cmd' }, 'k'),
    })

hyper:app(bear)
    :action('open', {
        default = alfredWorkflow('com.drgrib.bear', 'search bear'),
    })

hyper:app(intellij)
    :action('open', {
        default = combo({ 'cmd', 'option' }, 'o')
    })

hyper:app(fellow)
    :action('open', {
        default = combo({ 'cmd' }, 'k')
    })

hyper:app('fallback')
    :action('open', {
        default = combo({ 'cmd' }, 'p'),
    })

-- Quick 👋 reaction in Slack
hyper:app(slack)
    :action('slack-rw-wave', {
        default = chain({ keys('+:wave:'), key('return') })
    })
