---@class HSNotify
---@field activationTypes ActivationTypes
---@field defaultNotificationSound string
---@field registry RegistryEntry[]
---@field warnAboutMissingFunctionTag boolean
local HSNotify

---@return Notification[]
function HSNotify.deliveredNotifications() end

---@alias NotificationCallback fun(notification: Notification)

---@param tag string
---@param fn NotificationCallback
---@return number
function HSNotify.register(tag, fn) end

---@return Notification[]
function HSNotify.scheduledNotifications() end

---@param idOrTag number | string
function HSNotify.unregister(idOrTag) end

-- Unregisters all functions registered as callbacks.
function HSNotify.unregisterall() end

-- Withdraw all delivered notifications from Hammerspoon
function HSNotify.withdrawAll() end

-- Withdraw all scheduled notifications from Hammerspoon
function HSNotify.withdrawAllScheduled() end

---@class NotificationAttributes
---@field alwaysPresent boolean
---@field autoWithdraw boolean
---@field contentImage Image
---@field informativeText string
---@field soundName string
---@field subTitle string
---@field title string
---@field setIdImage Image | string
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field actionButtonTitle string
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field hasActionButton boolean
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field otherButtonTitle string
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field additionalActions string[]
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field hasReplyButton boolean
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field responsePlaceholder string
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field alwaysShowAdditionalActions boolean
-- Only effective if Hammerspoon notification style is set to "Alert".
---@field withdrawAfter number

---@param fn? string | NotificationCallback
---@param attributes? NotificationAttributes
---@return Notification
function HSNotify.new(fn, attributes) end

---@param title string
---@param subTitle string
---@param information string
---@param tag? string
---@return Notification
function HSNotify.show(title, subTitle, information, tag) end
