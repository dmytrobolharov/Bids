ALTER PROCEDURE [dbo].[spx_SampleRequestSetItemTemp_SELECT]
(@StyleID uniqueidentifier)

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

IF @Pc1 IS NULL OR @Pc1 = '' SET @Pc1 = '1st Set'
IF @Pc2 IS NULL OR @Pc2 = '' SET @Pc2 = '2nd Set'
IF @Pc3 IS NULL OR @Pc3 = '' SET @Pc3 = '3rd Set'
IF @Pc4 IS NULL OR @Pc4 = '' SET @Pc4 = '4th Set'


if (@StyleSet = '1') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet 
	END
ELSE IF (@StyleSet = '2') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet 
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet 
	END
ELSE IF (@StyleSet = '3') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet 
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet 
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet 	
	END
ELSE IF (@StyleSet = '4') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet 
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet 
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet 	
	UNION
	SELECT '4' AS ID, @Pc4 as StyleSet 
	END
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01020', GetDate())
GO