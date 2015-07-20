IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpecSizeIndex_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSpecSizeIndex_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleSpecSizeIndex_SELECT]
(
@StyleID uniqueidentifier
)
AS 

Declare @SampleSizePosition int

BEGIN
	SELECT  @SampleSizePosition = (CASE 
        WHEN Sel0 = 1 THEN 0
        WHEN Sel1 = 1 THEN 1 
        WHEN Sel2 = 1 THEN 2 
        WHEN Sel3 = 1 THEN 3 
        WHEN Sel4 = 1 THEN 4 
        WHEN Sel5 = 1 THEN 5 
        WHEN Sel6 = 1 THEN 6 
        WHEN Sel7 = 1 THEN 7 
        WHEN Sel8 = 1 THEN 8 
        WHEN Sel9 = 1 THEN 9 
        WHEN Sel10 = 1 THEN 10 
        WHEN Sel11 = 1 THEN 11 
        WHEN Sel12 = 1 THEN 12 
        WHEN Sel13 = 1 THEN 13 
        WHEN Sel14 = 1 THEN 14 
        WHEN Sel15 = 1 THEN 15 
        WHEN Sel16 = 1 THEN 16 
        WHEN Sel17 = 1 THEN 17 
        WHEN Sel18 = 1 THEN 18 
        WHEN Sel19 = 1 THEN 19 
        END) FROM pStyleSpecSize WITH (NOLOCK)
	WHERE (StyleID = @StyleID) 
END

BEGIN

	SELECT ISNULL(@SampleSizePosition,-1)

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '071', GetDate())

