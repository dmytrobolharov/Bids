/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE]    Script Date: 05/23/2013 18:15:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE]    Script Date: 05/23/2013 18:15:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER,
	@RangePlan INT = 0
AS
BEGIN

	-- Clear fields in case of <s>emergency</s> there are no linked historical plans at all
	UPDATE pLineFolderBusiness SET LineFolderLastYearCh = NULL
	WHERE LineFolderID = @LineFolderID
	AND RangePlan = @RangePlan

	-- calculate average for all fields from Linked Historical Lists
	UPDATE pLineFolderBusiness SET LineFolderLastYearCh = t.LineFolderActualCh
	FROM pLineFolderBusiness lfb
	INNER JOIN (
		SELECT lfb.LineFolderDivisionID, lfb.LineFolderStyleTypeID, lfb.LineFolderStyleCategoryID, 
			lfb.LineFolderFinancialID, AVG(lfb.LineFolderActualCh) as LineFolderActualCh
		FROM pLineFolderBusiness mlfb
		INNER JOIN pLineFolderBusiness lfb ON mlfb.LineFolderDivisionID = lfb.LineFolderDivisionID 
			AND ISNULL(mlfb.LineFolderStyleTypeID, '0') = ISNULL(lfb.LineFolderStyleTypeID, '0')
			AND ISNULL(mlfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(lfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND lfb.LineFolderFinancialID = mlfb.LineFolderFinancialID		
			AND lfb.LineFolderID IN (SELECT LineFolderID FROM pLineFolderHistorical WHERE LineFolderMasterID = @LineFolderID)			
		WHERE mlfb.LineFolderID = @LineFolderID
		GROUP BY lfb.LineFolderDivisionID, lfb.LineFolderStyleTypeID, lfb.LineFolderStyleCategoryID, lfb.LineFolderFinancialID
	) t ON lfb.LineFolderDivisionID = t.LineFolderDivisionID 
		AND ISNULL(lfb.LineFolderStyleTypeID, '0') = ISNULL(t.LineFolderStyleTypeID, '0')
		AND ISNULL(lfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(t.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND lfb.LineFolderFinancialID = t.LineFolderFinancialID
	WHERE lfb.LineFolderID = @LineFolderID	
	AND lfb.RangePlan = @RangePlan

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05755', GetDate())
GO
