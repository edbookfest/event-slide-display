util.init_hosted()

if CONFIG.auto_resolution then
    gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)
else
    gl.setup(CONFIG.width, CONFIG.height)
end

node.alias("walkin/event-slide")

local signing = "true"
local loaded_event_id
local event_slide = CONFIG.default_slide.get_surface()

local function get_additional_image(filename)
    local images = CONFIG.additional_images
    for i = 1, #images do
        if images[i].file.filename == filename then
            print(images[i].file.asset_name)
            return true, images[i].file.get_surface()
        end
    end
    return false
end

local function load_event_slide(event_id)
    print("ATTEMPTNG TO LOAD EVENT SLIDE FOR: " .. event_id)
    local filename = event_id .. ".png"
    local got_additional, surface = get_additional_image(filename)
    if got_additional then
        event_slide = surface
        loaded_event_id = event_id
        print("USING ADDITIONAL IMAGE FOR: " .. event_id)
    else
        local file_exists, openfile = pcall(resource.open_file, filename)
        if file_exists then
            event_slide = resource.load_image(openfile)
            loaded_event_id = event_id
            print("LOADING EVENT SLIDE FOR: " .. event_id)
        else
            event_slide = CONFIG.default_slide.get_surface()
            loaded_event_id = nil
            print("NO EVENT SLIDE FOUND FOR: " .. event_id)
        end
    end
end

util.data_mapper {
    ["eventid"] = function(eventid)
        load_event_slide(eventid)
    end;
    ["signing"] = function(value)
        print("BOOK SIGNING " .. value)
        if value ~= signing then
            signing = value
        end
    end;
}

function node.render()
    gl.clear(0, 0, 0, 1)

    util.draw_correct(event_slide, 0, 0, WIDTH, HEIGHT)

    if signing == "true" and loaded_event_id then
        local signing_text_width = CONFIG.signing_font:width(CONFIG.signing_text, CONFIG.signing_font_size)
        CONFIG.signing_font:write((WIDTH - signing_text_width) / 2, HEIGHT - CONFIG.signing_y, CONFIG.signing_text, CONFIG.signing_font_size, CONFIG.signing_colour.rgba())
    end
end
