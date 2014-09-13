/****** Object:  StoredProcedure [dbo].[spx_LinePlanHistory_SELECT]    Script Date: 12/05/2012 16:51:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanHistory_SELECT]    Script Date: 12/05/2012 16:51:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LinePlanHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 
	
	SELECT a.LinePlanID,b.[Description],c.LinePlanTemplateName AS LinePlanType 
	FROM pLinePlanHistory a
	INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID
	LEFT OUTER JOIN pLinePlanTemplate c ON b.LinePlanTemplateID = c.LinePlanTemplateID
	WHERE a.TeamID = @TeamID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04557', GetDate())
GO