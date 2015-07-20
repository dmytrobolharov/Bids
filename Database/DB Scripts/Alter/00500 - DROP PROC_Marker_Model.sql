SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_Style_Marker_Body_Insert') and sysstat & 0xf = 4)
    drop procedure spx_Style_Marker_Body_Insert
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_Style_Model_Body_Insert') and sysstat & 0xf = 4)
    drop procedure spx_Style_Model_Body_Insert
GO

----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '500', GetDate())
GO
