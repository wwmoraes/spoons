---@class Notification
local Notification

---@param buttonTitle string
---@return Notification
---@overload fun(): string
function Notification:actionButtonTitle(buttonTitle) end

---@return number
function Notification:activationType() end

---@return number
function Notification:actualDeliveryDate() end

---@param actionsTable string[]
---@return Notification
---@overload fun(): string[]
function Notification:additionalActions(actionsTable) end

---@return string | nil
function Notification:additionalActivationAction() end

---@param alwaysPresent boolean
---@return Notification
---@overload fun(): boolean
function Notification:alwaysPresent(alwaysPresent) end

---@param state boolean
---@return Notification
---@overload fun(): boolean
function Notification:alwaysShowAdditionalActions(state) end

---@param shouldWithdraw boolean
---@return Notification
---@overload fun(): boolean
function Notification:autoWithdraw(shouldWithdraw) end

---@param image Image
---@return Notification
---@overload fun(): Image
function Notification:contentImage(image) end

---@return boolean
function Notification:delivered() end

---@return string
function Notification:getFunctionTag() end

---@param hasButton boolean
---@return Notification
---@overload fun(): boolean
function Notification:hasActionButton(hasButton) end

---@param state boolean
---@return Notification
---@overload fun(): boolean
function Notification:hasReplyButton(state) end

---@param informativeText string
---@return Notification
---@overload fun(): string
function Notification:informativeText(informativeText) end

---@param buttonTitle string
---@return Notification
---@overload fun(): string
function Notification:otherButtonTitle(buttonTitle) end

---@return boolean
function Notification:presented() end

---@return string?
function Notification:response() end

---@param placeholder string
---@return Notification
---@overload fun(): string
function Notification:responsePlaceholder(placeholder) end

---@param date number | string
---@return Notification
function Notification:schedule(date) end

---@return Notification
function Notification:send() end

---@param image string | Image
---@param withBorder? boolean
---@return Notification
function Notification:setIdImage(image, withBorder) end

---@param soundName string
---@return Notification
---@overload fun(): string
function Notification:soundName(soundName) end

---@param subtitleText string
---@return Notification
---@overload fun(): string
function Notification:subTitle(subtitleText) end

---@param titleText string
---@return Notification
---@overload fun(): string
function Notification:title(titleText) end

---@return Notification
function Notification:withdraw() end

---@param seconds number
---@return Notification
---@overload fun(): number
function Notification:withdrawAfter(seconds) end
