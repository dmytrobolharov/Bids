IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailForm_Linked_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailForm_Linked_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Linked_DELETE]  
(  
 @StyleDetailFormID uniqueidentifier  
)  
  
AS   
  
  
/************************/  
/*Declare variables. */  
/************************/  
DECLARE @StyleDetailFormID_Param UNIQUEIDENTIFIER  --Keep a copy of the original parameter value.  
  
DECLARE @StyleID UNIQUEIDENTIFIER  
DECLARE @StyleSet INT  
DECLARE @StyleLinkID UNIQUEIDENTIFIER  
  
DECLARE @ImageID UNIQUEIDENTIFIER  
DECLARE @ImageVersion INT  
  
DECLARE @TotalCount INT  
DECLARE @RowCounter INT  
  
DECLARE @WorkflowID UNIQUEIDENTIFIER 
  
/************************************************/  
/*Save a copy of the original parameter values. */  
/************************************************/  
SET @StyleDetailFormID_Param = @StyleDetailFormID  
  
  
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
/*Get the 'StyleID' and 'StyleSet' of the calling Style.*/  
SELECT @StyleID = StyleID  
 ,@StyleSet = StyleSet, @WorkflowID = WorkflowID  
FROM pStyleDetailForm  
WHERE StyleDetailFormID = @StyleDetailFormID_Param  
  
  
  
  BEGIN
		DECLARE @IsFrontBackWF INT

		SELECT  @IsFrontBackWF = IsFrontBackWF FROM dbo.pImageWFValidation WHERE WorkflowID = @WorkflowID
		 
		 
		IF @IsFrontBackWF = 1 
		BEGIN
		 UPDATE dbo.pStyleHeader  
		 SET DesignSketchBackID = '00000000-0000-0000-0000-000000000000', DesignSketchBackVersion = 0  
		 WHERE StyleID = @StyleID  
        END  
  END 
  
/*Get the 'StyleLinkID' of the calling Style.*/  
SELECT @StyleLinkID = StyleLinkID  
FROM pStyleHeader  
WHERE StyleID = @StyleID  
  
  
/********************************************************************/  
/*See if there are other Multi-Cloth linked Styles with this one. */  
/********************************************************************/  
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000') --Style is not Multi-Cloth linked.  
 BEGIN  
  /*Execute original procedure with original parameters.*/  
  EXEC spx_StyleDetailForm_DELETE @StyleDetailFormID_Param  
  
 END  
ELSE --Style is Multi-Cloth linked.  
 BEGIN  
  /*Clear variables.*/  
  SET @ImageID = NULL  
  SET @ImageVersion = NULL  
  
  
  /*Get the 'ImageID' and 'ImageVersion' values of the calling Style.*/  
  SELECT @ImageID = ImageID  
   ,@ImageVersion = ImageVersion  
  FROM pStyleDetailForm  
  WHERE StyleDetailFormID = @StyleDetailFormID_Param  
  
  
  /*Get all the Styles that are Multi-Cloth linked to this 'StyleLinkID'.*/  
  INSERT INTO #temp_Linked(  
   StyleID  
   ,StyleLinkID  
   ,StyleSet)  
  SELECT  
   StyleID  
   ,StyleLinkID  
   ,@StyleSet  
  FROM pStyleHeader  
  WHERE StyleLinkID = @StyleLinkID  
  
  
  /*Get and set the counts for the Multi-Cloth linked Styles.*/  
  SELECT @TotalCount = COUNT(*) FROM #temp_Linked  
  SET @RowCounter = 1  
  
  
  /*Get the 'StyleDetailFormID' of the Image for each of the Multi-Cloth linked Styles.*/  
  WHILE(@RowCounter <= @TotalCount)  
   BEGIN  
    /*Clear variables.*/  
    SET @StyleID = NULL  
    SET @StyleSet = NULL  
    SET @StyleDetailFormID = NULL  
  
  
    /*Get 'StyleID'.*/  
    SELECT @StyleID = StyleID  
     ,@StyleSet = StyleSet  
    FROM #temp_Linked  
    WHERE TableRow = @RowCounter  
  
  
    /*Get the 'StyleDetailFormID'.*/  
    SELECT @StyleDetailFormID = StyleDetailFormID  
    FROM pStyleDetailForm  
    WHERE StyleID = @StyleID  
     AND StyleSet = @StyleSet  
     AND ImageID = @ImageID  
     AND ImageVersion = @ImageVersion  
  
  
    /*Update the temp table with the 'StyleDetailFormID'.*/  
    UPDATE #temp_Linked  
    SET StyleDetailFormID = @StyleDetailFormID  
    WHERE TableRow = @RowCounter  
  
  
    /*Up row counter.*/  
    SET @RowCounter = @RowCounter + 1  
   END  
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
  
  
  /*Get the 'StyleID' for the delete.*/  
  SELECT @StyleDetailFormID = StyleDetailFormID  
  FROM #temp_Linked  
  WHERE TableRow = @RowCounter  
  
  
  /*Execute the original procedure for another Style.*/  
  EXEC spx_StyleDetailForm_DELETE @StyleDetailFormID  
  
  
  /*Up row counter.*/  
  SET @RowCounter = @RowCounter + 1  
 END  
  
  
/********************/  
/*Drop temp tables. */  
/********************/  
DROP TABLE #temp_Linked

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03178', GetDate())

GO
