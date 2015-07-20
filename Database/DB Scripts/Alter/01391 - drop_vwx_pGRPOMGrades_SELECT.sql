IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_pGRPOMGrades_SELECT')
   BEGIN
         DROP VIEW vwx_pGRPOMGrades_SELECT
   END
 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01391', GetDate())
GO