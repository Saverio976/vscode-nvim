local username = "nvimuser"

local file_to_load = {
    username .. "." .. "packer-plugins",
    username .. "." .. "theme",
    username .. "." .. "autocommands",
    username .. "." .. "commands",
    username .. "." .. "terminal",
    username .. "." .. "lsp",
    username .. "." .. "autocompletion",
    username .. "." .. "codeaction",
    username .. "." .. "options",
}

local is_debug = false

for _, file in ipairs(file_to_load) do
    if is_debug then
        require(file)
    else
        local okimport, _ = pcall(require, file)
        if not okimport then
            print("can't load file: " .. file)
            print("\n")
        end
    end
end
