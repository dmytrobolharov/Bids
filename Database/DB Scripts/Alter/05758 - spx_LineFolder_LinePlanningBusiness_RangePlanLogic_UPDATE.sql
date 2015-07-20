/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_RangePlanLogic_UPDATE]    Script Date: 05/23/2013 18:17:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_RangePlanLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_RangePlanLogic_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_RangePlanLogic_UPDATE]    Script Date: 05/23/2013 18:17:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_RangePlanLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	EXEC spx_LineFolder_LinePlanningBusiness_RangePlanningLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_LinePlanningBusiness_DIPLogic_UPDATE @LineFolderID, 1
	
	EXEC spx_LineFolder_LinePlanningBusiness_ActualLogic_UPDATE @LineFolderID, 1
	
	EXEC spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE @LineFolderID, 1
	
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05758', GetDate())
GO
