IF OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClassesRanges_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@AMLMeasHdrID UNIQUEIDENTIFIER,
	@SizeClassID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
    SELECT tv.POMTempID, tv.SizeClassId, tv.SizeClass, tv.SizeRangeId, tv.SizeRange, 
	       tv.ClassRangeId, tv.ClassRange 
	FROM pAMLMeasHdr mh 
	INNER JOIN pGRMeasurementsPOMTemplate t ON t.POMTempID = mh.CompanyId
	INNER JOIN vwx_GRMeasurementsPOMTemplate_SELECT tv ON tv.POMTempGroupID = t.POMTempGroupID
    WHERE mh.AMLMeasHdrId = @AMLMeasHdrID AND tv.SizeClassId = @SizeClassId
    
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09989', GetUTCDate())
GO
