ALTER TABLE pLinePlanMultiClothStyleTemp ALTER COLUMN SizeClass NVARCHAR(400);
ALTER TABLE pLinePlanMultiClothStyleTemp ALTER COLUMN SizeRange NVARCHAR(200);
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09383', GetDate())
GO

