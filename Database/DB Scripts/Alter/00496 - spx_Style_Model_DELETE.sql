
/****** Object:  StoredProcedure [dbo].[spx_Style_Model_DELETE]    Script Date: 10/06/2010 13:20:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Model_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Model_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Style_Model_DELETE]
(
@StyleID uniqueidentifier,
@ID uniqueidentifier
)
AS 

If ((select IsLinked from dbo.pBodyPatternSheetModel where StyleID  = @StyleID  and ID = @ID)=1)
Begin
DELETE FROM dbo.pBodyPatternSheetModel
WHERE    
 StyleID = @StyleID 
and ID = @ID

End

If ((select IsLinked from dbo.pBodyPatternSheetModel where StyleID  = @StyleID   and ID = @ID)=0)

Begin

Update dbo.pBodyPatternSheetModel
set Active = 0
WHERE    
 StyleID  = @StyleID 
and ID = @ID
End
GO

----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '496', GetDate())
GO
