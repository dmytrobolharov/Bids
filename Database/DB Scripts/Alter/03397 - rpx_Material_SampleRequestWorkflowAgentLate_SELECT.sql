/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]    Script Date: 04/27/2012 12:05:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]    Script Date: 04/27/2012 12:05:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[rpx_Material_SampleRequestWorkflowAgentLate_SELECT]
(	
	@TradePartnerID NVARCHAR(50)= NULL,
	@TeamID NVARCHAR(50)
)
AS 
BEGIN

	IF  @TradePartnerID IS NULL OR @TradePartnerID=''
	BEGIN
		SET @TradePartnerID =NULL
	END

	SET NOCOUNT ON
	IF @TradepartnerID IS NOT NULL
		BEGIN
			SELECT 
				dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS SampleRequestWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerID AS SampleRequestTradeID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialColorID
				,dbo.pMaterialRequestSubmitWorkflow.[Status]
				,dbo.pMaterialRequestSubmitWorkflow.Submit
				,dbo.pMaterialRequestSubmitWorkflow.StartDate
				,dbo.pMaterialRequestSubmitWorkflow.DueDate
				,dbo.pMaterialRequestSubmitWorkflow.EndDate
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow AS SampleWorkflowID
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowSort
				,dbo.pMaterialRequestWorkflow.GroupName
				,dbo.pMaterialRequestSubmitWorkflow.AssignedTo
				,dbo.Users.FirstName
				,dbo.Users.LastName
				,dbo.pMaterial.MaterialNo
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow 
					+ N' (' 
					+ CAST(dbo.pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(4)) 
					+ ') ' AS LateHeader, 
				'A: ' 
					+ dbo.uTradePartner.TradePartnerCode 
					+ ' / V: ' 
					+ dbo.uTradePartnerVendor.VendorCode 
					+ '     ' 
					+ dbo.pmaterial.MaterialNo 
					+ ' (' 
					+ dbo.pMaterial.MaterialName+ ') ' 
					+ dbo.pComponentType.ComponentDescription AS LateDescription
				,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
				,pMaterialRequestSubmit.SubmitComment
			FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK)
				
				INNER JOIN  dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
				INNER JOIN	dbo.uTradePartner WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
				INNER JOIN  dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
				INNER JOIN	dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				LEFT OUTER JOIN pMaterialRequestSubmit ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
				LEFT OUTER JOIN dbo.Users WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.AssignedTo = dbo.Users.UserId 
				LEFT OUTER JOIN dbo.pComponentType WITH (NOLOCK) ON pMaterial.MaterialType = dbo.pComponentType.ComponentTypeID  
			WHERE (dbo.pMaterialRequestSubmitWorkflow.DueDate <= GETDATE()) 
				AND (dbo.pMaterialRequestSubmitWorkflow.[Status] NOT IN (2, 3, 4)) 
				AND (dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = @TradePartnerID)
				AND pMaterialRequestWorkflow.Active='1'
				AND
				(
				pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				IN 
					(
						SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit 
						WITH (NOLOCK) WHERE TeamId = @TeamId 
					)
				)
				ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo
		END
		ELSE
		BEGIN
			SELECT 
				dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS SampleRequestWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerID AS SampleRequestTradeID
				,dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialID
				,dbo.pMaterialRequestSubmitWorkflow.MaterialColorID
				,dbo.pMaterialRequestSubmitWorkflow.[Status]
				,dbo.pMaterialRequestSubmitWorkflow.Submit
				,dbo.pMaterialRequestSubmitWorkflow.StartDate
				,dbo.pMaterialRequestSubmitWorkflow.DueDate
				,dbo.pMaterialRequestSubmitWorkflow.EndDate
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow AS SampleWorkflowID
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowSort
				,dbo.pMaterialRequestWorkflow.GroupName
				,dbo.pMaterialRequestSubmitWorkflow.AssignedTo
				,dbo.Users.FirstName
				,dbo.Users.LastName
				,dbo.pMaterial.MaterialNo
				,dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow 
					+ N' (' 
					+ CAST(dbo.pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(4)) 
					+ ') '	AS LateHeader, 
				'A: ' 
					+ dbo.uTradePartner.TradePartnerCode 
					+ ' / V: ' 
					+ dbo.uTradePartnerVendor.VendorCode 
					+ '     ' 
					+ dbo.pmaterial.MaterialNo 
					+ ' (' 
					+ dbo.pMaterial.MaterialName
					+ ') ' 
					+ dbo.pComponentType.ComponentDescription	AS LateDescription
				,pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
				,pMaterialRequestSubmit.SubmitComment
			FROM dbo.pMaterialRequestSubmitWorkflow WITH (NOLOCK) 
				
				INNER JOIN dbo.pMaterial WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialID = dbo.pMaterial.MaterialID 
				INNER JOIN dbo.uTradePartner WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
				INNER JOIN dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID 
				INNER JOIN dbo.pMaterialRequestWorkflow WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				LEFT OUTER JOIN pMaterialRequestSubmit ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
				LEFT OUTER JOIN dbo.Users WITH (NOLOCK) ON dbo.pMaterialRequestSubmitWorkflow.AssignedTo = dbo.Users.UserId 
				LEFT OUTER JOIN dbo.pComponentType WITH (NOLOCK) ON pMaterial.MaterialType =dbo.pComponentType.ComponentTypeID  
			WHERE (dbo.pMaterialRequestSubmitWorkflow.DueDate <= GETDATE()) 
				AND (dbo.pMaterialRequestSubmitWorkflow.[Status] NOT IN (2, 3, 4)) 
				AND pMaterialRequestWorkflow.Active='1'
				AND
				(
				pMaterialRequestWorkflow.MaterialRequestWorkflowID 
				IN 
					(
						SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit 
						WITH (NOLOCK) WHERE TeamId = @TeamId 
					)
				)
			ORDER BY dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterial.MaterialNo
		END
	
	SET NOCOUNT OFF	
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03397', GetDate())
GO