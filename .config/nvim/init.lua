local username = "nvimuser"

local file_to_load = {
    username .. "." .. "packer-plugins",
    username .. "." .. "theme",
    username .. "." .. "autocommands",
    username .. "." .. "commands",
    username .. "." .. "terminal",
    username .. "." .. "lsp",
    username .. "." .. "codeaction",
    username .. "." .. "options",
}

for _, file in ipairs(file_to_load) do
    local okimport, _ = pcall(require, file)
    if not okimport then
        print("can't load file: " .. file)
    end
end
