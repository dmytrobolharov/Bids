/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]    Script Date: 03/21/2013 14:52:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]    Script Date: 03/21/2013 14:52:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Check_INSERT]
	@LineFolderID UNIQUEIDENTIFIER
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

	INSERT INTO pLineFolderBusiness (LineFolderID, LineFolderFinancialID, LineFolderFinancialText, LineFolderFinancialSort, 
										LineFolderDivisionID, LineFolderDivision, LineFolderStyleTypeID, LineFolderStyleTypeDescription,
										LineFolderStyleCategoryID, LineFolderStyleCategory)
	SELECT @LineFolderID, lff.LineFolderFinancialID, lff.LineFolderFinancialText, lff.LineFolderFinancialSort, tal.DivisionID, tal.DivisionName,
			tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory
	FROM pLineFolderFinancial lff, #tmpAttributeList tal
	WHERE NOT EXISTS(
		SELECT * FROM pLineFolderBusiness lfb
		WHERE ISNULL(lfb.LineFolderDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
			ISNULL(lfb.LineFolderStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
			ISNULL(lfb.LineFolderStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
			lfb.LineFolderFinancialID = lff.LineFolderFinancialID AND
			lfb.LineFolderID = @LineFolderID
	)

	DROP TABLE #tmpAttributeList
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05372', GetDate())
GO
