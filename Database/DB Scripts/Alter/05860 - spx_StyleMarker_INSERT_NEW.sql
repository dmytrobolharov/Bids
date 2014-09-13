IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMarker_INSERT_NEW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMarker_INSERT_NEW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMarker_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@StyleSet int,
@CADCatID int,
@Marker_Code int,
@Marker_Name varchar(100),
@CUser nvarchar(200),
@CDate datetime

)
AS


BEGIN


IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

INSERT INTO dbo.pBodyMarker 
                (ID,StyleID,StyleSet, CADCatID,Marker_Code,Marker_Name,IsActive,IsLinkedBF,IsLinked, CUser, CDate, MUser, MDate)
                VALUES 
             (@ID,@StyleID,@StyleSet, @CADCatID,@Marker_Code ,@Marker_Name ,1,0,0,@CUser, @CDate,@CUser, @CDate)
END

-----------------------------------------------------------


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05860', GetDate())
GO

