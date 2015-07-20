/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]    Script Date: 06/14/2013 12:17:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]    Script Date: 06/14/2013 12:17:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@AMLMeasHdrID UNIQUEIDENTIFIER,
	@SizeClass NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    DECLARE @POMTempGroupID UNIQUEIDENTIFIER
    
    SELECT @POMTempGroupID = POMTempGroupID FROM pGRMeasurementsPOMTemplate temp 
    INNER JOIN pAMLMeasHdr header ON header.CompanyId = temp.POMTempID
    WHERE header.AMLMeasHdrId = @AMLMeasHdrID
    
    SELECT POMTempID, SizeClass, SizeRange, ClassRange FROM pGRMeasurementsPOMTemplate
    WHERE POMTempGroupID = @POMTempGroupID AND SizeClass = @SizeClass
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05924', GetDate())
GO
