/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_Logic_UPDATE]    Script Date: 03/22/2013 13:29:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_Logic_UPDATE]    Script Date: 03/22/2013 13:29:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_Logic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	EXEC spx_LineFolder_LinePlanningBusiness_PlanningLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE @LineFolderID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05389', GetDate())
GO
