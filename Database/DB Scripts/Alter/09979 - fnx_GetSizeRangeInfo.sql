IF OBJECT_ID(N'[dbo].[fnx_GetSizeRangeInfo]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetSizeRangeInfo]
GO

/************************************************************************************************
* Name  : fnx_GetSizeRangeInfo
* Author: Andrey Dmitrienko
* Creation date: 03/12/2015
* Description :	Returns the detailed information about the sizes of a given size range in a tabular form
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
*    01			
*
*************************************************************************************************/

CREATE FUNCTION fnx_GetSizeRangeInfo (@SizeRangeId UNIQUEIDENTIFIER)
RETURNS @SizeNames TABLE (    
  SizeRowId INT IDENTITY(0, 1),
  SizeRangeId UNIQUEIDENTIFIER,
  SizeRangeCode NVARCHAR(200),
  SizeId NVARCHAR(10),
  SizeName NVARCHAR(200),
  SizeDescription NVARCHAR(200),
  IsSampleSize BIT DEFAULT 0
)
AS
BEGIN

  INSERT INTO @SizeNames(SizeRangeId, SizeRangeCode, SizeId, SizeName) 
  SELECT CustomId, SizeRangeCode, SizeId, SizeName FROM 
   (SELECT * FROM pSizeRange WHERE CustomId = @SizeRangeId) p
   UNPIVOT
   (SizeName FOR SizeId IN (Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9,
							Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19,
							Size20, Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29,
							Size30, Size31, Size32, Size33, Size34, Size35, Size36, Size37, Size38, Size39,
							Size40, Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, Size49)) AS unpvt 
   WHERE SizeName IS NOT NULL AND SizeName <> ''

  IF @@ROWCOUNT != 0 
  BEGIN
	-- update selected sample size
	UPDATE @SizeNames
    SET IsSampleSize = d.IsSampleSize
      FROM (SELECT REPLACE(Id, 'Sel', 'Size') AS Id, IsSampleSize FROM 
             (SELECT * FROM pSizeRange WHERE CustomId = @SizeRangeId) p
             UNPIVOT
             (IsSampleSize FOR Id IN (Sel0, Sel1, Sel2, Sel3,Sel4, Sel5, Sel6, Sel7, Sel8, Sel9,
		 					          Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19,
		 					          Sel20, Sel21, Sel22, Sel23, Sel24, Sel25, Sel26, Sel27, Sel28, Sel29,
							          Sel30, Sel31, Sel32, Sel33, Sel34, Sel35, Sel36, Sel37, Sel38, Sel39,
							          Sel40, Sel41, Sel42, Sel43, Sel44, Sel45, Sel46, Sel47, Sel48, Sel49)) AS unpvt) d
      WHERE d.Id = SizeId
	-- update size descriptions
    UPDATE @SizeNames
    SET SizeDescription = d.SizeDescription
      FROM (SELECT REPLACE(Id, 'SizeDesc', 'Size') AS Id, SizeDescription FROM 
             (SELECT * FROM pSizeRange WHERE CustomId = @SizeRangeId) p
             UNPIVOT
             (SizeDescription FOR Id IN (SizeDesc0, SizeDesc1, SizeDesc2, SizeDesc3,SizeDesc4, SizeDesc5, SizeDesc6, SizeDesc7, SizeDesc8, SizeDesc9,
							             SizeDesc10, SizeDesc11, SizeDesc12, SizeDesc13, SizeDesc14, SizeDesc15, SizeDesc16, SizeDesc17, SizeDesc18, SizeDesc19,
							             SizeDesc20, SizeDesc21, SizeDesc22, SizeDesc23, SizeDesc24, SizeDesc25, SizeDesc26, SizeDesc27, SizeDesc28, SizeDesc29,
							             SizeDesc30, SizeDesc31, SizeDesc32, SizeDesc33, SizeDesc34, SizeDesc35, SizeDesc36, SizeDesc37, SizeDesc38, SizeDesc39,
							             SizeDesc40, SizeDesc41, SizeDesc42, SizeDesc43, SizeDesc44, SizeDesc45, SizeDesc46, SizeDesc47, SizeDesc48, SizeDesc49)) AS unpvt) d
      WHERE d.Id = SizeId AND d.SizeDescription != ''
  END

  RETURN
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09979', GetUTCDate())
GO
