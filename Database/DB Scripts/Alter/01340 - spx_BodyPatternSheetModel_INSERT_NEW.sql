
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternSheetModel_INSERT_NEW]    Script Date: 11/18/2010 17:51:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyPatternSheetModel_INSERT_NEW') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyPatternSheetModel_INSERT_NEW
GO

CREATE PROC [dbo].[spx_BodyPatternSheetModel_INSERT_NEW] (
@ID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@StyleSet int,
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
                (ID,BodyID, StyleSet, Model_Code,Model_Name,Active,IsLinked, IsLinkedBF, CUser, CDate, MUser, MDate)
                VALUES (
              @ID,@BodyID, @StyleSet, @Model_Code ,@Model_Name ,1,@IsLinked, 0, @CUser, @CDate,@CUser, @CDate)

END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01340', GetDate())
GO
