IF OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]
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
    DECLARE @StyleDevelopmentID uniqueidentifier
	DECLARE @Variation nvarchar(10)

	SELECT @StyleDevelopmentID = StyleDevelopmentID, @Variation = Variation 
	FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
    
	SELECT @SizeClass = COALESCE(sc.Custom, sh.SizeClass), 
	       @SizeRange = COALESCE(sr.SizeRangeCode, sh.SizeRange) 
	FROM pStyleHeader sh
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId 
	WHERE sh.StyleID = @StyleID
    
    SELECT @POMTempGroupID = POMTempGroupID FROM pGRMeasurementsPOMTemplate temp 
    INNER JOIN pAMLMeasHdr header ON header.CompanyId = temp.POMTempID
    WHERE header.AMLMeasHdrId = @AMLMeasHdrID
    
    SELECT DISTINCT SizeClass FROM pGRMeasurementsPOMTemplate
    WHERE POMTempGroupID = @POMTempGroupID AND SizeClass <> @SizeClass AND SizeClass NOT IN 
    (SELECT COALESCE(sc.Custom, sh.SizeClass) 
	 FROM  pStyleHeader sh WITH (NOLOCK) 
	 INNER JOIN pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = pStyleDevelopmentItem.StyleID
	 LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
     WHERE (pStyleDevelopmentItem.Variation = @Variation) AND (pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID))
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09805', GetDate())
GO
