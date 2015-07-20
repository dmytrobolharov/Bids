IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Model_INSERT_NEW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Model_INSERT_NEW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Style_Model_INSERT_NEW] (
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@Model_Code int,
@Model_Name varchar(100),
@IsLinked int,
@CUser nvarchar(200),
@CDate datetime

)
AS


BEGIN


IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)

INSERT INTO pBodyPatternSheetModel 
                (ID,StyleID, StyleSet, Model_Code,Model_Name,Active,IsLinkedBF,IsLinked, CUser, CDate, MUser, MDate)
                VALUES (@ID,@StyleID,@StyleSet, @Model_Code ,@Model_Name ,1,0,@IsLinked,@CUser, @CDate,@CUser, @CDate)

END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05869', GetDate())
GO
