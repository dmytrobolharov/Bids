/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowTemplateItem_INSERT]    Script Date: 04/11/2012 16:42:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowTemplateItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowTemplateItem_INSERT]    Script Date: 04/11/2012 16:42:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_INSERT]

(@SampleWorkflowTempID uniqueidentifier,
@SampleWorkflowID nvarchar(50),
@SampleWorkflowSort nvarchar(3))

AS


--DECLARE @TemplateSampleWorkflowSort NVARCHAR(5) 

--SELECT @TemplateSampleWorkflowSort = SampleWorkflowSort FROM  pSampleworkflow WITH (NOLOCK)  WHERE SampleWorkflowID = @SampleWorkflowID


IF (SELECT  COUNT(SampleWorkFlowSort)  FROM  dbo.pSampleWorkflowItemTemplate WITH (NOLOCK) WHERE SampleWorkflowTempID = @SampleWorkflowTempID AND SampleWorkflowID = @SampleWorkflowID) = 0 
BEGIN
	INSERT  INTO dbo.pSampleWorkflowItemTemplate(SampleWorkflowTempID, SampleWorkflowID, SampleWorkflowSort,SampleWorkflowAlerts,SampleWorkflowDays , SampleWorkflowFinalDate)
	VALUES  (@SampleWorkflowTempID, @SampleWorkflowID, @SampleWorkflowSort  , 0,  1 , getdate() ) 
END
ELSE
BEGIN
	UPDATE dbo.pSampleWorkflowItemTemplate SET SampleWorkflowSort = @SampleWorkflowSort  WHERE SampleWorkflowTempID = @SampleWorkflowTempID AND SampleWorkflowID = @SampleWorkflowID 
END



set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03337'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03337', GetDate())
END
GO