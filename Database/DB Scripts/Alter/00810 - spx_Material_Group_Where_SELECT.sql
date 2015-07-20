IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Group_Where_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Material_Group_Where_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Material_Group_Where_SELECT](
	@TeamID UNIQUEIDENTIFIER, 
	@MaterialCoreID UNIQUEIDENTIFIER,
	@Query NVARCHAR(4000)
)
AS


IF @Query IS NULL 
BEGIN 
	
	SELECT  a.StyleSeasonYearID , a.StyleSeason, a.StyleYear, b.StyleID, b.StyleNo, b.SizeClass, b.SizeRange, b.Description,
	b.DesignSketchID, b.DesignSketchVersion
	FROM ( 	

		SELECT  StyleID
		FROM dbo.pMaterialCoreItem a
			INNER JOIN dbo.pStyleMaterials b ON a.MaterialCoreItemID =  b.MaterialCoreItemID
		WHERE a.MaterialCoreID = @MaterialCoreID

	UNION 

		SELECT  b.StyleID
		FROM dbo.pMaterialCoreItem a
			INNER JOIN dbo.pStyleMaterials b ON b.StyleMaterialLinkID = a.MaterialCoreItemID 
		WHERE a.MaterialCoreID = @MaterialCoreID
	) AS FOO 
		INNER JOIN pStyleHeader b On foo.StyleID = b.StyleID
		INNER JOIN pStyleSeasonYear a ON a.StyleID = b.StyleID
	ORDER BY b.Styleno, a.StyleSeason, a.StyleYear
	
	
END 
ELSE
BEGIN

	DECLARE @SQL NVARCHAR(4000)
	DECLARE @SQLTmp NVARCHAR(4000)
	SET @SQLTmp  = UPPER(@Query)
	
	IF CHARINDEX ( ' WHERE ' , @SQLTmp  )  > 0  
		SET @SQLTmp = @Query + ' AND MaterialCoreID = ''' + CAST(@MaterialCoreID AS NVARCHAR(50)) + ''' '
	ELSE
		SET @SQLTmp = @Query + ' WHERE MaterialCoreID = ''' + CAST(@MaterialCoreID AS NVARCHAR(50)) + ''' '
	
	print @SQLTmp 
	EXEC sp_executesql @SQLTmp 
	
END 



GO