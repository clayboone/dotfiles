# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Enable JavaScript in non-http pages, too
config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Don't create ~/Downloads every time I download something
c.downloads.location.directory = '$HOME/'
c.downloads.location.prompt = True

# Only show status bar in command mode
c.statusbar.hide = True

# Use i3 to manage "tabs"
c.tabs.tabs_are_windows = True  # never use tabs
c.tabs.show = 'never'  # never show tab bar
c.new_instance_open_target = 'window'  # new instances

# Make font a bit smaller/bigger (?)
c.fonts.web.size.default = 18
c.fonts.web.size.default_fixed = 14
c.fonts.web.size.minimum = 6  # dont hide tiny text, though

# Binds
config.bind('q', 'close')

# Load autoconfig.yml after this file
config.load_autoconfig()
