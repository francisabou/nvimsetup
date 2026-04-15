require("Francis.remap")
require("Francis.set")

-- OpenFOAM dictionary filetype detection
-- These extensionless files use C++-style syntax (block comments, braces, #include)
vim.filetype.add({
    filename = {
        -- system/
        controlDict = "cpp",
        fvSchemes = "cpp",
        fvSolution = "cpp",
        fvOptions = "cpp",
        blockMeshDict = "cpp",
        decomposeParDict = "cpp",
        setFieldsDict = "cpp",
        topoSetDict = "cpp",
        snappyHexMeshDict = "cpp",
        createPatchDict = "cpp",
        changeDictionaryDict = "cpp",
        mapFieldsDict = "cpp",
        meshQualityDict = "cpp",
        surfaceFeaturesDict = "cpp",
        surfaceFeatureExtractDict = "cpp",
        -- constant/
        transportProperties = "cpp",
        physicalProperties = "cpp",
        momentumTransport = "cpp",
        turbulenceProperties = "cpp",
        thermophysicalProperties = "cpp",
        dynamicMeshDict = "cpp",
        g = "cpp",
        regionProperties = "cpp",
    },
})

-- Wolfram Language filetype detection
-- Only .wl/.wls mapped to "mma"; .m left for Matlab
vim.filetype.add({
    extension = {
        wl = "mma",
        wls = "mma",
    },
})
