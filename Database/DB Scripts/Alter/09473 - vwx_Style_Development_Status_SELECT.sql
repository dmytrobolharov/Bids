IF OBJECT_ID(N'[dbo].[vwx_Style_Development_Status_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Style_Development_Status_SELECT]
GO

CREATE VIEW [dbo].[vwx_Style_Development_Status_SELECT]
AS
SELECT ISNULL(g.GroupName, '') AS GroupName, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS ImagePath, 
       sh.StyleNo, sh.Description, sc.StyleCategory, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, ISNULL(sh.CustomField3, '') AS StyleStatus, 
	   sh.DueDate, CASE WHEN sh.DueDate < GETDATE() THEN CAST(DATEDIFF(d, sh.DueDate, GETDATE()) AS NVARCHAR(10)) ELSE '' END AS DaysLeft, 
	   ssy.StyleSeason, ssy.StyleYear, 
	   CASE WHEN sh.OwnerGroup IS NULL THEN '00000000-0000-0000-0000-000000000000' 
	        WHEN sh.OwnerGroup = '' THEN '00000000-0000-0000-0000-000000000000' 
			ELSE sh.OwnerGroup END AS OwnerGroup,
       sc.StyleCategoryId, sh.StyleType, ISNULL(CAST(sh.DivisionID AS NVARCHAR(50)), '') AS Division
FROM pStyleHeader AS sh 
INNER JOIN pStyleSeasonYear AS ssy ON ssy.StyleID = sh.StyleID
LEFT JOIN uGroup AS g ON CAST(g.GroupID AS NVARCHAR(50)) = sh.OwnerGroup 
LEFT JOIN pStyleCategory AS sc ON sc.StyleCategoryId = sh.StyleCategory 
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
WHERE (sh.Active = 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09473', GetDate())
GO
