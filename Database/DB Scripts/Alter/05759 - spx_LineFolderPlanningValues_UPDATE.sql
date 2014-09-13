/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_UPDATE]    Script Date: 05/24/2013 11:39:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPlanningValues_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderPlanningValues_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER,
	@LineFolderDivisionID UNIQUEIDENTIFIER,
	@LineFolderStyleTypeID INT,
	@LineFolderStyleCategoryID UNIQUEIDENTIFIER,
	@LineFolderFinancialID UNIQUEIDENTIFIER,
	@LineFolderPlanningCh DECIMAL(18, 5),
	@RangePlan INT = 0
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
				AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000')
				AND LineFolderFinancialID = '10000000-0000-0000-0000-000000000000'
				AND RangePlan = @RangePlan)
				
		if @NoOfStyles < @LineFolderPlanningCh
			set @LineFolderPlanningCh = @NoOfStyles			
	end
	

	UPDATE pLineFolderBusiness SET LineFolderPlanningCh = @LineFolderPlanningCh
	WHERE LineFolderID = @LineFolderID
		AND LineFolderDivisionID = @LineFolderDivisionID
		AND LineFolderStyleTypeID = @LineFolderStyleTypeID
		AND ISNULL(LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND LineFolderFinancialID = @LineFolderFinancialID
		AND RangePlan = @RangePlan
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05759', GetDate())
GO
