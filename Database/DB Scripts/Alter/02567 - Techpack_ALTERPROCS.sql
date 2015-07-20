

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageItemTemp_INSERT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageItemTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_Folder_SELECTED]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_Folder_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_Folder_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPack_SeasonYear_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPack_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPack_SeasonYear_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackStyleVariation_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStyleVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_StyleSet_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_StyleSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_StyleSet_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_PageOnTheFly_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_Pages_SELECT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_Pages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackNew_INSERT]    Script Date: 01/12/2012 15:19:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackNew_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageItemTemp_INSERT]    Script Date: 01/12/2012 15:19:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_PageItemTemp_INSERT]
	@ReportTechpackID [uniqueidentifier],
	@ReportPageID [uniqueidentifier],
	@WorkflowItemID [uniqueidentifier],
	@WorkflowID [uniqueidentifier],
	@SeasonYearID [uniqueidentifier],
	@StyleDevelopmentID [uniqueidentifier],
	@StyleHeaderID [uniqueidentifier],
	@StyleID [uniqueidentifier],
	@StyleSet [int],
	@TechPackName [nvarchar](200),
	@TechPackFinal [int],
	@Sort [int],
	@StyleColorwaySeasonYearID [uniqueidentifier],
	@IsTechPackOnTheFly [int] = NULL
WITH EXECUTE AS CALLER
AS
IF @IsTechPackOnTheFly = 1
	BEGIN
		INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID , 
			ReportTemplateName, ReportPageName , ReportPageDescription, 
			ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID , 
			StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID) 
		SELECT NEWID() AS ReportStylePageItemID, ReportPageID ,  @ReportTechpackID ,  ReportMapID ,  ReportPageTypeID , 
			ReportTemplateName, ReportPageName , ReportPageDescription,
			ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, @SeasonYearID, @StyleHeaderID, 
			@StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
			@WorkflowItemID, @WorkflowID
		FROM rReportStylePageItem WHERE ReportPageID= @ReportPageID
	END
ELSE
	BEGIN
		INSERT INTO rReportStylePageItemTemp  (ReportStylePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID , 
			ReportTemplateName, ReportPageName , ReportPageDescription, 
			ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID , 
			StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID) 
		SELECT NEWID() AS ReportStylePageItemID, ReportTechPackPageID ,  @ReportTechpackID,  ReportMapID ,  ReportPageTypeID , 
			ReportTemplateName, ReportPageName , ReportPageDescription,
			ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, 0, @SeasonYearID, @StyleHeaderID, 
			@StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,
			@WorkflowItemID, @WorkflowID
		FROM rReportTechPackPageItem WHERE ReportTechPackPageID= @ReportPageID
	END











GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_Folder_SELECTED]    Script Date: 01/12/2012 15:19:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_Folder_SELECTED]
	@TechPackFolderId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
SELECT ReportTechPackFolderID, ReportTechPackFolderName, ReportTechPackFormName, 
	ReportTechPackGroup, ReportTechPackFinal, CDate, CUser, MDate, MUser, Sort, Active 
FROM rReportTechPackFolder 
WHERE ReportTechpackFolderID = @TechPackFolderId 



GO

