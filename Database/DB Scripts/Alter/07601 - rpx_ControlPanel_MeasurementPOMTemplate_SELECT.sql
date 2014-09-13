IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_ControlPanel_MeasurementPOMTemplate_SELECT]
(
	@POMTempID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @IsMetric INT = (SELECT Metric FROM pGRMeasurementsPOMTemplateGroup WHERE POMTempID=@POMTempID)

	;WITH PomItems AS (
	SELECT Critical, POMCode, POMDesc, TolPlus, TolMinus, Conv, NonWashTolPlus, NonWashTolMinus, POMSort, REPLACE(UPPER(AlternatesDesc), 'NONE', '') AS AlternatesDesc, CAST(REPLACE(Incr, 'Incr', '') AS INT) AS Incr, ColumnValue
	FROM pGRMeasurementsPOMTemplateItem
	UNPIVOT (ColumnValue FOR Incr IN(Incr0,Incr1,Incr2,Incr3,Incr4,Incr5,Incr6,Incr7,Incr8,Incr9,Incr10,Incr11,Incr12,Incr13,Incr14,Incr15,Incr16,Incr17,Incr18,Incr19,Incr20,Incr21,Incr22,Incr23,Incr24,Incr25,Incr26,Incr27,Incr28,Incr29,Incr30,Incr31,Incr32,Incr33,Incr34,Incr35,Incr36,Incr37,Incr38,Incr39,Incr40,Incr41,Incr42,Incr43,Incr44,Incr45,Incr46,Incr47,Incr48,Incr49)) upvt
	WHERE POMTempID = @POMTempID)
	, Pom AS (
	SELECT SizeClass + ' (' + SizeRange + ')' AS SizeClassRangeStr, CAST(REPLACE(Size, 'Size', '') AS INT) AS Size, ColumnName
	FROM pGRMeasurementsPOMTemplate
	UNPIVOT (ColumnName FOR Size IN (Size0,Size1,Size2,Size3,Size4,Size5,Size6,Size7,Size8,Size9,Size10,Size11,Size12,Size13,Size14,Size15,Size16,Size17,Size18,Size19,Size20,Size21,Size22,Size23,Size24,Size25,Size26,Size27,Size28,Size29,Size30,Size31,Size32,Size33,Size34,Size35,Size36,Size37,Size38,Size39,Size40,Size41,Size42,Size43,Size44,Size45,Size46,Size47,Size48,Size49)) upvt
	WHERE POMTempID = @POMTempID)
	SELECT Critical, POMCode, POMDesc
		, CASE WHEN @IsMetric = 0 THEN ISNULL(dbo.fnx_Num2Frac_KeepNegative(TolPlus),0) ELSE TolPlus END AS TolPlus
		, CASE WHEN @IsMetric = 0 THEN ISNULL(dbo.fnx_Num2Frac_KeepNegative(TolMinus),0) ELSE TolMinus END AS TolMinus
		, CASE WHEN @IsMetric = 0 THEN ISNULL(dbo.fnx_Num2Frac_KeepNegative(Conv),0) ELSE Conv END AS Conv
		, CASE WHEN @IsMetric = 0 THEN ISNULL(dbo.fnx_Num2Frac_KeepNegative(NonWashTolPlus),0) ELSE NonWashTolPlus END AS NonWashTolPlus
		, CASE WHEN @IsMetric = 0 THEN ISNULL(dbo.fnx_Num2Frac_KeepNegative(NonWashTolMinus),0) ELSE NonWashTolMinus END AS NonWashTolMinus
		, ColumnName, ColumnValue, SizeClassRangeStr, POMSort, AlternatesDesc
	FROM Pom INNER JOIN PomItems ON Pom.Size = PomItems.Incr
	ORDER BY PomItems.POMSort, PomItems.POMCode
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07601', GetDate())
GO
