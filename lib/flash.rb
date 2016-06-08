require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    flash_val = req.cookies['_rails_lite_app_flash']
    if flash_val
      @now = JSON.parse(flash_val)
    else
      @now = {}
    end
    @flash = {}
  end

  def [](key)
    @flash[key] || @now[key]
  end

  def []=(key, val)
    @flash[key] = val
    @now[key] = val
  end

  def store_flash(res)
    res.set_cookie("_rails_lite_app_flash", { path: "/", value: @flash.to_json })
  end
end
