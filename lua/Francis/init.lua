require("Francis.remap")
require("Francis.set")

-- Filetype detection: OpenFOAM dictionaries (extensionless, C++-style syntax)
-- and Wolfram Language (.wl/.wls → mma; .m left for Matlab)
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
    extension = {
        wl = "mma",
        wls = "mma",
    },
})
