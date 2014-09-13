
/****** Object:  StoredProcedure [dbo].[spx_Style_Model_Body_UPDATE]    Script Date: 10/06/2010 13:19:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Model_Body_UPDATE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Model_Body_UPDATE
GO

CREATE procedure [dbo].[spx_Style_Model_Body_UPDATE] (
@tblID UNIQUEIDENTIFIER ,
--@strID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER 

)
AS
Declare @Linked as int
Declare @LinkedBF as int
Declare @ImageID as UNIQUEIDENTIFIER 
Set @ImageID = null
Set @Linked = (Select IsLinked From pBodyPatternSheetModel Where ID = @tblID)
Set @LinkedBF = 1

BEGIN

Update pBodyPatternSheetModel
set styleID = @StyleID ,IsLinkedBF = @LinkedBF
where ID = @tblID and BodyID =@BodyID 
END
GO



--------------------------------------------------------------
--------------------------------------------------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '495', GetDate())
GO
