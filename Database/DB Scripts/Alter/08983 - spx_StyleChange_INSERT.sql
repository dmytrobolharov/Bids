IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleChange_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleChange_INSERT] (
	@ActiveID uniqueidentifier,
	@ChangeID uniqueidentifier,
	@WorkflowID nvarchar(100),
	@WorkflowItemID nvarchar(100) = NULL,
	@StyleID nvarchar(100),
	@StyleSet nvarchar(10),
	@StyleStatus bit,
	@StyleChangeNotifyTo nvarchar(4000),
	@StyleChangeType nvarchar(100),
	@StyleChangeDescription nvarchar(4000),
	@ChangeBy  nvarchar(100),
	@ChangeDate datetime
)

AS 

/*
DECLARE @ChangeID uniqueidentifier
SET @ChangeID = NEWID() 
*/

declare @NoOfChange int 
declare @NoOfTechPack int 
declare @TechPackNo nvarchar(50) 
declare @TechPackID nvarchar(50) 
declare @TechPackVersion int 
--declare @WorkflowStatus nvarchar(100) 
/* declare @ChangeDescription nvarchar(4000)  */


SELECT  @NoOfChange = COUNT(*)  FROM  pStyleChange WITH (NOLOCK) WHERE StyleChangeID = @ChangeID
SELECT  @NoOfTechPack = COUNT(*)  FROM  pTechPack WITH (NOLOCK) WHERE StyleID = @StyleID


                      /* Workflow Status Data */
/*
                      SELECT   @WorkflowStatus =  dbo.pWorkflow.Workflow + ' ' + dbo.pWorkflowStatus.WorkflowStatus + ' By ' + @ChangeBy + ' @ ' + CONVERT(nvarchar(24),  @ChangeDate) 
                      FROM  dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
                      dbo.Users WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkAssignedTo = dbo.Users.UserId INNER JOIN
                      dbo.pWorkflow WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.pWorkflow.WorkflowID
                      WHERE pStyleWorkflow.WorkflowID = @WorkflowID AND dbo.pStyleWorkflow.StyleID = @StyleID AND dbo.pStyleWorkflow.StyleSet = @StyleSet
*/

/* SELECT @ChangeDescription = @WorkflowStatus + char(10) + @StyleChangeDescription */

/*
	IF @StyleStatus = 0
	BEGIN
		SET @WorkflowStatus = '*By ' + @ChangeBy + ' @ ' + CONVERT(nvarchar(24),  @ChangeDate)
	END
*/


IF @NoOfTechPack = 0

	BEGIN
		IF @NoOfChange = 0 
			INSERT INTO pStyleChange  (ActiveID, StyleChangeID, WorkflowID, WorkflowItemID, StyleID, StyleSet, StyleChangeNotifyTo, StyleChangeType, StyleChangeDescription, StyleChangeBy, StyleChangeDate, TechPackID, StyleStatus)
			VALUES (@ActiveID, @ChangeID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet, @StyleChangeNotifyTo, @StyleChangeType, @StyleChangeDescription, @ChangeBy, @ChangeDate,  NULL  , @StyleStatus)
			--VALUES (@ActiveID, @ChangeID, @WorkflowID, @StyleID, @StyleSet, @StyleChangeNotifyTo, @StyleChangeType, @WorkflowStatus + char(13) + char(10)  + @StyleChangeDescription, @ChangeBy, @ChangeDate,  '{00000000-0000-0000-0000-000000000000}', @StyleStatus)
		ELSE
			UPDATE pStyleChange
			SET ActiveID = @ActiveID, StyleStatus = @StyleStatus, StyleChangeNotifyTo = @StyleChangeNotifyTo, StyleChangeType = @StyleChangeType, 
			StyleChangeDescription = @StyleChangeDescription, StyleChangeBy = @ChangeBy, StyleChangeDate = @ChangeDate
			WHERE  (StyleChangeID = @ChangeID)
	END

ELSE

	BEGIN

		SELECT    
		@TechPackID = TechPackID, 
		@TechPackVersion = Version 
		/* 

		@TechPackID = TechPackID, 
		@TechPackNo = TechPackNo
		TechPackStatus, TechPackName, ProjectID, StyleID, StyleSet, StyleVersion, SendMethod, CDate, CUser, MDate,  MUser 

		*/
		FROM  pTechPack WITH (NOLOCK)
		WHERE     (StyleID = @StyleID)
		ORDER BY TechPackID DESC


		IF @NoOfChange = 0 
			INSERT INTO pStyleChange  (ActiveID, StyleChangeID, WorkflowID, WorkflowItemID, StyleID, StyleSet, StyleChangeNotifyTo, StyleChangeType, StyleChangeDescription, StyleChangeBy, StyleChangeDate, TechPackID, StyleStatus)
			VALUES  (@ActiveID, @ChangeID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet, @StyleChangeNotifyTo, @StyleChangeType, @StyleChangeDescription, @ChangeBy, @ChangeDate,  NULL , @StyleStatus)
			--VALUES  (@ActiveID, @ChangeID, @WorkflowID, @StyleID, @StyleSet, @StyleChangeNotifyTo, @StyleChangeType, @WorkflowStatus + char(13) + char(10)  + @StyleChangeDescription, @ChangeBy, @ChangeDate,  @TechPackID, @StyleStatus)
		ELSE
			UPDATE pStyleChange
			SET  ActiveID = @ActiveID, StyleStatus = @StyleStatus, StyleChangeNotifyTo = @StyleChangeNotifyTo, StyleChangeType = @StyleChangeType, 
			StyleChangeDescription = @StyleChangeDescription, StyleChangeBy = @ChangeBy, StyleChangeDate = @ChangeDate
			WHERE  (StyleChangeID = @ChangeID)


	                /* Update Tech Pack if change found */
	                UPDATE  pTechPack
	                SET  Version = (@TechPackVersion + 1)
	                WHERE  (TechPackID = @TechPackID)


	END


BEGIN

	DECLARE @StyleVersion int

	SELECT  @StyleVersion = Change  FROM  pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID

	UPDATE pStyleHeader
	SET Change = (@StyleVersion + 1) 
	WHERE  (StyleID = @StyleID)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08983', GetDate())
GO
