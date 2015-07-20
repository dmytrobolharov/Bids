
/****** Object:  StoredProcedure [dbo].[spx_BodyMarker_INSERT_NEW]    Script Date: 11/18/2010 17:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyMarker_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyMarker_INSERT_NEW
GO
CREATE PROC [dbo].[spx_BodyMarker_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@CADCatID int,
@Marker_Code int,
@Marker_Name varchar(32),
@CUser nvarchar(200),
@CDate datetime

)
AS

BEGIN
IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

INSERT INTO dbo.pBodyMarker 
                (ID,BodyID,CADCatID,Marker_Code,Marker_Name,IsActive,IsLinked, IsLinkedBF, CUser, CDate, MUser, MDate)
                VALUES 
             (@ID,@BodyID,@CADCatID,@Marker_Code ,@Marker_Name ,1,0, 0, @CUser, @CDate,@CUser, @CDate)
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01359', GetDate())
GO