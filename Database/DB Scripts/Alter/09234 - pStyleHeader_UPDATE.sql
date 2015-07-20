
UPDATE pStyleHeader
SET SubCategoryId = NULL
WHERE UPPER(SubCategoryId) = 'NULL'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09234', GetDate())
GO
