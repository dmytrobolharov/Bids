SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_pGRSizeRangeDetailLibraryEmpty_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_pGRSizeRangeDetailLibraryEmpty_DELETE
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRangeDetailLibraryEmpty_DELETE]
(@SizeRangeID uniqueidentifier)
AS 

DECLARE @Count INT
SELECT @Count = MAX(SizeCount) FROM pGRSizeRangeDetail
WHERE SizeRangeID =@SizeRangeID AND ClassRangeId='00000000-0000-0000-0000-000000000000' 
AND SizeName<>'' 


DELETE FROM dbo.pGRSizeRangeDetail WHERE SizeRangeID=@SizeRangeID AND ClassRangeId='00000000-0000-0000-0000-000000000000' AND SizeCount > @Count
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01173', GetDate())
GO

