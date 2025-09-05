gameboyMod = {
    gameboy = require("lib/gameboy"),
    filebrowser = require("lib/filebrowser"),
    binser = require("lib/binser"),
    gameboyInstance = nil,

    panels = {},

    panels.audio = require("lib/panels/audio"),
    panels.registers = require("lib/panels/registers"),
    panels.io = require("lib/panels/io"),
    panels.vram = require("lib/panels/vram"),
    panels.oam = require("lib/panels/oam"),
    panels.disassembler = require("lib/panels/disassembler")
}

function gameboyMod.new()
    gameboyInstance = gameboy.new()

    gameboyMod.audio_dump_running = false
    gameboyMod.game_filename = ""
    gameboyMod.game_path = ""
    gameboyMod.game_loaded = false
    gameboyMod.version = "0.1.1"
    gameboyMod.window_title = ""
    gameboyMod.save_delay = 0

    gameboyMod.game_screen_image = nil
    gameboyMod.game_screen_imagedata = nil

    gameboyMod.debug = {}
    gameboyMod.debug.active_panels = {}
    gameboyMod.debug.enabled = false

    gameboyMod.emulator_running = false
    gameboyMod.menu_active = true

    gameboyMod.screen_scale = 3
end

function gameboyMod.reset()
    gameboyMod.gameboyInstance = gameboy.new{}
    gameboyMod.gameboyInstance:initialize()
    gameboyMod.gameboyInstance:reset()
    --gameboyMod.gameboyInstance.audio.on_buffer_full(gameboyMod.play_gameboy_audio)
    gameboyMod.audio_dump_running = false
    gameboyMod.gameboyInstance.graphics.palette_dmg_colors = palette
  
    -- Initialize Debug Panels
    for _, panel in pairs(gameboyMod.panels) do
      panel.init(gameboyMod.gameboyInstance)
    end
end

function gameboyMod.load_game(game_path)
    gameboyMod.reset()
  
    local file_data = gameboyMod.readAll(game_path)
    local size = gameboyMod.fsize(game_path)
    if file_data then
      gameboyMod.game_path = game_path
      gameboyMod.game_filename = game_path
      while string.find(gameboyMod.game_filename, "/") do
        gameboyMod.game_filename = string.sub(gameboyMod.game_filename, string.find(gameboyMod.game_filename, "/") + 1)
      end
  
      gameboyMod.gameboyInstance.cartridge.load(file_data, size)
      gameboyMod.load_ram()
      gameboyMod.gameboyInstance:reset()
  
      print("Successfully loaded ", gameboyInstance.game_filename)
    else
      print("Couldn't open ", game_path, " giving up.")
      return
    end
  
    --self.window_title = "LuaGB v" .. self.version .. " - " .. self.gameboy.cartridge.header.title
    --love.window.setTitle(self.window_title)
  
    --self.menu_active = false
    --self.emulator_running = true
    --self.game_loaded = true
end

function gameboyMod.load_ram()
  local filename = "lib/saves/" .. gameboyMod.game_filename .. ".sav"
  local file_data = gameboyMod.readAll(game_path)
  local size = gameboyMod.fsize(game_path)
  if type(size) == "string" then
    print(size)
    print("Couldn't load SRAM: ", filename)
  else
    if size > 0 then
      local save_data, elements = gameboyMod.binser.deserialize(file_data)
      if elements > 0 then
        for i = 0, #save_data[1] do
          gameboyMod.gameboyInstance.cartridge.external_ram[i] = save_data[1][i]
        end
        print("Loaded SRAM: ", filename)
      else
        print("Error parsing SRAM data for ", filename)
      end
    end
  end
end

function gameboyMod.readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function gameboyMod.fsize(file)
  local current = file:seek()      -- get current position
  local size = file:seek("end")    -- get file size
  file:seek("set", current)        -- restore position
  return size
end

return gameboyMod