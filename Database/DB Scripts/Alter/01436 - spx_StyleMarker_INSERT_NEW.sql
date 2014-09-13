
/****** Object:  StoredProcedure [dbo].[spx_StyleMarker_INSERT_NEW]    Script Date: 11/22/2010 16:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_StyleMarker_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_StyleMarker_INSERT_NEW
GO

CREATE PROCEDURE [dbo].[spx_StyleMarker_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@StyleSet int,
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
                (ID,StyleID,StyleSet, CADCatID,Marker_Code,Marker_Name,IsActive,IsLinkedBF,IsLinked, CUser, CDate, MUser, MDate)
                VALUES 
             (@ID,@StyleID,@StyleSet, @CADCatID,@Marker_Code ,@Marker_Name ,1,0,0,@CUser, @CDate,@CUser, @CDate)
END

-----------------------------------------------------------

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01436', GetDate())
GO