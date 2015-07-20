
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasAdHoc_SELECT]    Script Date: 09/20/2010 08:43:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleMeasAdHoc_SELECT] (
@AMLMeasHdrID nvarchar(50),
@POMCodeDefault nvarchar(10)
)
AS 



DECLARE @Len INT  
DECLARE @CodeLen INT
DECLARE @Res  INT 

IF @POMCodeDefault IS NULL 
	SET @POMCodeDefault = 'A'
IF LEN (@POMCodeDefault) = 0 
	SET @POMCodeDefault = 'A'

SET @Len  = 2 
SET @CodeLen   =  LEN ( @POMCodeDefault ) 

IF @CodeLen IS NULL
	SET @CodeLen =  0 


SET @Res = ( 
SELECT top 1 CAST ( SUBSTRING(Refcode , @CodeLen + 1  ,  len(Refcode) - @CodeLen )  AS INT )  AS Res
FROM pamlmeaspom
WHERE AMLMeasHdrID = @AMLMeasHdrID
--AND POM LIKE @POMCodeDefault + '%'
--AND LEN (POM)  =  @CodeLen + @Len 
and Refcode like @POMCodeDefault + '[0-9][0-9]' 
ORDER BY Res DESC 
) 

IF @Res  IS NULL 
	SET @Res  = 0 

SELECT  Count = @Res

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '419', GetDate())
GO

