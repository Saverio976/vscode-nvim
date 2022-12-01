local okimpatient, impatient = pcall(require, 'impatient')
if okimpatient then
    impatient.enable_profile()
end
local okfiletype, filetype = pcall(require, 'filetype')
if okfiletype then
    filetype.setup({
        overrides = {
            extensions = {
                h = "c",
                v = "v",
                hpp = "cpp",
            },
        },
    })
end

local username = "nvimuser"

local file_to_load = {
    username .. "." .. "packer-plugins",
    username .. "." .. "theme",
    username .. "." .. "commands",
    username .. "." .. "telescope",
    username .. "." .. "terminal",
    username .. "." .. "lsp",
    username .. "." .. "autocompletion",
    username .. "." .. "codeaction",
    username .. "." .. "options",
    username .. "." .. "text-interract",
    username .. "." .. "autocommands",
}

local is_debug = true

for _, file in ipairs(file_to_load) do
    if is_debug then
        require(file)
    else
        local okimport, _ = pcall(require, file)
        if not okimport then
            print("can't load file: " .. file .. "\n")
        end
    end
end