/****** Object:  StoredProcedure [dbo].[spx_TechPack_SeasonYear_SELECT]    Script Date: 01/12/2012 15:19:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_TechPack_SeasonYear_SELECT]
	@TechPackId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
SELECT a.*, b.Season AS Season, b.Year AS [YEAR]  
FROM pTechPack a WITH (NOLOCK)
LEFT OUTER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
LEFT OUTER JOIN pSeasonYear b ON c.SeasonYearID  = b.SeasonYearID  
WHERE a.TechPackID = @TechPackId 


GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackStyleVariation_SELECT]    Script Date: 01/12/2012 15:19:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
	@StyleID [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
DECLARE @StyleDevelopmentId uniqueidentifier

BEGIN
SELECT TOP 1 @StyleDevelopmentId = StyleDevelopmentId FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
END

BEGIN
	SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleDevelopmentID, StyleID, StyleDevelopmentName, Variation 
	FROM dbo.pStyleDevelopmentItem WITH (NOLOCK)
	WHERE (StyleDevelopmentID = @StyleDevelopmentID)
	ORDER BY Variation ASC
END




GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_StyleSet_SELECT]    Script Date: 01/12/2012 15:19:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_StyleSet_SELECT]
	@ReportTechpackID [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
BEGIN
	CREATE TABLE #ReportStylePageItemTemp(
		RecID  int IDENTITY (1,1) , 
		ReportTechpackID uniqueidentifier NOT NULL,
		StyleID uniqueidentifier NULL)
		
	CREATE TABLE #ReportStyleHeaderTemp(
		RecID  int IDENTITY (1,1) , 
		StyleSet int NULL,
		StyleID uniqueidentifier NULL)	
END	

BEGIN
	INSERT INTO #ReportStylePageItemTemp(ReportTechpackID, StyleID)
	SELECT ReportTechpackID, StyleID FROM #ReportStylePageItemTemp 
	WHERE ReportTechpackID = @ReportTechPackID
	GROUP BY ReportTechpackID, StyleID
END

DECLARE @StyleID uniqueidentifier
DECLARE @StyleSet int
DECLARE @Row_Count int, @Row_Current int
SET @Row_Count = (SELECT COUNT(*) FROM  #ReportStylePageItemTemp)
SET @Row_Current = 1 

WHILE  @Row_Current <= @Row_Count  
BEGIN 
	SET @StyleID = (SELECT StyleID FROM #ReportStylePageItemTemp WHERE RecID = @Row_Current) 
	SET @StyleSet = (SELECT StyleSet FROM dbo.pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID)

	If @StyleSet = 1 
	BEGIN
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 1)
	END
	ELSE IF @StyleSet = 2
	BEGIN
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 1)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 2)
	END
	ELSE IF @StyleSet = 3
	BEGIN
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 1)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 2)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 3)
	END
	ELSE IF @StyleSet = 4
	BEGIN
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 1)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 2)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 3)
		INSERT INTO #ReportStyleHeaderTemp(StyleID, StyleSet) VALUES (@StyleID, 4)	
	END
	
	SET @Row_Current  =  @Row_Current + 1 
END

BEGIN
	SELECT * FROM #ReportStyleHeaderTemp
END

BEGIN
	DROP TABLE #ReportStyleHeaderTemp 
	DROP TABLE #ReportStylePageItemTemp 
END
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]    Script Date: 01/12/2012 15:19:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_PageStyleGroupBy_SELECT]
	@TechPackFolderId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
SELECT StyleID, SeasonYearID, TechPackFinal, TechPackName  FROM rReportStylePageItemTemp
	WHERE ReportTechpackID = @TechPackFolderId 
	GROUP BY StyleID, SeasonYearID, TechPackFinal, TechPackName 

GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]    Script Date: 01/12/2012 15:19:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_PageOnTheFly_SELECT]
	@TechPackFolderId [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
SELECT ReportStylePageItemTempID, ReportStylePageItemID, ReportPageID, ReportTechpackID, ReportMapID, ReportPageTypeID, WorkflowItemID, WorkflowID, 
      ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
      ReportPageFormat, ReportSrmOn, SeasonYearID, StyleDevelopmentID, StyleHeaderID, StyleID, StyleSet, Sort, TechPackName, TechPackFinal, Variation, StyleColorwaySeasonYearID
FROM rReportStylePageItemTemp
WHERE ReportTechpackID = @TechPackFolderId 
ORDER BY Sort, StyleSet

GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackReport_Pages_SELECT]    Script Date: 01/12/2012 15:19:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
	@TechPackFolderId [uniqueidentifier],
	@StyleId [uniqueidentifier],
	@ReportPageBySet [int]
WITH EXECUTE AS CALLER
AS
SELECT * FROM (
SELECT dbo.rReportTechPackPageItem.ReportTechPackPageID, dbo.rReportTechPackPageItem.ReportTechPackFolderID, dbo.rReportTechPackPageItem.ReportPageTypeID, 
      dbo.rReportTechPackPageItem.ReportTemplateName, dbo.rReportTechPackPageItem.ReportPageName, dbo.rReportTechPackPageItem.ReportPageDescription, 
      dbo.rReportTechPackPageItem.ReportServerType, dbo.rReportTechPackPageItem.ReportFormName, dbo.rReportTechPackPageItem.ReportPageURL, 
      dbo.rReportTechPackPageItem.ReportPKIField, dbo.rReportTechPackPageItem.ReportPageActive, 
      dbo.rReportTechPackPageItem.ReportPageFormat, dbo.rReportTechPackPageItem.ReportPageSort, dbo.rReportTechPackPageItem.ReportMapID, 
      dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkflowItemType.WorkflowItemTypeId
FROM  dbo.pWorkFlowItem INNER JOIN
      dbo.pWorkflowItemType ON dbo.pWorkFlowItem.WorkflowItemTypeId = dbo.pWorkflowItemType.WorkflowItemTypeId RIGHT OUTER JOIN
      dbo.rReportTechPackPageItem ON dbo.pWorkflowItemType.MapId = dbo.rReportTechPackPageItem.ReportMapID
WHERE (dbo.pWorkFlowItem.StyleID = @StyleID) 
		AND (dbo.rReportTechPackPageItem.ReportTechPackFolderID = @TechPackFolderId)
		AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet 		
UNION      
SELECT ReportTechPackPageID, ReportTechPackFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
     ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportPageSort, ReportMapID,
     NULL AS StyleID, NULL AS WorkflowItemName, ReportTechPackPageID AS WorkflowItemID, NULL AS WorkflowItemTypeID
FROM  dbo.rReportTechPackPageItem
WHERE (ReportTechPackFolderID = @TechPackFolderId) AND ReportMapID IS NULL
		AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet
) tmpTable 
ORDER BY ReportPageSort



GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackNew_INSERT]    Script Date: 01/12/2012 15:19:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_TechPackNew_INSERT]
	@TechPackId [uniqueidentifier],
	@TechPackName [nvarchar](200),
	@TechPackStatus [int],
	@TechPackFinal [int],
	@StyleId [uniqueidentifier],
	@CreatedDate [datetime],
	@CreatedBy [nvarchar](200),
	@StyleSourcingID [uniqueidentifier] = NULL,
	@SeasonYearID [uniqueidentifier] = NULL
WITH EXECUTE AS CALLER
AS
IF EXISTS ( SELECT * FROM dbo.pTechPack WITH (NOLOCK) WHERE  TechPackID = @TechPackId)
	RETURN

  
DECLARE  
	@StyleSet int,  
	@StyleVersion int,  
	@TradePartnerVendorID UNIQUEIDENTIFIER,  
	@TradePartnerID UNIQUEIDENTIFIER,  
	@SystemServerStorageID UNIQUEIDENTIFIER,  
	@StyleSeasonYearID UNIQUEIDENTIFIER
	
--Final Tech Pack	
IF @TechPackFinal = 1
BEGIN
	SELECT @StyleVersion = Change FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId 
	BEGIN
	UPDATE pTechPack SET StyleVersion = @StyleVersion , TechpackRelease = 1, 
	MDate = @CreatedDate, MUser = @CreatedBy, Active = 1 WHERE TechPackID = @TechPackId
	END

	BEGIN
	UPDATE pStyleHeader SET TechPackId = @TechPackId, TechPackDate = @CreatedDate WHERE StyleID = @StyleId 
	END	
END
		
IF  @StyleSourcingID IS NOT NULL   
BEGIN  
	SELECT @TradePartnerID = TradePartnerID , @TradePartnerVendorID = TradePartnerVendorID  FROM pStyleSourcing WITH (NOLOCK)  
	WHERE StyleSourcingID = @StyleSourcingID   
END   
  

SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WITH (NOLOCK) WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')   
SELECT @StyleSet = StyleSet, @StyleVersion = Change FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId   
  
SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID FROM dbo.pStyleSeasonYear  WITH (NOLOCK)
WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
  
INSERT INTO dbo.pTechPack(
		TechPackID, TechPackName, TechPackStatus, StyleID, StyleSet, StyleVersion, CDate, CUser, MDate, MUser, Active ,  
		TradePartnerID, TradePartnerVendorID, StyleSourcingID, SystemServerStorageID,StyleSeasonYearID)  
VALUES(	@TechPackId, @TechPackName, @TechPackStatus, @StyleId, @StyleSet, @StyleVersion, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy,   
		'YES' , @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID, @StyleSeasonYearID)  
  
IF @@ROWCOUNT > 0   
 exec spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId  

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02567'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02567', GetDate())
END
GO