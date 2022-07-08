---@class WebView
local WebView

---@deprecated
---@return Drawing
function WebView:asHSDrawing() end

---@deprecated
---@return Window
function WebView:asHSWindow() end

---@deprecated
---@param theLevel integer
---@return Drawing
function WebView:setLevel(theLevel) end

---@param state "visible"|"hidden"
---@return WebView
---@overload fun(): string
function WebView:titleVisibility(state) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:allowGestures(value) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:allowMagnificationGestures(value) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:allowNavigationGestures(value) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:allowNewWindows(value) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:allowTextEntry(value) end

---@param alpha number
---@return WebView
---@overload fun(): number
function WebView:alpha(alpha) end

---@param toolbar HSWebViewToolbar
---@return WebView
---@overload fun(): HSWebViewToolbar
function WebView:attachedToolbar(toolbar) end

---@param behavior number
---@return WebView
---@overload fun(): number
function WebView:behavior(behavior) end

---@param behaviorTable (string|number)[]
---@return WebView
---@overload fun(): number
function WebView:behaviorAsLabels(behaviorTable) end

---@param aboveEverything? boolean
---@return WebView
function WebView:bringToFront(aboveEverything) end

---@return Certificate[]
function WebView:certificateChain() end

---@return WebView[]
function WebView:children() end

---@param flag boolean
---@return WebView
---@overload fun(): boolean
function WebView:closeOnEscape(flag) end

---@param state boolean
---@return boolean
function WebView:darkMode(state) end

---@param propagate? boolean
---@param fadeOutTime? number
function WebView:delete(propagate, fadeOutTime) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:deleteOnClose(value) end

---@return number
function WebView:estimatedProgress() end

---@alias JavascriptCallback fun(result: any, error: table)
-- // TODO property set the type of result and error table

---@param script string
---@param callback? JavascriptCallback
---@return WebView
function WebView:evaluateJavaScript(script, callback) end

---@param flag boolean
---@return WebView
---@overload fun(): boolean
function WebView:examineInvalidCertificates(flag) end

---@param rect Rectangle
---@return WebView
---@overload fun(): Rectangle
function WebView:frame(rect) end

---@return WebView
function WebView:goBack() end

---@return WebView
function WebView:goForward() end

---@param fadeOutTime? number
---@return WebView
function WebView:hide(fadeOutTime) end

---@return WebViewHistory
function WebView:historyList() end

---@return Window
function WebView:hswindow() end

---@param html string
---@param baseURL? string
---@return WebView
function WebView:html(html, baseURL) end

---@return boolean
function WebView:isOnlySecureContent() end

---@return boolean
function WebView:isVisible() end

---@param theLevel number
---@return WebView
---@overload fun(): number
function WebView:level(theLevel) end

---@return boolean
function WebView:loading() end

---@param value number
---@return WebView
---@overload fun(): number
function WebView:magnification(value) end

---@class NavigationError
-- code of the type of error
---@field code number
-- domain of the error
---@field domain string
-- condition or problem that has occurred
---@field description string
-- more information about what may have caused it
---@field reason? string

---@alias NavigationCallback fun(action: string, webView: WebView, navID: string, error: NavigationError)

---@param fn NavigationCallback
---@return WebView
function WebView:navigationCallback(fn) end

---@return string
function WebView:navigationID() end

---@param webview2? WebView
---@return WebView
function WebView:orderAbove(webview2) end

---@param webview2? WebView
---@return WebView
function WebView:orderBelow(webview2) end

---@return WebView | nil
function WebView:parent() end

---@param fn function -- // TODO policy callback function typing
---@return WebView
function WebView:policyCallback(fn) end

---@return boolean
function WebView:privateBrowsing() end

---@param validate? boolean
---@return WebView
function WebView:reload(validate) end

---@return WebView
function WebView:sendToBack() end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:shadow(value) end

---@param fadeInTime? number
---@return WebView
function WebView:show(fadeInTime) end

---@param size Size
---@return WebView
---@overload fun(): Size
function WebView:size(size) end

---@param fn function -- // TODO SSL callback function typing
---@return WebView
function WebView:sslCallback(fn) end

---@return WebView
function WebView:stopLoading() end

---@return string
function WebView:title() end

---@param point Point
---@return WebView
---@overload fun(): Point
function WebView:topLeft(point) end

---@param value boolean
---@return WebView
---@overload fun(): boolean
function WebView:transparent(value) end

---@param URL string | URL
---@return WebView
---@overload fun(): string
function WebView:url(URL) end

---@return URLParts
function WebView:urlParts() end

---@param agent string
---@return WebView
---@overload fun(): string
function WebView:userAgent(agent) end

---@param fn function -- // TODO window callback function typing
---@return WebView
function WebView:windowCallback(fn) end

---@param mask number | string | string[]
---@return WebView
---@overload fun(): number
function WebView:windowStyle(mask) end

---@param title string
---@return WebView
---@overload fun(): string
function WebView:windowTitle(title) end
