local osys = require("cmake-tools.osys")
require('cmake-tools').setup({})
cmake_build_directory = function()
    return "out/${variant:buildType}"
end -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
