SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_DeskTop_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_DeskTop_SELECT
GO

CREATE PROCEDURE spx_DeskTop_SELECT(@TeamID uniqueidentifier)
AS 

SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive
FROM sDeskTop
ORDER BY DeskSort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '566', GetDate())
GO
