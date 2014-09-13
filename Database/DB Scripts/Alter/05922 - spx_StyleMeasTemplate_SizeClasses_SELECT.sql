/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]    Script Date: 06/14/2013 11:59:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]    Script Date: 06/14/2013 11:59:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@AMLMeasHdrID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @SizeRange nvarchar(200)
    DECLARE @SizeClass nvarchar(200)
    DECLARE @POMTempGroupID UNIQUEIDENTIFIER
    
    SELECT @SizeClass = SizeClass, @SizeRange = SizeRange FROM pStyleHeader WHERE StyleID=@StyleID
    
    SELECT @POMTempGroupID = POMTempGroupID FROM pGRMeasurementsPOMTemplate temp 
    INNER JOIN pAMLMeasHdr header ON header.CompanyId = temp.POMTempID
    WHERE header.AMLMeasHdrId = @AMLMeasHdrID
    
    SELECT DISTINCT SizeClass FROM pGRMeasurementsPOMTemplate
    WHERE POMTempGroupID = @POMTempGroupID AND SizeClass <> @SizeClass
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05922', GetDate())
GO
