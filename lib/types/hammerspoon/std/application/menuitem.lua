--- @class ApplicationMenuItem
--- text of the menu item (entries which have no title are menu separators)
--- @field AXTitle string
--- whether the menu item is clickable
--- @field AXEnabled boolean
--- role of the menu item - this will be either `AXMenuBarItem` for a top level
--- menu, or `AXMenuItem` for an item in a menu
--- @field AXRole '"AXMenuBarItem"'|'"AXMenuItem"'
--- "mark" character for a menu item. This is for toggleable menu items and will
--- usually be an empty string or a Unicode tick character (✓)
--- @field AXMenuItemMarkChar string
--- keyboard modifiers for the menu item's keyboard shortcut, or nil if no
--- modifiers are present
--- @field AXMenuItemCmdModifiers string[]|nil
--- key for the menu item's keyboard shortcut, or an empty string if no shortcut
--- is present
--- @field AXMenuItemCmdChar string
--- one of the defined glyphs in `hs.application.menuGlyphs` if the keyboard
--- shortcut is a special character usually represented by a pictorial
--- representation (think arrow keys, return, etc), or an empty string if no
--- glyph is used in presenting the keyboard shortcut.
--- @field AXMenuItemCmdGlyph integer
--- @field AXChildren ApplicationMenuItemChildren[]|nil
