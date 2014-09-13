SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_pGRSizeRangeDetailEmpty_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_pGRSizeRangeDetailEmpty_DELETE
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRangeDetailEmpty_DELETE]
(@ClassRangeId uniqueidentifier)
AS 

DECLARE @Count INT
SELECT @Count = MAX(SizeCount) FROM pGRSizeRangeDetail
WHERE ClassRangeId =@ClassRangeId AND SizeName<>'' 


DELETE FROM dbo.pGRSizeRangeDetail WHERE ClassRangeId=@ClassRangeId AND SizeCount > @Count
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01174', GetDate())
GO

