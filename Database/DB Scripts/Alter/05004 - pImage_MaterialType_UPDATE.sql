-- Moving all 'Material Type' records to ImageSubFolder12
UPDATE pImage SET ImageSubFolder12 = ImageSubFolder6
WHERE ImageSubFolder1 = 'Material'
AND ImageSubFolder6 IS NOT NULL
AND ImageSubFolder6 NOT LIKE 
REPLACE('00000000-0000-0000-0000-000000000000', '0', '[0-9a-fA-F]');

-- Clearing the ImageSubFolder6 to avoid varchar-to-GUID conversion violation
UPDATE pImage SET ImageSubFolder6 = NULL
WHERE ImageSubFolder6 NOT LIKE 
REPLACE('00000000-0000-0000-0000-000000000000', '0', '[0-9a-fA-F]');

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05004', GetDate())
GO
