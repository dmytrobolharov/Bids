ALTER TABLE pSampleRequestMaterialTemp ALTER COLUMN [height] [nvarchar] (100) NULL
ALTER TABLE pSampleRequestMaterialTemp ALTER COLUMN [width] [nvarchar] (100) NULL



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '683', GetDate())
GO
