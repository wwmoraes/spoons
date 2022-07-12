-- // TODO hs.http

---@class HSHTTP
---@field htmlEntities table<string, string>
local HSHTTP

---@alias Headers table<string,string>

---@alias RequestCallback fun(status: number, body: string, headers?: Headers)

---@param url string
---@param headers? Headers
---@param callback RequestCallback
function HSHTTP.asyncGet(url, headers, callback) end

---@param url string
---@param data? string
---@param headers? Headers
---@param callback RequestCallback
function HSHTTP.asyncPost(url, data, headers, callback) end

---@param url string
---@param data? string
---@param headers? Headers
---@param callback RequestCallback
function HSHTTP.asyncPut(url, data, headers, callback) end

---@param inString string
---@return string
function HSHTTP.convertHtmlEntities(inString) end

---@param url string
---@param method string
---@param data? string
---@param headers? Headers
---@param callback RequestCallback
---@param cachePolicy RequestCachePolicy
function HSHTTP.doAsyncRequest(url, method, data, headers, callback, cachePolicy) end

---@param url string
---@param method string
---@param data? string
---@param headers? Headers
---@param cachePolicy? RequestCachePolicy
---@return number status
---@return string body
---@return Headers headers
function HSHTTP.doRequest(url, method, data, headers, cachePolicy) end

---@param string string
---@return string
function HSHTTP.encodeForQuery(string) end

---@param url string
---@param headers? Headers
---@return number status
---@return string body
---@return Headers headers
function HSHTTP.get(url, headers) end

---@param url string
---@param data? string
---@param headers? Headers
---@return number status
---@return string body
---@return Headers headers
function HSHTTP.post(url, data, headers) end

---@param url string
---@param data? string
---@param headers? Headers
---@return number status
---@return string body
---@return Headers headers
function HSHTTP.put(url, data, headers) end

---@param entity string
---@param codepoint number|string
---@return string
function HSHTTP.registerEntity(entity, codepoint) end

---@param url string
---@return URLParts
function HSHTTP.urlParts(url) end
