
/****** Object:  StoredProcedure [dbo].[spx_Body_Marker_DELETE]    Script Date: 10/06/2010 12:28:25 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Body_Marker_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Body_Marker_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Body_Marker_DELETE]
(
@BodyID uniqueidentifier,
@ID uniqueidentifier
)
AS 
Begin
if (select styleID FROM dbo.pBodyMarker WHERE BodyId = @BodyID and ID = @ID) is null
Begin
DELETE FROM dbo.pBodyMarker
WHERE    
 BodyId = @BodyID
and ID = @ID
End
End
GO

----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '482', GetDate())
GO
