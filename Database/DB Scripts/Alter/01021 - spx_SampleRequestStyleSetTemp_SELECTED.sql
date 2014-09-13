ALTER PROCEDURE [dbo].[spx_SampleRequestStyleSetTemp_SELECTED]
(@StyleID uniqueidentifier,
@SampleRequestGroupID uniqueidentifier)

AS 

DECLARE @StyleSet nvarchar
DECLARE @Pc1 nvarchar(100)
DECLARE @Pc2 nvarchar(100)
DECLARE @Pc3 nvarchar(100)
DECLARE @Pc4 nvarchar(100)


SET @StyleSet = (SELECT StyleSet FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc1 = (SELECT PC1 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc2 = (SELECT PC2 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc3 = (SELECT PC3 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc4 = (SELECT PC4 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))

IF @PC1 IS Null OR @PC1 = '' SET @PC1 = '1st Set'
IF @PC2 IS Null OR @PC2 = '' SET @PC2 = '2nd Set'
IF @PC3 IS Null OR @PC3 = '' SET @PC3 = '3rd Set'
IF @PC4 IS Null OR @PC4 = '' SET @PC4 = '4th Set'

if (@StyleSet = '1') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	END
ELSE IF (@StyleSet = '2') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	END
ELSE IF (@StyleSet = '3') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet WHERE 3 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)		
	END
ELSE IF (@StyleSet = '4') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet WHERE 3 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)		
	UNION
	SELECT '4' AS ID, @Pc4 as StyleSet WHERE 4  IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)	
	END
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01021', GetDate())
GO