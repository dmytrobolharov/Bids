IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_Development_Status_SELECT]'))
DROP VIEW [dbo].[vwx_Style_Development_Status_SELECT]
GO

CREATE VIEW [dbo].[vwx_Style_Development_Status_SELECT]
AS
SELECT     ISNULL(g.GroupName, '') AS GroupName, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS ImagePath, sh.StyleNo, sh.Description, 
                      sc.StyleCategory, sh.SizeClass, ISNULL(sh.CustomField9, '') AS StyleStatus, sh.DueDate, CASE WHEN sh.DueDate < GETDATE() THEN CAST(DATEDIFF(d, sh.DueDate,
                       GETDATE()) AS NVARCHAR(10)) ELSE '' END AS DaysLeft, ssy.StyleSeason, ssy.StyleYear, CASE WHEN sh.OwnerGroup IS NULL 
                      THEN '00000000-0000-0000-0000-000000000000' WHEN sh.OwnerGroup = '' THEN '00000000-0000-0000-0000-000000000000' ELSE sh.OwnerGroup END AS OwnerGroup,
                       sc.StyleCategoryId, sh.StyleType, ISNULL(CAST(sh.CustomField1 AS NVARCHAR(50)), '') AS Division
FROM         dbo.pStyleHeader AS sh LEFT OUTER JOIN
                      dbo.uGroup AS g ON CAST(g.GroupID AS NVARCHAR(50)) = sh.OwnerGroup LEFT OUTER JOIN
                      dbo.pStyleCategory AS sc ON sc.StyleCategoryId = sh.StyleCategory INNER JOIN
                      dbo.pStyleSeasonYear AS ssy ON ssy.StyleID = sh.StyleID
WHERE     (sh.Active = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05999', GetDate())
GO
