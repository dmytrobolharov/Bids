/****** Object:  View [dbo].[vwx_TemplateCalendar_ByDivision_SELECT]    Script Date: 08/06/2014 12:40:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TemplateCalendar_ByDivision_SELECT]'))
DROP VIEW [dbo].[vwx_TemplateCalendar_ByDivision_SELECT]
GO

/****** Object:  View [dbo].[vwx_TemplateCalendar_ByDivision_SELECT]    Script Date: 08/06/2014 12:40:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_TemplateCalendar_ByDivision_SELECT]
AS
SELECT cal.TACalTemplateID, cal.TACalTemplateName, div.DivisionID, cal.SeasonYearId
FROM pTACalTemplate cal 
INNER JOIN pTACalTemplateDivision div ON div.TACalTemplateID = cal.TACalTemplateId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08590', GetDate())
GO
