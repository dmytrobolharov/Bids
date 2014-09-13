
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 Sep 2011                                                                                */
-- * WorkItem #5018                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColor_INSERT]    Script Date: 09/13/2011 17:22:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColor_INSERT]    Script Date: 09/13/2011 17:22:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_INSERT] (  
@ColorPaletteID UNIQUEIDENTIFIER,   
@StyleID UNIQUEIDENTIFIER,  
@StyleSet INT,  
@SeasonYearID UNIQUEIDENTIFIER,  
@AllSizeClasses INT,  
@CUser NVARCHAR(200),   
@CDate DATETIME,  
@ChangeTransID UNIQUEIDENTIFIER,  
@ChangeTransUserID UNIQUEIDENTIFIER,
@ChangeTransPageName  NVARCHAR(200) = null
)  
AS  
  
  
  
DECLARE @StyleColorID UNIQUEIDENTIFIER   
DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER  
DECLARE @ColorCode NVARCHAR(200)  
DECLARE @ColorName NVARCHAR(200)  
  
SELECT @StyleColorID = a.StyleColorID, @ColorCode = b.ColorCode, @ColorName = b.ColorName  
FROM pStyleColorway a WITH (NOLOCK)  
 INNER JOIN dbo.pColorPalette  b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID  
WHERE a.StyleID = @StyleID    
AND a.ColorPaletteID = @ColorPaletteID   
  
  
SELECT @StyleSeasonYearID = StyleSeasonYearID     
FROM pStyleSeasonYear WITH (NOLOCK)  
WHERE StyleId = @StyleID AND SeasonYearID = @SeasonYearID  
  
IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK)  
  WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID )   
BEGIN  
  
 DECLARE @ChangeLogID UNIQUEIDENTIFIER  
 DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER  
 SET @StyleColorwaySeasonYearID  = NEWID()  
   
 INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID,     
  StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus, Units, ColorType )  
 VALUES  ( @StyleColorwaySeasonYearID, @StyleSeasonYearID , @StyleColorID , @StyleID,     
  1, 1, 1, 1, 800, 0, 'F')  
  
  
 --** Insert Log    
 DECLARE @ChangeAfterText NVARCHAR(400)  
 SET @ChangeAfterText = '('+ ISNULL(@ColorCode,'') + ') ' + ISNULL(@ColorName,'')  
   
   
 EXECUTE spx_ChangeLog_INSERTID  
  @changeTableId = '00000002-c1cc-df11-af06-005056c00008',  
  @changeTransId = @ChangeTransID,  
  @changeTablePKId = @StyleColorwaySeasonYearID,  
  @changeUserId = @ChangeTransUserID,   
  @ChangeUserName = @CUser,  
  @changeDate = @CDate,  
  @changeSort = '0000',  
  @ShowResult = 0,  
  @ChangeLogID = @ChangeLogID OUTPUT  
   
 EXECUTE spx_ChangeLogItem_INSERT  
  @ChangeLogID = @ChangeLogID,  
  @ChangeTransID = @ChangeTransID,  
  @ChangeFieldName = 'StyleColorwasySeasonYearID',  
  @ChangeFieldAlias = 'StyleColorwasySeasonYearID',  
  @ChangeBeforeValue = NULL,  
  @ChangeAfterValue = @StyleColorwaySeasonYearID,  
  @ChangeBeforeText = NULL,  
  @ChangeAfterText = @ChangeAfterText,  
  @ChangeSort = '0001'   
  
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01935'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01935', GetDate())

END

GO    
  
