/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_UPDATE]    Script Date: 03/22/2013 16:59:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPlanningValues_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER,
	@LineFolderDivisionID UNIQUEIDENTIFIER,
	@LineFolderStyleTypeID INT,
	@LineFolderStyleCategoryID UNIQUEIDENTIFIER,
	@LineFolderFinancialID UNIQUEIDENTIFIER,
	@LineFolderPlanningCh DECIMAL(18, 5)
AS
BEGIN

	-- carry over styles shouldn't be greater then No of Styles
	-- it's crucial for No Of Styles to be updated before carry over styles
	if @LineFolderFinancialID = '10000000-0000-0000-0000-000000000001'
	begin
		declare @NoOfStyles DECIMAL(18, 5) = 
		   (SELECT LineFolderPlanningCh FROM pLineFolderBusiness 
			WHERE LineFolderID = @LineFolderID
				AND LineFolderDivisionID = @LineFolderDivisionID
				AND LineFolderStyleTypeID = @LineFolderStyleTypeID
				AND LineFolderStyleCategoryID = @LineFolderStyleCategoryID
				AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000')
				
		if @NoOfStyles < @LineFolderPlanningCh
			set @LineFolderPlanningCh = @NoOfStyles			
	end
	

	UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @LineFolderPlanningCh
	WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @LineFolderDivisionID
		AND LineFolderStyleTypeID = @LineFolderStyleTypeID
		AND LineFolderStyleCategoryID = @LineFolderStyleCategoryID
		AND LineFolderFinancialID = @LineFolderFinancialID
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05394', GetDate())
GO
