ALTER TABLE pStyleMaterialTemp ALTER COLUMN [height] [nvarchar] (100) NULL
ALTER TABLE pStyleMaterialTemp ALTER COLUMN [width] [nvarchar] (100) NULL



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '684', GetDate())
GO
