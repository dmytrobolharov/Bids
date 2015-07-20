
/****** Object:  StoredProcedure [dbo].[spx_Style_Model_INSERT_NEW]    Script Date: 11/22/2010 16:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Model_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Model_INSERT_NEW
GO
CREATE PROCEDURE [dbo].[spx_Style_Model_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@Model_Code int,
@Model_Name varchar(32),
@IsLinked int,
@CUser nvarchar(200),
@CDate datetime

)
AS


BEGIN


IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)

INSERT INTO pBodyPatternSheetModel 
                (ID,StyleID,Model_Code,Model_Name,Active,IsLinkedBF,IsLinked, CUser, CDate, MUser, MDate)
                VALUES (
              @ID,@StyleID,@Model_Code ,@Model_Name ,1,0,3,@CUser, @CDate,@CUser, @CDate)

END
-------------------------------------------------------
----
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '762', GetDate())
GO