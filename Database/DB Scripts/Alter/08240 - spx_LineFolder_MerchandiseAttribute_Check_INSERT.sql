/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]    Script Date: 07/07/2014 15:55:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]    Script Date: 07/07/2014 15:55:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_Check_INSERT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	DECLARE @PlanningID UNIQUEIDENTIFIER
	
	SELECT @SeasonYearID = SeasonYearID, @PlanningID = PlanningID 
	FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT)


	INSERT INTO #tmpAttributeList
	EXEC spx_LineFolder_MerchandiseAttribute_SELECT @LineFolderID
	
	INSERT INTO pLineFolderMerchandiseBusiness (PlanningID, LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
										PlanningDivisionID, PlanningDivision, PlanningStyleTypeID, PlanningStyleTypeDescription,
										PlanningStyleCategoryID, PlanningStyleCategory, SeasonYearID)
	SELECT @PlanningID, @LineFolderID, pf.PlanningFinancialID, pf.PlanningFinancialText, pf.PlanningFinancialSort, tal.DivisionID, tal.DivisionName,
			tal.StyleTypeID, tal.StyleTypeDescription, tal.StyleCategoryID, tal.StyleCategory, @SeasonYearID
	FROM pPlanningFinancial pf, #tmpAttributeList tal
	WHERE NOT EXISTS(
		SELECT * FROM pLineFolderMerchandiseBusiness pb
		WHERE ISNULL(pb.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
			ISNULL(pb.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
			ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000') AND
			pb.PlanningFinancialID = pf.PlanningFinancialID AND
			pb.SeasonYearID = @SeasonYearID AND
			pb.PlanningID = @PlanningID AND
			pb.LineFolderID = @LineFolderID
	)
	
	DELETE FROM pLineFolderMerchandiseBusiness WHERE 
		NOT EXISTS(
				SELECT * FROM #tmpAttributeList tal WHERE 
					ISNULL(pLineFolderMerchandiseBusiness.PlanningDivisionID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.DivisionID, '00000000-0000-0000-0000-000000000000') AND
					ISNULL(pLineFolderMerchandiseBusiness.PlanningStyleTypeID, '0') = ISNULL(tal.StyleTypeID, '0') AND
					ISNULL(pLineFolderMerchandiseBusiness.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(tal.StyleCategoryID, '00000000-0000-0000-0000-000000000000')
			)
		AND NOT (PlanningBrandID IS NOT NULL AND PlanningDivisionID IS NULL)
		AND SeasonYearID = @SeasonYearID
		AND pLineFolderMerchandiseBusiness.PlanningID = @PlanningID
		AND LineFolderID = @LineFolderID
		
	
	INSERT INTO pLineFolderMerchandiseBusiness (
		PlanningID, LineFolderID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort, 
		PlanningBrandID, PlanningBrand, SeasonYearID)
	SELECT @PlanningID, @LineFolderID, pf.PlanningFinancialID, pf.PlanningFinancialText, pf.PlanningFinancialSort, tal.CustomID, tal.Custom, @SeasonYearID
	FROM pPlanningFinancial pf, (SELECT DISTINCT b.CustomID, b.Custom FROM (SELECT DISTINCT DivisionID FROM #tmpAttributeList) d 
								 INNER JOIN vwx_Division_SEL vd ON d.DivisionID = vd.CustomID
								 INNER JOIN pBrand b ON vd.BrandID = b.CustomID) tal
	WHERE NOT EXISTS(
		SELECT * FROM pLineFolderMerchandiseBusiness pb
		WHERE pb.PlanningBrandID = tal.CustomID
			AND pb.PlanningDivisionID IS NULL
			AND pb.PlanningStyleTypeID IS NULL
			AND pb.PlanningStyleCategoryID IS NULL 
			AND pb.PlanningFinancialID = pf.PlanningFinancialID
			AND pb.SeasonYearID = @SeasonYearID
			AND pb.PlanningID = @PlanningID
			AND pb.LineFolderID = @LineFolderID
	)
	
	DELETE FROM pLineFolderMerchandiseBusiness 
	WHERE PlanningBrandID NOT IN (
			SELECT vd.BrandID FROM (SELECT DISTINCT DivisionID FROM #tmpAttributeList) d 
			INNER JOIN vwx_Division_SEL vd ON d.DivisionID = vd.CustomID)
		AND PlanningDivisionID IS NULL
		AND PlanningStyleTypeID IS NULL
		AND PlanningStyleCategoryID IS NULL
		AND SeasonYearID = @SeasonYearID
		AND PlanningID = @PlanningID
		AND LineFolderID = @LineFolderID
		
	UPDATE pLineFolderMerchandiseBusiness SET PlanningBrandID = b.CustomID, PlanningBrand = b.Custom
	FROM pLineFolderMerchandiseBusiness pb
	INNER JOIN vwx_Division_SEL d ON pb.PlanningDivisionID = d.CustomID
	INNER JOIN pBrand b ON d.BrandID = b.CustomID
	WHERE pb.PlanningID = @PlanningID AND LineFolderID = @LineFolderID 
		AND (pb.PlanningBrandID <> b.CustomID OR pb.PlanningBrandID IS NULL)
		AND pb.SeasonYearID = @SeasonYearID
		
	
	DELETE FROM pLineFolderMerchandiseBusiness WHERE PlanningID = @PlanningID AND LineFolderID = @LineFolderID 
		AND SeasonYearID = @SeasonYearID AND PlanningBrandID IS NULL
		

	DROP TABLE #tmpAttributeList
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08240', GetDate())
GO
