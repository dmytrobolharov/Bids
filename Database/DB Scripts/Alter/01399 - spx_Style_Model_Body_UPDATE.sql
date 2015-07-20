IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Model_Body_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_Model_Body_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_Style_Model_Body_UPDATE]    Script Date: 04/19/2011 15:40:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[spx_Style_Model_Body_UPDATE] (
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
set styleID = @StyleID , IsLinkedBF = @LinkedBF
where ID = @tblID and BodyID =@BodyID 

Update pBodyPatternSheetPiece set 
styleID = @StyleID , IsLinked=@Linked
where ModelID = @tblID and BodyID =@BodyID 

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01399', GETDATE())
GO