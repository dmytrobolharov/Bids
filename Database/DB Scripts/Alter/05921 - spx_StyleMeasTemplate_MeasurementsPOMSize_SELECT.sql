/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_MeasurementsPOMSize_SELECT]    Script Date: 06/26/2013 16:50:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_MeasurementsPOMSize_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_MeasurementsPOMSize_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasTemplate_MeasurementsPOMSize_SELECT]    Script Date: 06/26/2013 16:50:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasTemplate_MeasurementsPOMSize_SELECT]
( 
	@POMTemplateID uniqueidentifier
)
AS
BEGIN

	DECLARE @CustomID UNIQUEIDENTIFIER
	DECLARE @SizeRangeCode NVARCHAR(200)
	
	SELECT @CustomID = SizeRangeId, @SizeRangeCode = SizeRange FROM pGRMeasurementsPOMTemplate WHERE POMTempID = @POMTemplateID
	
	EXEC spx_PGRMeasurementsPOMSize_SELECT @CustomID, @SizeRangeCode

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05921', GetDate())
GO
