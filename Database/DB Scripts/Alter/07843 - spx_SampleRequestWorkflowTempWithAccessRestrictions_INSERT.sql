/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowTempWithAccessRestrictions_INSERT]    Script Date: 06/03/2014 13:37:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowTempWithAccessRestrictions_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowTempWithAccessRestrictions_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowTempWithAccessRestrictions_INSERT]    Script Date: 06/03/2014 13:37:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowTempWithAccessRestrictions_INSERT]
(@SampleWorkflowTempID uniqueidentifier,
@SampleScheduleType nvarchar(50),
@SampleRequestGroupID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@StyleColorID nvarchar(50),
@StartDate DateTime,
@EndDate DateTime,
@CreatedBy nvarchar(200),
@CreatedDate DateTime, 
@TeamID uniqueidentifier 
)
AS 

		UPDATE pSampleRequestSetItemTemp
		SET  SampleWorkflowTempID = @SampleWorkflowTempID, 
		SampleScheduleType = @SampleScheduleType, 
		StartDate = @StartDate,
		EndDate = @EndDate, 
		MUser = @CreatedBy, 
		MDate = @CreatedDate 
		WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID

		DELETE FROM pSampleRequestWorkflowTemp WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND SampleRequestGroupID = @SampleRequestGroupID	

		INSERT INTO dbo.pSampleRequestWorkflowTemp
		(SampleWorkflowTempItemID, SampleRequestGroupID, SampleWorkflowID, AssignedTo, Submit, 
		Status, SubmitDays, ResubmitDays, StyleID, StyleSet, StyleColorID, CUser, MUser, CDate, MDate, SampleWorkflowFinalDate , StartDate, SampleWorkflowPartnerTypeID )
		SELECT SampleWorkflowTempItemID, @SampleRequestGroupID, SampleWorkflowID, SampleWorkflowAssignedTo, 1, 
		1, SampleWorkflowDays, SampleWorkflowRDays, @StyleID AS StyleID, @StyleSet AS StyleSet, @StyleColorID AS StyleColorID, 
		@CreatedBy AS CUser, @CreatedBy AS MUser, @CreatedDate AS Cdate, @CreatedDate AS MDate, SampleWorkflowFinalDate ,
		@StartDate AS StartDate, SampleWorkflowPartnerTypeID 
		FROM dbo.pSampleWorkflowItemTemplate
		WHERE (SampleWorkflowTempID = @SampleWorkflowTempID)
		ORDER BY SampleWorkflowSort	


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07843', GetDate())
GO