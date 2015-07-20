/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_UPDATE]    Script Date: 03/20/2013 18:45:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPlanningValues_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER,
	@LineFolderDivisionID UNIQUEIDENTIFIER,
	@LineFolderStyleTypeID INT,
	@LineFolderStyleCategoryID UNIQUEIDENTIFIER,
	@LineFolderFinancialID UNIQUEIDENTIFIER,
	@LineFolderPlanningCh DECIMAL
AS
BEGIN

	UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @LineFolderPlanningCh
	WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @LineFolderDivisionID
		AND LineFolderStyleTypeID = @LineFolderStyleTypeID
		AND LineFolderStyleCategoryID = @LineFolderStyleCategoryID
		AND LineFolderFinancialID = @LineFolderFinancialID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05366', GetDate())
GO
