/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]    Script Date: 05/23/2013 16:30:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]    Script Date: 05/23/2013 16:30:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]
	@LineFolderID UNIQUEIDENTIFIER,
	@RangePlan INT = 0
AS
BEGIN

	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT)


	INSERT INTO #tmpAttributeList
	EXEC spx_LineFolder_LinePlanningAttribute_SELECT @LineFolderID
	
	IF @RangePlan = 0 -- For Line Planning page
	BEGIN
		INSERT INTO pLineFolderBusiness (LineFolderID, LineFolderFinancialID, LineFolderFinancialText, LineFolderFinancialSort, 
											LineFolderDivisionID, LineFolderDivision, LineFolderStyleTypeID, LineFolderStyleTypeDescription,
											LineFolderStyleCategoryID, LineFolderStyleCategory, RangePlan)
		SELECT @LineFolderID, lff.LineFolderFinancialID, lff.LineFolderFinancialText, lff.LineFolderFinancialSort, tal.DivisionID, tal.DivisionName,
				tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory, 0
		FROM pLineFolderFinancial lff, #tmpAttributeList tal
		WHERE NOT EXISTS(
			SELECT * FROM pLineFolderBusiness lfb
			WHERE ISNULL(lfb.LineFolderDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
				ISNULL(lfb.LineFolderStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
				ISNULL(lfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
				lfb.LineFolderFinancialID = lff.LineFolderFinancialID AND
				lfb.LineFolderID = @LineFolderID AND RangePlan = 0
		) AND lff.RangePlan = 0
	END
	ELSE -- For Range Planning page
	BEGIN
		INSERT INTO pLineFolderBusiness (LineFolderID, LineFolderFinancialID, LineFolderFinancialText, LineFolderFinancialSort, 
											LineFolderDivisionID, LineFolderDivision, LineFolderStyleTypeID, LineFolderStyleTypeDescription,
											LineFolderStyleCategoryID, LineFolderStyleCategory, RangePlan)
		SELECT @LineFolderID, lff.LineFolderFinancialID, lff.LineFolderFinancialText, lff.LineFolderFinancialSort, tal.DivisionID, tal.DivisionName,
				tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory, 1
		FROM pLineFolderFinancial lff, #tmpAttributeList tal
		WHERE NOT EXISTS(
			SELECT * FROM pLineFolderBusiness lfb
			WHERE ISNULL(lfb.LineFolderDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
				ISNULL(lfb.LineFolderStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
				ISNULL(lfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
				lfb.LineFolderFinancialID = lff.LineFolderFinancialID AND
				lfb.LineFolderID = @LineFolderID AND RangePlan = 1
		)
	END
	
	DELETE FROM pLineFolderBusiness WHERE 
		NOT EXISTS(
				SELECT * FROM #tmpAttributeList tal WHERE 
					ISNULL(pLineFolderBusiness.LineFolderDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
					ISNULL(pLineFolderBusiness.LineFolderStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
					ISNULL(pLineFolderBusiness.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000')
			)
		AND pLineFolderBusiness.LineFolderID = @LineFolderID
		AND RangePlan = @RangePlan
		

	DROP TABLE #tmpAttributeList
	
END





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05750', GetDate())
GO
