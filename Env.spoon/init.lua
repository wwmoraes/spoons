--- === Env ===
---
--- loads environment variables from dotenv-alike files, and overrides `os.getenv`
--- function to first get variables from the `Env` instance, falling back to a
--- vanilla `os.getenv` call if none is set.
---
--- This is mostly useful on MacOS 10.10+, due to the changes on launchctl and
--- its APIs to set environment variables for the graphical domain, which
--- requires the use of undocumented XPC calls to set them.
---

---@class EnvConfig
-- files to load environment variables from
---@field public files string[]

-- Env Spoon object
---@class Env : EnvConfig, Spoon
-- global logger instance
---@field protected logger Logger
-- variables loaded from the files
---@field protected variables table<string,string>
local obj = {
  variables = {},
  files = {
    os.getenv("HOME") .. "/.env",
    os.getenv("HOME") .. "/.env_secrets"
  }
}
obj.__index = obj

-- Metadata
obj.name = "Env"
obj.version = "1.0"
obj.author = "William Artero"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- loads environment variables from the given file, if it exists
--- @param filename string @file path and name to load variables from
--- @return Env @the Env object
function obj:loadFromFilename(filename)
  local fd, err = io.open(filename, "r")
  if fd == nil then
    self.logger.v(err)
    self.logger.i(string.format("skipped %s", filename))
    return self
  end

  self:loadFromFile(fd)
  io.close(fd)
  self.logger.i(string.format("loaded %s", filename))

  return self
end

--- loads environment variables from the given file, if it exists
--- @param fd file* @open file descriptor to read and load variables from
--- @return Env @the Env object
function obj:loadFromFile(fd)
  fd:seek("set", 0)
  assert(fd, "file descriptor is nil")

  --- @type string|nil
  for line in fd:lines("l") do
    if line == nil then
      goto continue
    end
    if line:sub(1) == "#" then
      goto continue
    end

    local index = line:find("=", 1, true)
    if index == nil then
      goto continue
    end

    local name = line:sub(1, index - 1)
    local value = line:sub(index + 1)

    self.logger.df("%s => %s", name, value)
    self.variables[name] = value

    ::continue::
  end

  return self
end

--- reads environment variable files and
--- @return Env @the Env object
function obj:load()
  obj.variables = {}

  for i, filename in ipairs(self.files) do
    self:loadFromFilename(filename)
  end

  return self
end

--- returns the variable value stored on this instance, if it is set, or returns
--- the value from a vanilla `os.getenv` call
--- @param name string @variable name to get
--- @return string? @the variable value or `nil`, if not set
function obj:getenv(name)
  return self.variables[name] or obj.osgetenv(name)
end

--- sets up the environment files based on the host name and tags
--- @return Env
function obj:init()
  self.logger = hs.logger.new(string.lower(self.name))

  local f, err = io.open(os.getenv("HOME") .. "/.tagsrc")
  assert(f, err)

  for tag in f:lines("l") do
    table.insert(self.files, os.getenv("HOME") .. "/.env_" .. tag)
    table.insert(self.files, os.getenv("HOME") .. "/.env_" .. tag .. "_secrets")
  end
  f:close()

  table.insert(self.files, os.getenv("HOME") .. "/.env")
  table.insert(self.files, os.getenv("HOME") .. "/.env_secrets")

  local thisHostname = hs.network.configuration.open():hostname()
  table.insert(self.files, os.getenv("HOME") .. "/.env-" .. thisHostname)

  return self
end

--- loads the environment files and overrides `os.getenv` function so it tries
--- to get environment variables from this `Env` instance first, falling back to
--- the original lua function if the variable is unset
--- @return Env
function obj:start()
  obj:load()

  obj.osgetenv = os.getenv
  os.getenv = hs.fnutils.partial(self.getenv, self)

  return self
end

--- restores `os.getenv` and cleanups the loaded environment variables
--- @return Env
function obj:stop()
  os.getenv = obj.osgetenv

  obj.osgetenv = nil
  obj.variables = {}

  return self
end

return obj
