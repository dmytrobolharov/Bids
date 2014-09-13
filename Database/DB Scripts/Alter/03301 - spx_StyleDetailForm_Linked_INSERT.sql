/****** Object:  StoredProcedure [dbo].[spx_StyleDetailForm_Linked_INSERT]    Script Date: 04/06/2012 15:16:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailForm_Linked_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailForm_Linked_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDetailForm_Linked_INSERT]    Script Date: 04/06/2012 15:16:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

  
CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Linked_INSERT]  
(  
 @StyleDetailFormID uniqueidentifier,  
 @WorkflowID uniqueidentifier,  
 @WorkflowItemID uniqueidentifier,  
 @StyleID uniqueidentifier,  
 @StyleSet int,  
 @ImageID uniqueidentifier,  
 @ImageVersion int,  
 @CreatedBy nvarchar(100),  
 @CreatedDate datetime  
)  
  
AS   


DECLARE @IsFrontBackWF INT

SELECT  @IsFrontBackWF = IsFrontBackWF FROM dbo.pImageWFValidation WHERE WorkflowID = @WorkflowID
 
 
IF @IsFrontBackWF = 1 
BEGIN
 UPDATE dbo.pStyleHeader  
 SET DesignSketchBackID = @ImageID, DesignSketchBackVersion = @ImageVersion,  
 MUser = @CreatedBy, MDate = @CreatedDate  
 WHERE StyleID = @StyleID  
END 
  
/************************/  
/*Declare variables. */  
/************************/  
DECLARE @StyleDetailFormID_Param UNIQUEIDENTIFIER  --Keep a copy of the original parameter value.  
DECLARE @StyleID_Param UNIQUEIDENTIFIER     --Keep a copy of the original parameter value.  
DECLARE @StyleSet_Param INT        --Keep a copy of the original parameter value.  
  
  
DECLARE @StyleLinkID UNIQUEIDENTIFIER  
  
DECLARE @TotalCount INT  
DECLARE @RowCounter INT  
  
  
/************************************************/  
/*Save a copy of the original parameter values. */  
/************************************************/  
SET @StyleDetailFormID_Param = @StyleDetailFormID  
SET @StyleID_Param = @StyleID  
SET @StyleSet_Param = @StyleSet

DECLARE @SessionItemTempID UNIQUEIDENTIFIER = NEWID()  
  
  
/************************/  
/*Create temp table. */  
/************************/  
CREATE TABLE dbo.#temp_Linked  
 (  
 TableRow int NOT NULL IDENTITY (1, 1)  
 ,StyleID UNIQUEIDENTIFIER  
 ,StyleLinkID UNIQUEIDENTIFIER  
 ,StyleSet INT  
 ,StyleDetailFormID UNIQUEIDENTIFIER  
 )  ON [PRIMARY]  
  
  
ALTER TABLE dbo.#temp_Linked ADD CONSTRAINT  
 PK_#temp_Linked PRIMARY KEY CLUSTERED   
 (  
 TableRow  
 ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]  
  
  
/****************************************************/  
/*Check to see if the Style is Multi-Cloth linked. */  
/****************************************************/  
/*Get the 'StyleLinkID' of the calling Style.*/  
SELECT @StyleLinkID = StyleLinkID  
FROM pStyleHeader  
WHERE StyleID = @StyleID_Param  
  
  
/********************************************************************/  
/*See if there are other Multi-Cloth linked Styles with this one. */  
/********************************************************************/  
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000') --Style is not Multi-Cloth linked.  
 BEGIN  
  /*Execute original procedure with original parameters.*/  
  EXEC spx_StyleDetailForm_INSERT  
   @StyleDetailFormID_Param  
   ,@WorkflowID  
   ,@WorkflowItemID  
   ,@StyleID_Param  
   ,@StyleSet_Param  
   ,@ImageID  
   ,@ImageVersion  
   ,@CreatedBy  
   ,@CreatedDate
   ,@SessionItemTempID = NULL
 END  
ELSE --Style is Multi-Cloth linked.  
 BEGIN  
  /*Put a copy of the original Style in the temp table first.*/  
  INSERT INTO #temp_Linked(  
   StyleID  
   ,StyleLinkID  
   ,StyleSet  
   ,StyleDetailFormID)  
  SELECT  
   @StyleID_Param AS StyleID  
   ,@StyleLinkID  
   ,@StyleSet_Param AS StyleSet  
   ,@StyleDetailFormID_Param AS StyleDetailFormID  
  
  
  /*Get the other Styles that are Multi-Cloth linked to this one.*/  
  INSERT INTO #temp_Linked(  
   StyleID  
   ,StyleLinkID  
   ,StyleSet  
   ,StyleDetailFormID)  
  SELECT  
   StyleID  
   ,StyleLinkID  
   ,@StyleSet_Param AS StyleSet  
   ,NEWID() AS StyleDetailFormID  
  FROM pStyleHeader  
  WHERE StyleLinkID = @StyleLinkID  
   AND StyleID <> @StyleID_Param  
 END  
  
  
/********************************************************************/  
/*Loop through the records to update all Multi-Cloth linked Styles. */  
/********************************************************************/  
/*Get and set the counts for the Multi-Cloth linked Styles.*/  
SELECT @TotalCount = COUNT(*) FROM #temp_Linked  
SET @RowCounter = 1  
  
  
/*Get the 'StyleID' for each of the Multi-Cloth linked Styles.*/  
WHILE(@RowCounter <= @TotalCount)  
 BEGIN  
  /*Clear variables.*/  
  SET @StyleDetailFormID = NULL  
  SET @StyleID = NULL  
  SET @StyleSet = NULL  
  
  
  /*Get the 'StyleID' for the insert.*/  
  SELECT @StyleDetailFormID = StyleDetailFormID  
   ,@StyleID = StyleID  
   ,@StyleSet = StyleSet  
  FROM #temp_Linked  
  WHERE TableRow = @RowCounter  
  
  
  /*Execute the original procedure for another Style.*/  
  EXEC spx_StyleDetailForm_INSERT  
   @StyleDetailFormID  
   ,@WorkflowID  
   ,@WorkflowItemID  
   ,@StyleID  
   ,@StyleSet  
   ,@ImageID  
   ,@ImageVersion  
   ,@CreatedBy  
   ,@CreatedDate
   ,@SessionItemTempID
  
  
  /*Up row counter.*/  
  SET @RowCounter = @RowCounter + 1  
 END  
  
  
/********************/  
/*Drop temp tables. */  
/********************/  
DROP TABLE #temp_Linked  



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03301'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03301', GetDate())

END
GO 