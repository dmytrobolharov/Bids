IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Material_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Material_SELECT]
GO

CREATE    procedure [dbo].[dpx_Material_SELECT]
	@Season nvarchar(50) = null,
	@Year nvarchar(50) = null,
	@MaterialType nvarchar(50) = null,	
	@MaterialNo nvarchar(50) = null,
	@Status  nvarchar(100) = null,
	@ShowImage   int = 0,
	@SortBy int = null
as


IF @Season IS NULL or @Season = ''
	BEGIN
		Set @Season = 'ALL'
	END

IF @Year IS NULL or @Year = ''
	BEGIN
		Set @Year = 'ALL'
	END

IF @MaterialType IS NULL or @MaterialType = ''
	BEGIN
		Set @MaterialType = 'ALL'
	END

IF @MaterialNo IS NULL or @MaterialNo = ''
	BEGIN
		Set @MaterialNo = 'ALL'
	END

IF @ShowImage IS NULL or @ShowImage = ''
  	BEGIN
   		Set @ShowImage = 0 --Default, No image show
  	END

IF @Status IS NULL or @Status = ''
	BEGIN
		Set @Status = 'ALL'
	END



if @SortBy = 1   -- Sort by Material (Default)
   BEGIN
		IF @ShowImage = 0 -- Do not show material images (Default)
			BEGIN
				select a.MaterialNo, 
					a.MaterialName, 
					'' as FilePath,
					a.G as Content, 
					a.K as Weight,
					a.I as YarnSize,
					a.P as COO,
					a.Q as VendorMill,
					a.R as VendorMillRefNo,
					a.VendorProductionMin as Minimum,
					a.VendorProductionLeadTime as LeadTime,
					a.VendorPrice,
					a.VolumePrice as NegtdPrice,
					s.Custom as Status,
					a.MDate as lastUpdateDate,
					b.ComponentDescription,
					b.ComponentTypeID
				from pMaterial a WITH (NOLOCK)
					INNER JOIN pComponentType b on a.MaterialType = b.ComponentTypeID
					LEFT OUTER JOIN xCustom8 s ON a.S = s.CustomKey  -- Status table
				where ((a.B = @Season) OR (@Season = 'ALL'))
					and ((a.D = @Year) OR (@Year = 'ALL'))
					--8/11/2008  and a.MaterialType in (10,11)
					AND ((LTRIM(RTRIM(b.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = 'ALL'))
					AND ((LTRIM(RTRIM(a.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = 'ALL'))
					AND ((LTRIM(RTRIM(a.S)) = LTRIM(RTRIM(@Status))) OR (@Status = 'ALL'))
				order by ComponentDescription, a.MaterialNo
			END  
		 ELSE  -- Show material images
			BEGIN
				select a.MaterialNo, 
					a.MaterialName, 
					(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)	--Comment #01
					FROM	pMaterial LEFT OUTER JOIN hImage ON
						pMaterial.MaterialImageID = hImage.ImageID AND
						pMaterial.MaterialImageVersion = hImage.Version
					WHERE pMaterial.MaterialID = a.MaterialID
					) AS FilePath,
					a.G as Content, 
					a.K as Weight,
					a.I as YarnSize,
					a.P as COO,
					a.Q as VendorMill,
					a.R as VendorMillRefNo,
					a.VendorProductionMin as Minimum,
					a.VendorProductionLeadTime as LeadTime,
					a.VendorPrice,
					a.VolumePrice as NegtdPrice,
					s.Custom as Status,
					a.MDate as lastUpdateDate,
					b.ComponentDescription,
					b.ComponentTypeID
				from pMaterial a WITH (NOLOCK)
					INNER JOIN pComponentType b on a.MaterialType = b.ComponentTypeID
					LEFT OUTER JOIN xCustom8 s ON a.S = s.CustomKey  -- Status table
				where ((a.B = @Season) OR (@Season = 'ALL'))
					and ((a.D = @Year) OR (@Year = 'ALL'))
					--8/11/2008  and a.MaterialType in (10,11)
					AND ((LTRIM(RTRIM(b.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = 'ALL'))
					AND ((LTRIM(RTRIM(a.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = 'ALL'))
					AND ((LTRIM(RTRIM(a.S)) = LTRIM(RTRIM(@Status))) OR (@Status = 'ALL'))
				order by ComponentDescription, a.MaterialNo
			END
   END 
ELSE -- sort by Vendor/Mill
	BEGIN
		IF @ShowImage = 0 -- Do not show material images (Default)
		   BEGIN
				select a.MaterialNo, 
					a.MaterialName, 
					'' as FilePath,
					a.G as Content, 
					a.K as Weight,
					a.I as YarnSize,
					a.P as COO,
					a.Q as VendorMill,
					a.R as VendorMillRefNo,
					a.VendorProductionMin as Minimum,
					a.VendorProductionLeadTime as LeadTime,
					a.VendorPrice,
					a.VolumePrice as NegtdPrice,
					s.Custom as Status,
					a.MDate as lastUpdateDate,
					b.ComponentDescription,
					b.ComponentTypeID
				from pMaterial a WITH (NOLOCK)
					INNER join pComponentType b on a.MaterialType = b.ComponentTypeID
					LEFT OUTER JOIN xCustom8 s ON a.S = s.CustomKey  -- Status table
				where ((a.B = @Season) OR (@Season = 'ALL'))
					and ((a.D = @Year) OR (@Year = 'ALL'))
					--8/11/2008  and a.MaterialType in (10,11)
					AND ((LTRIM(RTRIM(b.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = 'ALL'))
					AND ((LTRIM(RTRIM(a.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = 'ALL'))
					AND ((LTRIM(RTRIM(a.S)) = LTRIM(RTRIM(@Status))) OR (@Status = 'ALL'))
				order by a.Q, ComponentDescription, a.MaterialNo

			END
		ELSE  -- Show material images
			BEGIN
				select a.MaterialNo, 
					a.MaterialName, 
					(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)	--Comment #01
					FROM	pMaterial LEFT OUTER JOIN hImage ON
						pMaterial.MaterialImageID = hImage.ImageID AND
						pMaterial.MaterialImageVersion = hImage.Version
					WHERE pMaterial.MaterialID = a.MaterialID
					) AS FilePath,
					a.G as Content, 
					a.K as Weight,
					a.I as YarnSize,
					a.P as COO,
					a.Q as VendorMill,
					a.R as VendorMillRefNo,
					a.VendorProductionMin as Minimum,
					a.VendorProductionLeadTime as LeadTime,
					a.VendorPrice,
					a.VolumePrice as NegtdPrice,
					s.Custom as Status,
					a.MDate as lastUpdateDate,
					b.ComponentDescription,
					b.ComponentTypeID
				from pMaterial a WITH (NOLOCK)
					INNER join pComponentType b on a.MaterialType = b.ComponentTypeID
					LEFT OUTER JOIN xCustom8 s ON a.S = s.CustomKey  -- Status table
				where ((a.B = @Season) OR (@Season = 'ALL'))
					and ((a.D = @Year) OR (@Year = 'ALL'))
					--8/11/2008  and a.MaterialType in (10,11)
					AND ((LTRIM(RTRIM(b.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = 'ALL'))
					AND ((LTRIM(RTRIM(a.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = 'ALL'))
					AND ((LTRIM(RTRIM(a.S)) = LTRIM(RTRIM(@Status))) OR (@Status = 'ALL'))
				order by a.Q, ComponentDescription, a.MaterialNo

			END
	END



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10086', GetUTCDate())
GO