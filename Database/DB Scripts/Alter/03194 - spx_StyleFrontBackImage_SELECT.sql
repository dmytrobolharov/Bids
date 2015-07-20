IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFrontBackImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFrontBackImage_SELECT]
GO

CREATE PROCEDURE spx_StyleFrontBackImage_SELECT
(
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT ,
@MUser nvarchar(200),
@MDate datetime
)
AS

DECLARE @DesignImageFrontID UNIQUEIDENTIFIER
DECLARE @DesignImageBackID UNIQUEIDENTIFIER
DECLARE @DesignImageFrontVersion INT
DECLARE @DesignImageBackVersion INT

SELECT 
@DesignImageFrontID =  ISNULL(DesignSketchID,'00000000-0000-0000-0000-000000000000'),
@DesignImageBackID = ISNULL(DesignSketchBackID,'00000000-0000-0000-0000-000000000000'), 
@DesignImageFrontVersion= ISNULL(DesignSketchVersion,0) , 
@DesignImageBackVersion = ISNULL(DesignSketchBackVersion,0) 
FROM dbo.pStyleHeader WHERE StyleID = @StyleID

CREATE TABLE  #Temp (   
           Rec_Id int identity(1,1)  ,   
           StyleDetailFormID  UNIQUEIDENTIFIER,
           StyleDetailFormMasterID  UNIQUEIDENTIFIER,
           StyleDetailFormGroupID  UNIQUEIDENTIFIER,
           WorkflowID UNIQUEIDENTIFIER,
           StyleID  UNIQUEIDENTIFIER,
           Comments  nvarchar(2000),
           StyleSet  INT,
           ImageID  UNIQUEIDENTIFIER,
           ImageVersion  INT,
           Sort  nvarchar(5),
           CUser  nvarchar(200),
           CDate  DATETIME,
           MUser  nvarchar(200),
           MDate  DATETIME,
           StyleImageLinked  INT,
           StyleDetailFormLinkID  UNIQUEIDENTIFIER,
           SessionItemTempID  UNIQUEIDENTIFIER,
           WorkFlowItemId  uniqueidentifier
           )  

INSERT  INTO #Temp ( StyleDetailFormID ,
          StyleDetailFormMasterID ,
          StyleDetailFormGroupID ,
          WorkflowID ,
          StyleID ,
          Comments ,
          StyleSet ,
          ImageID ,
          ImageVersion ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate ,
          StyleImageLinked ,
          StyleDetailFormLinkID ,
          SessionItemTempID ,
          WorkFlowItemId ) 
SELECT NEWID() AS StyleDetailFormID ,
        NEWID() as  StyleDetailFormMasterID ,
          null,
          '70000000-0000-0000-0000-000000000999' ,
          @StyleID ,
          null ,
          @StyleSet ,
          @DesignImageFrontID ,
          @DesignImageFrontVersion ,
          null ,
          @MUser ,
          @MDate ,
          @MUser ,
          @MDate ,
          0,
          null ,
          null ,
          '90000000-0000-0000-0000-000000000999'
          
          
          
 INSERT  INTO #Temp ( StyleDetailFormID ,
          StyleDetailFormMasterID ,
          StyleDetailFormGroupID ,
          WorkflowID ,
          StyleID ,
          Comments ,
          StyleSet ,
          ImageID ,
          ImageVersion ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate ,
          StyleImageLinked ,
          StyleDetailFormLinkID ,
          SessionItemTempID ,
          WorkFlowItemId ) 
SELECT NEWID() AS StyleDetailFormID ,
        NEWID() as  StyleDetailFormMasterID ,
          null,
          '70000000-0000-0000-0000-000000000999' ,
          @StyleID ,
          null ,
          @StyleSet ,
          @DesignImageBackID ,
          @DesignImageBackVersion ,
          null ,
          @MUser ,
          @MDate ,
          @MUser ,
          @MDate ,
          0,
          null ,
          null ,
          '90000000-0000-0000-0000-000000000999'         

SELECT  * FROM #Temp   
DROP TABLE #Temp 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03194', GetDate())

GO   
