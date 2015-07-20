SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_pGRSizeRangeDetail_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_pGRSizeRangeDetail_DELETE
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRangeDetail_DELETE]
(@SizeRangeDetailId uniqueidentifier)
AS 


DELETE FROM dbo.pGRSizeRangeDetail WHERE SizeRangeDetailId=@SizeRangeDetailId
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '578', GetDate())
GO

