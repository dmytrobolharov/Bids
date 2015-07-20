IF OBJECT_ID(N'[dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_Header_SELECT]
(
	@POMTempID nVARCHAR(50)
)
AS
BEGIN
	SELECT sc.Custom AS SizeClass
    FROM pGRMeasurementsPOMTemplate t
    LEFT JOIN pSizeClass sc ON sc.CustomID = t.SizeClassId
	WHERE t.POMTempID = @POMTempID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09510', GetDate())
GO
