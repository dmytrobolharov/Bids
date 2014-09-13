ALTER PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT]
(
	@Season nvarchar(100)=NULL,
	@Year   nvarchar(100)=NULL,
	@ShowImage nvarchar(50)=NULL,
	@MaterialNo nvarchar(50)=NULL,
	@MaterialType nvarchar(200)=NULL,
	@MaterialName nvarchar(200)=NULL
)

AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @ImageFolder	 	varchar(200)


/************/
/*Logic.	*/
/************/
/*Set the variable value for getting images.*/
SET @ImageFolder = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImagePath')


/*Prep parameters for the WHERE conditions.*/
IF(@Season IS NULL OR @Season = '')
	BEGIN
		SET @Season = '(ALL)'
	END


IF(@Year IS NULL OR @Year = '')
	BEGIN
		SET @Year = '(ALL)'
	END


IF(@ShowImage IS NULL OR @ShowImage = '')
	BEGIN
		SET @ShowImage = 'No'
	END


IF(@MaterialNo IS NULL OR @MaterialNo = '')
	BEGIN
		SET	@MaterialNo = '(ALL)'
	END


IF(@MaterialType IS NULL OR @MaterialType = '')
	BEGIN
		SET @MaterialType = '(ALL)'
	END
	
	
IF(@MaterialName IS NULL OR @MaterialName = '')
	BEGIN
		SET @MaterialName = '(ALL)'
	END


/*SELECT statements, with or without image.*/
IF(@ShowImage = 'Yes')
	BEGIN
		SELECT
			m.B AS Season,
			m.D AS [Year],
			(SELECT TOP 1 @ImageFolder + '/{' + CAST(hImage.ImageID AS varchar(255)) +
						'}/Version/600/{' + CAST(hImage.ImageHistoryID AS varchar(255)) + '}.png' 
					FROM	pStyleHeader LEFT OUTER JOIN hImage ON
						pStyleHeader.DesignSketchID = hImage.ImageID AND
						pStyleHeader.DesignSketchVersion = hImage.Version
					WHERE pStyleHeader.StyleID = s.StyleID
			) AS FilePath,
			m.MaterialNo as MaterialsCode,	
			m.MaterialName,
 			m.Q AS VendorMill,
			m.R AS VendorMillRefNO, 
			m.G AS Content,
			m.H AS Construction,
			m.I AS YarnSizeCount,
			m.K AS Weight,
			m.UOM AS Uom,
			m.F	AS Status,
			CAST (s.QTY AS Decimal(18,4)) AS Quantity,	
			s.Placement,
			t.ComponentDescription AS [MaterialType],
			h.StyleNo,
			h.[Description],
			h.STYLENO AS StylesWhereUsed,
			h.SizeClass,
			1 as GrandTotalGroup --- only to get the entire row group for grand total of the record count
		FROM  pMaterial m WITH (NOLOCK)
			INNER JOIN	pStyleMaterials  s WITH (NOLOCK) ON  m.MaterialID = s.MaterialID
			LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON  m.MaterialType = t.ComponentTypeID	
			LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON  s.StyleID = h.StyleID
		WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' 
			 AND ((m.B = @Season) OR (@Season = '(ALL)'))
			 AND ((m.D = @Year) OR (@Year = '(ALL)'))
			 AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)'))
			 AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)'))
			 AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
		ORDER BY t.ComponentDescription, m.MaterialNo, m.MaterialName, h.StyleNo 
	END
ELSE
	BEGIN
		SELECT
			m.B AS Season,
			m.D AS [Year],
			'' AS FilePath,
			m.MaterialNo as MaterialsCode,	
			m.MaterialName,
 			m.Q AS VendorMill,
			m.R AS VendorMillRefNO, 
			m.G AS Content,
			m.H AS Construction,
			m.I AS YarnSizeCount,
			m.K AS Weight,
			m.UOM AS Uom,
			m.F	AS Status,
			CAST (s.QTY AS Decimal(18,4)) AS Quantity,	
			s.Placement,
			t.ComponentDescription AS [MaterialType],
			h.StyleNo,
			h.[Description],
			h.STYLENO AS StylesWhereUsed,
			h.SizeClass,
			1 as GrandTotalGroup --- only to get the entire row group for grand total of the record count
		FROM  pMaterial m WITH (NOLOCK)
			INNER JOIN	pStyleMaterials  s WITH (NOLOCK) ON  m.MaterialID = s.MaterialID
			LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON  m.MaterialType = t.ComponentTypeID	
			LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON  s.StyleID = h.StyleID
		WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' 
			 AND ((m.B = @Season) OR (@Season = '(ALL)'))
			 AND ((m.D = @Year) OR (@Year = '(ALL)'))
			 AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)'))
			 AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)'))
			 AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
		ORDER BY t.ComponentDescription, m.MaterialNo, m.MaterialName, h.StyleNo 
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '456', GetDate())
GO