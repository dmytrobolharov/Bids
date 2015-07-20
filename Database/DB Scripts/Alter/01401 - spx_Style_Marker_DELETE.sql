
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_DELETE]    Script Date: 10/06/2010 12:42:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Marker_DELETE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Marker_DELETE
GO

CREATE PROCEDURE [dbo].[spx_Style_Marker_DELETE]
(
@StyleID uniqueidentifier,
@ID uniqueidentifier
)
AS 

DECLARE 
	@BodyID UNIQUEIDENTIFIER,
	@IsLinkedBF INT
		
SELECT @BodyID = BodyID, @IsLinkedBF =IsLinkedBF  FROM pBodyMarker 
WITH(NOLOCK) WHERE ID = @ID  

if @BodyID IS  NULL 
	BEGIN 
		DELETE FROM pBodyMarker WHERE StyleID = @StyleID AND ID = @ID
	END  
else
	BEGIN 
		UPDATE pBodyMarker SET IsLinkedBF = 0, StyleID= NULL WHERE ID = @ID
	END  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01401', GetDate())
GO
