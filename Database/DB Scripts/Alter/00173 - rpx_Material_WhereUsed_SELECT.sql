
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT]
(
	@Season nvarchar(100)=NULL,
	@Year   nvarchar(100)=NULL,
	@ShowImage int = 0,
	@MaterialNo nvarchar(50)=NULL,
	@MaterialName nvarchar(200)=NULL,
	@MaterialType nvarchar(200)=NULL
)
AS 
DECLARE @SQLStrSelect varchar(4000)
DECLARE @SQLStrWhere varchar(4000)
DECLARE @SQLStrOrder varchar(4000)
DECLARE @MaterialTypeVal int

  
IF @ShowImage IS NULL or @ShowImage = ''  
   BEGIN  
     Set @ShowImage = 0 --Default, No image show  
   END  

--IF @ShowImage = 0 -- Do not show material images (Default)  
BEGIN  
SET @SQLStrSelect='SELECT
	pMaterial.B AS Season,
	pMaterial.D AS [Year],
	pMaterial.MaterialNo as MaterialsCode,	
	pMaterial.MaterialName,
 	pMaterial.Q AS VendorMill,
	pMaterial.R AS VendorMillRefNO, 
	pMaterial.G AS Content,
	pMaterial.H AS Construction,
	pMaterial.I AS YarnSizeCount,
	pMaterial.K AS Weight,
	CAST (pStyleMaterials.QTY AS Decimal(18,4)) AS Quantity,	
	pStyleMaterials.Placement,
	pComponentType.ComponentDescription AS [MaterialType],
	pStyleHeader.StyleNo,
	pStyleHeader.[Description],
	pStyleHeader.STYLENO AS StylesWhereUsed,
	pStyleHeader.SizeClass
FROM  pMaterial 
	INNER  JOIN	pStyleMaterials ON  pMaterial.MaterialID     = pStyleMaterials.MaterialID
	INNER  JOIN pComponentType	ON  pMaterial.MaterialType 	 = pComponentType.ComponentTypeID	
	INNER  JOIN pStyleHeader 	ON  pStyleMaterials.StyleID  = pStyleHeader.StyleID'
END
	
	SET @SQLStrWhere = ' WHERE 1=1'

IF(@Season IS NOT NULL AND @Season <> '')
 BEGIN
  SET @SQLStrWhere = @SQLStrWhere + ' AND pMaterial.B = ''' + @Season + ''''
 END
IF(@Year IS NOT NULL AND @Year <> '')
BEGIN
  SET @SQLStrWhere = @SQLStrWhere + ' AND pMaterial.D = ''' + @Year + ''''
 END
 
IF(@MaterialNo IS NOT NULL AND @MaterialNo <> '')
BEGIN
  SET @SQLStrWhere = @SQLStrWhere + ' AND pMaterial.MaterialNo = ''' + @MaterialNo + ''''
 END
 IF(@MaterialName IS NOT NULL AND @MaterialName <> '')
BEGIN
  SET @SQLStrWhere = @SQLStrWhere + ' AND pMaterial.MaterialName = ''' + @MaterialName + ''''
 END
  IF(@MaterialType IS NOT NULL AND @MaterialType <> '' )
BEGIN
  SET  @MaterialTypeVal = (SELECT ComponentTypeID FROM pComponentType WHERE ComponentDescription=@MaterialType)
  SET @SQLStrWhere = @SQLStrWhere + ' AND pMaterial.MaterialType = ''' + CAST(@MaterialTypeVal AS VARCHAR(4)) + ''''
 END

 


SET @SQLStrOrder = ' ORDER BY pMaterial.MaterialNo, pMaterial.MaterialName, pStyleHeader.StyleNo' 

EXEC(@SQLStrSelect+@SQLStrWhere+@SQLStrOrder)

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '161', GetDate())
GO