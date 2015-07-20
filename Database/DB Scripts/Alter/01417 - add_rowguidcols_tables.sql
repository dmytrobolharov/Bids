--
-- IssueTeam
--
ALTER TABLE iIssueTeam ADD IssueTeamID uniqueidentifier NULL
GO

ALTER TABLE iIssueTeam ADD CONSTRAINT DF_iIssueTeam_IssueTeamID DEFAULT NewId() FOR IssueTeamID
GO

UPDATE iIssueTeam 
   SET IssueTeamID = NewId()
WHERE IssueTeamID Is NULL
GO

ALTER TABLE iIssueTeam ALTER COLUMN IssueTeamID uniqueidentifier NOT NULL
GO

ALTER TABLE iIssueTeam ALTER COLUMN IssueTeamID ADD ROWGUIDCOL
GO

--
-- pBodyChange
--

ALTER TABLE pBodyChange ALTER COLUMN BodyChangeID DROP ROWGUIDCOL
GO

ALTER TABLE pBodyChange ADD RepRowGuidColID uniqueidentifier NULL
GO
ALTER TABLE pBodyChange ADD CONSTRAINT DF_pBodyChange_RepRowGuidColID DEFAULT NewId() FOR RepRowGuidColID
GO

UPDATE pBodyChange
   SET RepRowGuidColID = NewId()
WHERE RepRowGuidColID Is NULL
GO

ALTER TABLE pBodyChange ALTER COLUMN RepRowGuidColID uniqueidentifier NOT NULL
GO

ALTER TABLE pBodyChange ALTER COLUMN RepRowGuidColID ADD ROWGUIDCOL
GO
--
-- pLabDip
--
ALTER TABLE pLabDip ALTER COLUMN LabDipID DROP ROWGUIDCOL
GO

ALTER TABLE pLabDip ADD RepRowGuidColID uniqueidentifier NULL
GO

ALTER TABLE pLabDip ADD CONSTRAINT DF_pLabDip_RepRowGuidColID DEFAULT NewId() FOR RepRowGuidColID
GO

UPDATE pLabDip
   SET RepRowGuidColID = NewId()
WHERE RepRowGuidColID Is NULL
GO

ALTER TABLE pLabDip ALTER COLUMN RepRowGuidColID uniqueidentifier NOT NULL
GO

ALTER TABLE pLabDip ALTER COLUMN RepRowGuidColID ADD ROWGUIDCOL
GO

--
-- ProjectFolder
--

ALTER TABLE ProjectFolder ALTER COLUMN ProjectID DROP ROWGUIDCOL
GO

ALTER TABLE ProjectFolder ADD RepRowGuidColID uniqueidentifier NULL
GO

ALTER TABLE ProjectFolder ADD CONSTRAINT DF_ProjectFolder_RepRowGuidColID DEFAULT NewId() FOR RepRowGuidColID
GO

UPDATE ProjectFolder
   SET RepRowGuidColID = NewId()
WHERE RepRowGuidColID Is NULL
GO

ALTER TABLE ProjectFolder ALTER COLUMN RepRowGuidColID uniqueidentifier NOT NULL
GO

ALTER TABLE ProjectFolder ALTER COLUMN RepRowGuidColID ADD ROWGUIDCOL
GO

--
-- pStyleChange
--

ALTER TABLE pStyleChange ALTER COLUMN StyleChangeID DROP ROWGUIDCOL
GO

ALTER TABLE pStyleChange ADD RepRowGuidColID uniqueidentifier NULL
GO

ALTER TABLE pStyleChange ADD CONSTRAINT DF_pStyleChange_RepRowGuidColID DEFAULT NewId() FOR RepRowGuidColID
GO

UPDATE pStyleChange
   SET RepRowGuidColID = NewId()
WHERE RepRowGuidColID Is NULL
GO

ALTER TABLE pStyleChange ALTER COLUMN RepRowGuidColID uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleChange ALTER COLUMN RepRowGuidColID ADD ROWGUIDCOL
GO

--
-- pWorkFlowItem
--

ALTER TABLE pWorkFlowItem ADD RepRowGuidColID uniqueidentifier NULL
GO

ALTER TABLE pWorkFlowItem ADD CONSTRAINT DF_pWorkFlowItem_RepRowGuidColID DEFAULT NewId() FOR RepRowGuidColID
GO

UPDATE pWorkFlowItem
   SET RepRowGuidColID = NewId()
WHERE RepRowGuidColID Is NULL
GO

ALTER TABLE pWorkFlowItem ALTER COLUMN RepRowGuidColID uniqueidentifier NOT NULL
GO

ALTER TABLE pWorkFlowItem ALTER COLUMN RepRowGuidColID ADD ROWGUIDCOL
GO

--
-- uUserSetting
--
ALTER TABLE uUserSetting ALTER COLUMN UserSettingID ADD ROWGUIDCOL
GO


--
-- iDutyHTS
--
ALTER TABLE iDutyHTS ALTER COLUMN CustomID ADD ROWGUIDCOL
GO

--
-- MessageStatus
--

IF (SELECT COUNT(*) FROM MessageStatus) = 0
   BEGIN
        DROP TABLE MessageStatus
   END
ELSE
   BEGIN
    print 'Did not drop MessageStatus since rows exists in table'
   END 
GO


--
-- pActive
--

ALTER TABLE pActive ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pActive ADD CONSTRAINT DF_pActive_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pActive
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pActive ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pActive ALTER COLUMN CustomId ADD ROWGUIDCOL
GO


--
-- pColorActivityType
--

ALTER TABLE pColorActivityType ADD ColorActivityTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pColorActivityType ADD CONSTRAINT DF_pColorActivityType_ColorActivityTypeRepId DEFAULT NewId() FOR ColorActivityTypeRepId
GO

UPDATE pColorActivityType
   SET ColorActivityTypeRepId = NewId()
WHERE ColorActivityTypeRepId Is NULL
GO

ALTER TABLE pColorActivityType ALTER COLUMN ColorActivityTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pColorActivityType ALTER COLUMN ColorActivityTypeRepId ADD ROWGUIDCOL
GO

--
-- pComplianceType
--

ALTER TABLE pComplianceType ADD ComplianceTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pComplianceType ADD CONSTRAINT DF_pComplianceType_ComplianceTypeRepId DEFAULT NewId() FOR ComplianceTypeRepId
GO

UPDATE pComplianceType
   SET ComplianceTypeRepId = NewId()
WHERE ComplianceTypeRepId Is NULL
GO

ALTER TABLE pComplianceType ALTER COLUMN ComplianceTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pComplianceType ALTER COLUMN ComplianceTypeRepId ADD ROWGUIDCOL
GO


--
-- pComponentType
--

ALTER TABLE pComponentType ADD ComponentTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pComponentType ADD CONSTRAINT DF_pComponentType_ComponentTypeRepId DEFAULT NewId() FOR ComponentTypeRepId
GO

UPDATE pComponentType
   SET ComponentTypeRepId = NewId()
WHERE ComponentTypeRepId Is NULL
GO

ALTER TABLE pComponentType ALTER COLUMN ComponentTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pComponentType ALTER COLUMN ComponentTypeRepId ADD ROWGUIDCOL
GO


--
-- pConceptStatus
--

ALTER TABLE pConceptStatus ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pConceptStatus ADD CONSTRAINT DF_pConceptStatus_CustomId  DEFAULT NewId() FOR CustomId 
GO

UPDATE pConceptStatus
   SET CustomId  = NewId()
WHERE CustomId  Is NULL
GO

ALTER TABLE pConceptStatus ALTER COLUMN CustomId  uniqueidentifier NOT NULL
GO

ALTER TABLE pConceptStatus ALTER COLUMN CustomId  ADD ROWGUIDCOL
GO

--
-- pConceptType
--

ALTER TABLE pConceptType ADD ConceptTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pConceptType ADD CONSTRAINT DF_pConceptType_ConceptTypeRepId DEFAULT NewId() FOR ConceptTypeRepId 
GO

UPDATE pConceptType
   SET ConceptTypeRepId  = NewId()
WHERE ConceptTypeRepId  Is NULL
GO

ALTER TABLE pConceptType ALTER COLUMN ConceptTypeRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pConceptType ALTER COLUMN ConceptTypeRepId  ADD ROWGUIDCOL
GO


--
-- pControlPanel
--

ALTER TABLE pControlPanel ADD ControlPanelRepId uniqueidentifier NULL
GO

ALTER TABLE pControlPanel ADD CONSTRAINT DF_pControlPanel_ControlPanelRepId DEFAULT NewId() FOR ControlPanelRepId
GO

UPDATE pControlPanel
   SET ControlPanelRepId  = NewId()
WHERE ControlPanelRepId  Is NULL
GO

ALTER TABLE pControlPanel ALTER COLUMN ControlPanelRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pControlPanel ALTER COLUMN ControlPanelRepId  ADD ROWGUIDCOL
GO


--
-- pCurrency
--

ALTER TABLE pCurrency ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pCurrency ADD CONSTRAINT DF_pCurrency_CustomId DEFAULT NewId() FOR CustomId 
GO

UPDATE pCurrency
   SET CustomId  = NewId()
WHERE CustomId  Is NULL
GO

ALTER TABLE pCurrency ALTER COLUMN CustomId  uniqueidentifier NOT NULL
GO

ALTER TABLE pCurrency ALTER COLUMN CustomId  ADD ROWGUIDCOL
GO

--
-- pImageAttributeTable
--

ALTER TABLE pImageAttributeTable ADD ImageAttributeTableRepId uniqueidentifier NULL
GO

ALTER TABLE pImageAttributeTable ADD CONSTRAINT DF_pImageAttributeTable_ImageAttributeTableRepId DEFAULT NewId() FOR ImageAttributeTableRepId 
GO

UPDATE pImageAttributeTable
   SET ImageAttributeTableRepId  = NewId()
WHERE ImageAttributeTableRepId  Is NULL
GO

ALTER TABLE pImageAttributeTable ALTER COLUMN ImageAttributeTableRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pImageAttributeTable ALTER COLUMN ImageAttributeTableRepId  ADD ROWGUIDCOL
GO


--
-- pImageFileType
--

ALTER TABLE pImageFileType ADD ImageFileTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pImageFileType ADD CONSTRAINT DF_pImageFileType_ImageFileTypeRepId DEFAULT NewId() FOR ImageFileTypeRepId
GO

UPDATE pImageFileType
   SET ImageFileTypeRepId  = NewId()
WHERE ImageFileTypeRepId  Is NULL
GO

ALTER TABLE pImageFileType ALTER COLUMN ImageFileTypeRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pImageFileType ALTER COLUMN ImageFileTypeRepId  ADD ROWGUIDCOL
GO


--
-- pImageFileTypeSupport
--

ALTER TABLE pImageFileTypeSupport ADD ImageFileTypeSupportRepId uniqueidentifier NULL
GO

ALTER TABLE pImageFileTypeSupport ADD CONSTRAINT DF_pImageFileTypeSupport_ImageFileTypeSupportRepId DEFAULT NewId() FOR ImageFileTypeSupportRepId
GO

UPDATE pImageFileTypeSupport
   SET ImageFileTypeSupportRepId  = NewId()
WHERE ImageFileTypeSupportRepId  Is NULL
GO

ALTER TABLE pImageFileTypeSupport ALTER COLUMN ImageFileTypeSupportRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pImageFileTypeSupport ALTER COLUMN ImageFileTypeSupportRepId  ADD ROWGUIDCOL
GO

--
-- MessageStatus
--

IF (SELECT COUNT(*) FROM pImageFolder) = 0
   BEGIN
        DROP TABLE pImageFolder
   END
ELSE
   BEGIN
    print 'Did not drop pImageFolder since rows exists in table'
   END 
GO

--
-- pLinePlanStatus
--

ALTER TABLE pLinePlanStatus ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pLinePlanStatus ADD CONSTRAINT DF_pLinePlanStatus_CustomId DEFAULT NewId() FOR CustomId 
GO

UPDATE pLinePlanStatus
   SET CustomId  = NewId()
WHERE CustomId  Is NULL
GO

ALTER TABLE pLinePlanStatus ALTER COLUMN CustomId  uniqueidentifier NOT NULL
GO

ALTER TABLE pLinePlanStatus ALTER COLUMN CustomId  ADD ROWGUIDCOL
GO

--
-- pLinePlanTab
--

ALTER TABLE pLinePlanTab ADD LinePlanTabRepId uniqueidentifier NULL
GO

ALTER TABLE pLinePlanTab ADD CONSTRAINT DF_pLinePlanTab_LinePlanTabRepId DEFAULT NewId() FOR LinePlanTabRepId
GO

UPDATE pLinePlanTab
   SET LinePlanTabRepId  = NewId()
WHERE LinePlanTabRepId  Is NULL
GO

ALTER TABLE pLinePlanTab ALTER COLUMN LinePlanTabRepId  uniqueidentifier NOT NULL
GO

ALTER TABLE pLinePlanTab ALTER COLUMN LinePlanTabRepId  ADD ROWGUIDCOL
GO


--
-- pLinePlanType
--

ALTER TABLE pLinePlanType ADD LinePlanTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pLinePlanType ADD CONSTRAINT DF_pLinePlanType_LinePlanTypeRepId DEFAULT NewId() FOR LinePlanTypeRepId
GO

UPDATE pLinePlanType
   SET LinePlanTypeRepId  = NewId()
WHERE LinePlanTypeRepId  Is NULL
GO

ALTER TABLE pLinePlanType ALTER COLUMN LinePlanTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pLinePlanType ALTER COLUMN LinePlanTypeRepId ADD ROWGUIDCOL
GO


--
-- pMaterialActivityType
--

ALTER TABLE pMaterialActivityType ADD MaterialActivityTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pMaterialActivityType ADD CONSTRAINT DF_pMaterialActivityType_MaterialActivityTypeRepId DEFAULT NewId() FOR MaterialActivityTypeRepId
GO

UPDATE pMaterialActivityType
   SET MaterialActivityTypeRepId  = NewId()
WHERE MaterialActivityTypeRepId  Is NULL
GO

ALTER TABLE pMaterialActivityType ALTER COLUMN MaterialActivityTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialActivityType ALTER COLUMN MaterialActivityTypeRepId ADD ROWGUIDCOL
GO


--
-- pMaterialDesign
--

ALTER TABLE pMaterialDesign ADD MaterialDesignRepId uniqueidentifier NULL
GO

ALTER TABLE pMaterialDesign ADD CONSTRAINT DF_pMaterialDesign_MaterialDesignRepId DEFAULT NewId() FOR MaterialDesignRepId
GO

UPDATE pMaterialDesign
   SET MaterialDesignRepId  = NewId()
WHERE MaterialDesignRepId  Is NULL
GO

ALTER TABLE pMaterialDesign ALTER COLUMN MaterialDesignRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialDesign ALTER COLUMN MaterialDesignRepId ADD ROWGUIDCOL
GO


--
-- pMaterialProcess
--

ALTER TABLE pMaterialProcess ADD MaterialProcessRepId uniqueidentifier NULL
GO

ALTER TABLE pMaterialProcess ADD CONSTRAINT DF_pMaterialProcess_MaterialProcessRepId DEFAULT NewId() FOR MaterialProcessRepId
GO

UPDATE pMaterialProcess
   SET MaterialProcessRepId  = NewId()
WHERE MaterialProcessRepId  Is NULL
GO

ALTER TABLE pMaterialProcess ALTER COLUMN MaterialProcessRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialProcess ALTER COLUMN MaterialProcessRepId ADD ROWGUIDCOL
GO


--
-- pMaterialRequestSubmitStatus
--

ALTER TABLE pMaterialRequestSubmitStatus ADD MaterialRequestSubmitStatusId uniqueidentifier NULL
GO

ALTER TABLE pMaterialRequestSubmitStatus ADD CONSTRAINT DF_pMaterialRequestSubmitStatus_MaterialRequestSubmitStatusId DEFAULT NewId() FOR MaterialRequestSubmitStatusId
GO

UPDATE pMaterialRequestSubmitStatus
   SET MaterialRequestSubmitStatusId  = NewId()
WHERE MaterialRequestSubmitStatusId  Is NULL
GO

ALTER TABLE pMaterialRequestSubmitStatus ALTER COLUMN MaterialRequestSubmitStatusId uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialRequestSubmitStatus ALTER COLUMN MaterialRequestSubmitStatusId ADD ROWGUIDCOL
GO

--
-- pMaterialRequestWorkflow
--

ALTER TABLE pMaterialRequestWorkflow ADD MaterialRequestWorkflowRepId uniqueidentifier NULL
GO

ALTER TABLE pMaterialRequestWorkflow ADD CONSTRAINT DF_pMaterialRequestWorkflow_MaterialRequestWorkflowRepId DEFAULT NewId() FOR MaterialRequestWorkflowRepId
GO

UPDATE pMaterialRequestWorkflow
   SET MaterialRequestWorkflowRepId  = NewId()
WHERE MaterialRequestWorkflowRepId  Is NULL
GO

ALTER TABLE pMaterialRequestWorkflow ALTER COLUMN MaterialRequestWorkflowRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialRequestWorkflow ALTER COLUMN MaterialRequestWorkflowRepId ADD ROWGUIDCOL
GO

--
-- pMaterialTreatment
--

UPDATE pMaterialTreatment
   SET CustomID  = NewId()
WHERE CustomID  Is NULL
GO

ALTER TABLE pMaterialTreatment ALTER COLUMN CustomID uniqueidentifier NOT NULL
GO

ALTER TABLE pMaterialTreatment ALTER COLUMN CustomID ADD ROWGUIDCOL
GO

--
-- pPitchType
--

IF (SELECT COUNT(*) FROM pPitchType) = 0
   BEGIN
        DROP TABLE pPitchType
   END
ELSE
   BEGIN
    print 'Did not drop pPitchType since rows exists in table'
   END 
GO


--
-- pQuoteCostType
--

ALTER TABLE pQuoteCostType ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pQuoteCostType ADD CONSTRAINT DF_pQuoteCostType_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pQuoteCostType
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pQuoteCostType ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pQuoteCostType ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- pQuoteFolderItemStatus
--

ALTER TABLE pQuoteFolderItemStatus ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pQuoteFolderItemStatus ADD CONSTRAINT DF_pQuoteFolderItemStatus_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pQuoteFolderItemStatus
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pQuoteFolderItemStatus ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pQuoteFolderItemStatus ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- pSampleRequestActivity
--

ALTER TABLE pSampleRequestActivity ADD SampleRequestActivityId uniqueidentifier NULL
GO

ALTER TABLE pSampleRequestActivity ADD CONSTRAINT DF_pSampleRequestActivity_SampleRequestActivityId DEFAULT NewId() FOR SampleRequestActivityId
GO

UPDATE pSampleRequestActivity
   SET SampleRequestActivityId  = NewId()
WHERE SampleRequestActivityId  Is NULL
GO

ALTER TABLE pSampleRequestActivity ALTER COLUMN SampleRequestActivityId uniqueidentifier NOT NULL
GO

ALTER TABLE pSampleRequestActivity ALTER COLUMN SampleRequestActivityId ADD ROWGUIDCOL
GO

--
-- pSampleRequestLog
--

ALTER TABLE pSampleRequestLog ADD SampleRequestLogRepId uniqueidentifier NULL
GO

ALTER TABLE pSampleRequestLog ADD CONSTRAINT DF_pSampleRequestLog_SampleRequestLogRepId DEFAULT NewId() FOR SampleRequestLogRepId
GO

UPDATE pSampleRequestLog
   SET SampleRequestLogRepId  = NewId()
WHERE SampleRequestLogRepId  Is NULL
GO

ALTER TABLE pSampleRequestLog ALTER COLUMN SampleRequestLogRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pSampleRequestLog ALTER COLUMN SampleRequestLogRepId ADD ROWGUIDCOL
GO


--
-- pSampleWorkflow
--

ALTER TABLE pSampleWorkflow ADD SampleWorkflowRepId uniqueidentifier NULL
GO

ALTER TABLE pSampleWorkflow ADD CONSTRAINT DF_pSampleWorkflow_SampleWorkflowRepId DEFAULT NewId() FOR SampleWorkflowRepId
GO

UPDATE pSampleWorkflow
   SET SampleWorkflowRepId  = NewId()
 WHERE SampleWorkflowRepId  Is NULL
GO

ALTER TABLE pSampleWorkflow ALTER COLUMN SampleWorkflowRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pSampleWorkflow ALTER COLUMN SampleWorkflowRepId ADD ROWGUIDCOL
GO


--
-- pSizeClass
--
ALTER TABLE pSizeClass ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- pSizerange
--

ALTER TABLE pSizerange ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pSizerange ADD CONSTRAINT DF_pSizerange_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pSizerange
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pSizerange ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pSizerange ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- pSource
--

IF (SELECT COUNT(*) FROM pSource) = 0
   BEGIN
        DROP TABLE pSource
   END
ELSE
   BEGIN
    print 'Did not drop pSource since rows exists in table'
   END 
GO

--
-- pStyleActivityType
--

ALTER TABLE pStyleActivityType ADD StyleActivityTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleActivityType ADD CONSTRAINT DF_pStyleActivityType_StyleActivityTypeRepId DEFAULT NewId() FOR StyleActivityTypeRepId
GO

UPDATE pStyleActivityType
   SET StyleActivityTypeRepId  = NewId()
 WHERE StyleActivityTypeRepId  Is NULL
GO

ALTER TABLE pStyleActivityType ALTER COLUMN StyleActivityTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleActivityType ALTER COLUMN StyleActivityTypeRepId ADD ROWGUIDCOL
GO


--
-- pStyleAttributeTable
--

ALTER TABLE pStyleAttributeTable ADD StyleAttributeTableRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleAttributeTable ADD CONSTRAINT DF_pStyleAttributeTable_StyleAttributeTableRepId DEFAULT NewId() FOR StyleAttributeTableRepId
GO

UPDATE pStyleAttributeTable
   SET StyleAttributeTableRepId  = NewId()
 WHERE StyleAttributeTableRepId  Is NULL
GO

ALTER TABLE pStyleAttributeTable ALTER COLUMN StyleAttributeTableRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleAttributeTable ALTER COLUMN StyleAttributeTableRepId ADD ROWGUIDCOL
GO


--
-- pStyleColorwaySampleStatus
--

ALTER TABLE pStyleColorwaySampleStatus ADD StyleColorwaySampleStatusId uniqueidentifier NULL
GO

ALTER TABLE pStyleColorwaySampleStatus ADD CONSTRAINT DF_pStyleColorwaySampleStatus_StyleColorwaySampleStatusId DEFAULT NewId() FOR StyleColorwaySampleStatusId
GO

UPDATE pStyleColorwaySampleStatus
   SET StyleColorwaySampleStatusId = NewId()
 WHERE StyleColorwaySampleStatusId  Is NULL
GO

ALTER TABLE pStyleColorwaySampleStatus ALTER COLUMN StyleColorwaySampleStatusId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleColorwaySampleStatus ALTER COLUMN StyleColorwaySampleStatusId ADD ROWGUIDCOL
GO

--
-- pStyleColorwayStatus
--

ALTER TABLE pStyleColorwayStatus ADD StyleColorwayStatusId uniqueidentifier NULL
GO

ALTER TABLE pStyleColorwayStatus ADD CONSTRAINT DF_pStyleColorwayStatus_StyleColorwayStatusId DEFAULT NewId() FOR StyleColorwayStatusId
GO

UPDATE pStyleColorwayStatus
   SET StyleColorwayStatusId = NewId()
 WHERE StyleColorwayStatusId  Is NULL
GO

ALTER TABLE pStyleColorwayStatus ALTER COLUMN StyleColorwayStatusId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleColorwayStatus ALTER COLUMN StyleColorwayStatusId ADD ROWGUIDCOL
GO

--
-- pStyleCostFreight
--

ALTER TABLE pStyleCostFreight ADD StyleCostFreightRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleCostFreight ADD CONSTRAINT DF_pStyleCostFreight_StyleCostFreightRepId DEFAULT NewId() FOR StyleCostFreightRepId
GO

UPDATE pStyleCostFreight
   SET StyleCostFreightRepId = NewId()
 WHERE StyleCostFreightRepId  Is NULL
GO

ALTER TABLE pStyleCostFreight ALTER COLUMN StyleCostFreightRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleCostFreight ALTER COLUMN StyleCostFreightRepId ADD ROWGUIDCOL
GO

--
-- pStyleCostFreightType
--

ALTER TABLE pStyleCostFreightType ADD StyleCostFreightTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleCostFreightType ADD CONSTRAINT DF_pStyleCostFreightType_StyleCostFreightTypeRepId DEFAULT NewId() FOR StyleCostFreightTypeRepId
GO

UPDATE pStyleCostFreightType
   SET StyleCostFreightTypeRepId = NewId()
 WHERE StyleCostFreightTypeRepId  Is NULL
GO

ALTER TABLE pStyleCostFreightType ALTER COLUMN StyleCostFreightTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleCostFreightType ALTER COLUMN StyleCostFreightTypeRepId ADD ROWGUIDCOL
GO

--
-- pStyleCostingStatus
--

ALTER TABLE pStyleCostingStatus ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pStyleCostingStatus ADD CONSTRAINT DF_pStyleCostingStatus_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pStyleCostingStatus
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pStyleCostingStatus ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleCostingStatus ALTER COLUMN CustomId ADD ROWGUIDCOL
GO


--
-- pStyleCostingType
--

ALTER TABLE pStyleCostingType ADD StyleCostingTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleCostingType ADD CONSTRAINT DF_pStyleCostingType_StyleCostingTypeRepId DEFAULT NewId() FOR StyleCostingTypeRepId
GO

UPDATE pStyleCostingType
   SET StyleCostingTypeRepId = NewId()
 WHERE StyleCostingTypeRepId  Is NULL
GO

ALTER TABLE pStyleCostingType ALTER COLUMN StyleCostingTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleCostingType ALTER COLUMN StyleCostingTypeRepId ADD ROWGUIDCOL
GO

--
-- pStyleGroup
--

ALTER TABLE pStyleGroup ADD StyleGroupRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleGroup ADD CONSTRAINT DF_pStyleGroup_StyleGroupRepId DEFAULT NewId() FOR StyleGroupRepId
GO

UPDATE pStyleGroup
   SET StyleGroupRepId = NewId()
 WHERE StyleGroupRepId  Is NULL
GO

ALTER TABLE pStyleGroup ALTER COLUMN StyleGroupRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleGroup ALTER COLUMN StyleGroupRepId ADD ROWGUIDCOL
GO


--
-- pStyleQuoteItemActivity
--

ALTER TABLE pStyleQuoteItemActivity ADD StyleQuoteItemActivityRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleQuoteItemActivity ADD CONSTRAINT DF_pStyleQuoteItemActivity_StyleQuoteItemActivityRepId  DEFAULT NewId() FOR StyleQuoteItemActivityRepId
GO

UPDATE pStyleQuoteItemActivity
   SET StyleQuoteItemActivityRepId  = NewId()
 WHERE StyleQuoteItemActivityRepId   Is NULL
GO

ALTER TABLE pStyleQuoteItemActivity ALTER COLUMN StyleQuoteItemActivityRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleQuoteItemActivity ALTER COLUMN StyleQuoteItemActivityRepId ADD ROWGUIDCOL
GO

--
-- pStyleQuoteItemStatus
--

ALTER TABLE pStyleQuoteItemStatus ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE pStyleQuoteItemStatus ADD CONSTRAINT DF_pStyleQuoteItemStatus_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE pStyleQuoteItemStatus
   SET CustomId = NewId()
WHERE CustomId Is NULL
GO

ALTER TABLE pStyleQuoteItemStatus ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleQuoteItemStatus ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- pStyleSeason
--

ALTER TABLE pStyleSeason ADD StyleSeasonRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleSeason ADD CONSTRAINT DF_pStyleSeason_StyleSeasonRepId  DEFAULT NewId() FOR StyleSeasonRepId
GO

UPDATE pStyleSeason
   SET StyleSeasonRepId = NewId()
 WHERE StyleSeasonRepId   Is NULL
GO

ALTER TABLE pStyleSeason ALTER COLUMN StyleSeasonRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleSeason ALTER COLUMN StyleSeasonRepId ADD ROWGUIDCOL
GO

--
-- pStyleSize
--

ALTER TABLE pStyleSize ADD StyleSizeRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleSize ADD CONSTRAINT DF_pStyleSize_StyleSizeRepId  DEFAULT NewId() FOR StyleSizeRepId
GO

UPDATE pStyleSize
   SET StyleSizeRepId = NewId()
 WHERE StyleSizeRepId   Is NULL
GO

ALTER TABLE pStyleSize ALTER COLUMN StyleSizeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleSize ALTER COLUMN StyleSizeRepId ADD ROWGUIDCOL
GO


--
-- pStyleStatus
--

ALTER TABLE pStyleStatus ADD StyleStatusId uniqueidentifier NULL
GO

ALTER TABLE pStyleStatus ADD CONSTRAINT DF_pStyleStatus_StyleStatusId  DEFAULT NewId() FOR StyleStatusId
GO

UPDATE pStyleStatus
   SET StyleStatusId = NewId()
 WHERE StyleStatusId   Is NULL
GO

ALTER TABLE pStyleStatus ALTER COLUMN StyleStatusId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleStatus ALTER COLUMN StyleStatusId ADD ROWGUIDCOL
GO

--
-- pStyleType
--

ALTER TABLE pStyleType ADD StyleTypeRepId uniqueidentifier NULL
GO

ALTER TABLE pStyleType ADD CONSTRAINT DF_pStyleType_StyleTypeRepId  DEFAULT NewId() FOR StyleTypeRepId
GO

UPDATE pStyleType
   SET StyleTypeRepId = NewId()
 WHERE StyleTypeRepId  Is NULL
GO

ALTER TABLE pStyleType ALTER COLUMN StyleTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pStyleType ALTER COLUMN StyleTypeRepId ADD ROWGUIDCOL
GO

--
-- pTechPackActivity
--

ALTER TABLE pTechPackActivity ADD TechPackActivityRepId uniqueidentifier NULL
GO

ALTER TABLE pTechPackActivity ADD CONSTRAINT DF_pTechPackActivity_TechPackActivityRepId  DEFAULT NewId() FOR TechPackActivityRepId
GO

UPDATE pTechPackActivity
   SET TechPackActivityRepId = NewId()
 WHERE TechPackActivityRepId  Is NULL
GO

ALTER TABLE pTechPackActivity ALTER COLUMN TechPackActivityRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pTechPackActivity ALTER COLUMN TechPackActivityRepId ADD ROWGUIDCOL
GO


--
-- pTechPackLog
--

ALTER TABLE pTechPackLog ADD TechPackLogRepId uniqueidentifier NULL
GO

ALTER TABLE pTechPackLog ADD CONSTRAINT DF_pTechPackLog_TechPackLogRepId  DEFAULT NewId() FOR TechPackLogRepId
GO

UPDATE pTechPackLog
   SET TechPackLogRepId = NewId()
 WHERE TechPackLogRepId  Is NULL
GO

ALTER TABLE pTechPackLog ALTER COLUMN TechPackLogRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pTechPackLog ALTER COLUMN TechPackLogRepId ADD ROWGUIDCOL
GO

--
-- pTechPackMessage
--

ALTER TABLE pTechPackMessage ADD TechPackMessageRepId uniqueidentifier NULL
GO

ALTER TABLE pTechPackMessage ADD CONSTRAINT DF_pTechPackMessage_TechPackMessageRepId  DEFAULT NewId() FOR TechPackMessageRepId
GO

UPDATE pTechPackMessage
   SET TechPackMessageRepId = NewId()
 WHERE TechPackMessageRepId  Is NULL
GO

ALTER TABLE pTechPackMessage ALTER COLUMN TechPackMessageRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pTechPackMessage ALTER COLUMN TechPackMessageRepId ADD ROWGUIDCOL
GO

--
-- pTradingPartner
--

IF (SELECT COUNT(*) FROM pTradingPartner) = 0
   BEGIN
        DROP TABLE pTradingPartner
   END
ELSE
   BEGIN
    print 'Did not drop pTradingPartner since rows exists in table'
   END 
GO

--
-- pWorkflowStatus
--

ALTER TABLE pWorkflowStatus ADD WorkflowStatusRepId uniqueidentifier NULL
GO

ALTER TABLE pWorkflowStatus ADD CONSTRAINT DF_pWorkflowStatus_WorkflowStatusRepId  DEFAULT NewId() FOR WorkflowStatusRepId
GO

UPDATE pWorkflowStatus
   SET WorkflowStatusRepId = NewId()
 WHERE WorkflowStatusRepId  Is NULL
GO

ALTER TABLE pWorkflowStatus ALTER COLUMN WorkflowStatusRepId uniqueidentifier NOT NULL
GO

ALTER TABLE pWorkflowStatus ALTER COLUMN WorkflowStatusRepId ADD ROWGUIDCOL
GO


--
-- QuotationCostType
--

ALTER TABLE QuotationCostType ADD QuotationCostTypeId uniqueidentifier NULL
GO

ALTER TABLE QuotationCostType ADD CONSTRAINT DF_QuotationCostType_QuotationCostTypeId  DEFAULT NewId() FOR QuotationCostTypeId
GO

UPDATE QuotationCostType
   SET QuotationCostTypeId = NewId()
 WHERE QuotationCostTypeId  Is NULL
GO

ALTER TABLE QuotationCostType ALTER COLUMN QuotationCostTypeId uniqueidentifier NOT NULL
GO

ALTER TABLE QuotationCostType ALTER COLUMN QuotationCostTypeId ADD ROWGUIDCOL
GO


--
-- QuotationStatus
--

ALTER TABLE QuotationStatus ADD QuotationStatusRepId uniqueidentifier NULL
GO

ALTER TABLE QuotationStatus ADD CONSTRAINT DF_QuotationStatus_QuotationStatusRepId  DEFAULT NewId() FOR QuotationStatusRepId
GO

UPDATE QuotationStatus
   SET QuotationStatusRepId = NewId()
 WHERE QuotationStatusRepId  Is NULL
GO

ALTER TABLE QuotationStatus ALTER COLUMN QuotationStatusRepId uniqueidentifier NOT NULL
GO

ALTER TABLE QuotationStatus ALTER COLUMN QuotationStatusRepId ADD ROWGUIDCOL
GO

--
-- rReportFormat
--

ALTER TABLE rReportFormat ADD ReportFormatRepId uniqueidentifier NULL
GO

ALTER TABLE rReportFormat ADD CONSTRAINT DF_rReportFormat_ReportFormatRepId  DEFAULT NewId() FOR ReportFormatRepId
GO

UPDATE rReportFormat
   SET ReportFormatRepId = NewId()
 WHERE ReportFormatRepId  Is NULL
GO

ALTER TABLE rReportFormat ALTER COLUMN ReportFormatRepId uniqueidentifier NOT NULL
GO

ALTER TABLE rReportFormat ALTER COLUMN ReportFormatRepId ADD ROWGUIDCOL
GO

--
-- rReportHeader
--

ALTER TABLE rReportHeader ADD ReportHeaderRepId uniqueidentifier NULL
GO

ALTER TABLE rReportHeader ADD CONSTRAINT DF_rReportHeader_ReportHeaderRepId  DEFAULT NewId() FOR ReportHeaderRepId
GO

UPDATE rReportHeader
   SET ReportHeaderRepId = NewId()
 WHERE ReportHeaderRepId  Is NULL
GO

ALTER TABLE rReportHeader ALTER COLUMN ReportHeaderRepId uniqueidentifier NOT NULL
GO

ALTER TABLE rReportHeader ALTER COLUMN ReportHeaderRepId ADD ROWGUIDCOL
GO

--
-- rReportsetting
--

ALTER TABLE rReportsetting ADD ReportsettingId uniqueidentifier NULL
GO

ALTER TABLE rReportsetting ADD CONSTRAINT DF_rReportsetting_ReportsettingId  DEFAULT NewId() FOR ReportsettingId
GO

UPDATE rReportsetting
   SET ReportsettingId = NewId()
 WHERE ReportsettingId  Is NULL
GO

ALTER TABLE rReportsetting ALTER COLUMN ReportsettingId uniqueidentifier NOT NULL
GO

ALTER TABLE rReportsetting ALTER COLUMN ReportsettingId ADD ROWGUIDCOL
GO

--
-- rReportTable
--

ALTER TABLE rReportTable ADD ReportTableRepId uniqueidentifier NULL
GO

ALTER TABLE rReportTable ADD CONSTRAINT DF_rReportTable_ReportTableRepId   DEFAULT NewId() FOR ReportTableRepId 
GO

UPDATE rReportTable
   SET ReportTableRepId  = NewId()
 WHERE ReportTableRepId   Is NULL
GO

ALTER TABLE rReportTable ALTER COLUMN ReportTableRepId uniqueidentifier NOT NULL
GO

ALTER TABLE rReportTable ALTER COLUMN ReportTableRepId ADD ROWGUIDCOL
GO


--
-- sAccessRole
--

ALTER TABLE sAccessRole ADD AccessRoleRepId uniqueidentifier NULL
GO

ALTER TABLE sAccessRole ADD CONSTRAINT DF_sAccessRole_AccessRoleRepId   DEFAULT NewId() FOR AccessRoleRepId
GO

UPDATE sAccessRole
   SET AccessRoleRepId  = NewId()
 WHERE AccessRoleRepId   Is NULL
GO

ALTER TABLE sAccessRole ALTER COLUMN AccessRoleRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sAccessRole ALTER COLUMN AccessRoleRepId ADD ROWGUIDCOL
GO

--
-- sActivityType
--

ALTER TABLE sActivityType ADD ActivityTypeRepId uniqueidentifier NULL
GO

ALTER TABLE sActivityType ADD CONSTRAINT DF_sActivityType_ActivityTypeRepId   DEFAULT NewId() FOR ActivityTypeRepId
GO

UPDATE sActivityType
   SET ActivityTypeRepId  = NewId()
 WHERE ActivityTypeRepId   Is NULL
GO

ALTER TABLE sActivityType ALTER COLUMN ActivityTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sActivityType ALTER COLUMN ActivityTypeRepId ADD ROWGUIDCOL
GO

--
-- SampleApprovalStatus
--

IF (SELECT COUNT(*) FROM SampleApprovalStatus) = 0
   BEGIN
        DROP TABLE SampleApprovalStatus
   END
ELSE
   BEGIN
    print 'Did not drop SampleApprovalStatus since rows exists in table'
   END 
GO


--
-- SampleStatus
--

IF (SELECT COUNT(*) FROM SampleStatus) = 0
   BEGIN
        DROP TABLE SampleStatus
   END
ELSE
   BEGIN
    print 'Did not drop SampleStatus since rows exists in table'
   END 
GO

--
-- sCurrencyType
--

ALTER TABLE sCurrencyType ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- sDelivery
--

ALTER TABLE sDelivery ADD DeliveryId uniqueidentifier NULL
GO

ALTER TABLE sDelivery ADD CONSTRAINT DF_sDelivery_DeliveryId DEFAULT NewId() FOR DeliveryId
GO

UPDATE sDelivery
   SET DeliveryId  = NewId()
 WHERE DeliveryId   Is NULL
GO

ALTER TABLE sDelivery ALTER COLUMN DeliveryId uniqueidentifier NOT NULL
GO

ALTER TABLE sDelivery ALTER COLUMN DeliveryId ADD ROWGUIDCOL
GO

--
-- sDeskMenu
--

ALTER TABLE sDeskMenu ADD DeskMenuRepId uniqueidentifier NULL
GO

ALTER TABLE sDeskMenu ADD CONSTRAINT DF_sDeskMenu_DeskMenuRepId DEFAULT NewId() FOR DeskMenuRepId
GO

UPDATE sDeskMenu
   SET DeskMenuRepId  = NewId()
 WHERE DeskMenuRepId   Is NULL
GO

ALTER TABLE sDeskMenu ALTER COLUMN DeskMenuRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sDeskMenu ALTER COLUMN DeskMenuRepId ADD ROWGUIDCOL
GO

--
-- sDeskMenuType
--

ALTER TABLE sDeskMenuType ADD DeskMenuTypeRepId uniqueidentifier NULL
GO

ALTER TABLE sDeskMenuType ADD CONSTRAINT DF_sDeskMenuType_DeskMenuTypeRepId DEFAULT NewId() FOR DeskMenuTypeRepId
GO

UPDATE sDeskMenuType
   SET DeskMenuTypeRepId  = NewId()
 WHERE DeskMenuTypeRepId   Is NULL
GO

ALTER TABLE sDeskMenuType ALTER COLUMN DeskMenuTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sDeskMenuType ALTER COLUMN DeskMenuTypeRepId ADD ROWGUIDCOL
GO

--
-- sDeskTop
--

ALTER TABLE sDeskTop ADD DeskTopRepId uniqueidentifier NULL
GO

ALTER TABLE sDeskTop ADD CONSTRAINT DF_sDeskTop_DeskTopRepId DEFAULT NewId() FOR DeskTopRepId
GO

UPDATE sDeskTop
   SET DeskTopRepId  = NewId()
 WHERE DeskTopRepId   Is NULL
GO

ALTER TABLE sDeskTop ALTER COLUMN DeskTopRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sDeskTop ALTER COLUMN DeskTopRepId ADD ROWGUIDCOL
GO

--
-- ShipMethod
--

ALTER TABLE ShipMethod ADD ShipMethodId uniqueidentifier NULL
GO

ALTER TABLE ShipMethod ADD CONSTRAINT DF_ShipMethod_ShipMethodId DEFAULT NewId() FOR ShipMethodId
GO

UPDATE ShipMethod
   SET ShipMethodId  = NewId()
 WHERE ShipMethodId   Is NULL
GO

ALTER TABLE ShipMethod ALTER COLUMN ShipMethodId uniqueidentifier NOT NULL
GO

ALTER TABLE ShipMethod ALTER COLUMN ShipMethodId ADD ROWGUIDCOL
GO


--
-- sSystem
--

ALTER TABLE sSystem ADD SystemId uniqueidentifier NULL
GO

ALTER TABLE sSystem ADD CONSTRAINT DF_sSystem_SystemId DEFAULT NewId() FOR SystemId
GO

UPDATE sSystem
   SET SystemId  = NewId()
 WHERE SystemId   Is NULL
GO

ALTER TABLE sSystem ALTER COLUMN SystemId uniqueidentifier NOT NULL
GO

ALTER TABLE sSystem ALTER COLUMN SystemId ADD ROWGUIDCOL
GO

--
-- sSystemCulture
--

ALTER TABLE sSystemCulture ADD SystemCultureId uniqueidentifier NULL
GO

ALTER TABLE sSystemCulture ADD CONSTRAINT DF_sSystemCulture_SystemCultureId DEFAULT NewId() FOR SystemCultureId
GO

UPDATE sSystemCulture
   SET SystemCultureId  = NewId()
 WHERE SystemCultureId   Is NULL
GO

ALTER TABLE sSystemCulture ALTER COLUMN SystemCultureId uniqueidentifier NOT NULL
GO

ALTER TABLE sSystemCulture ALTER COLUMN SystemCultureId ADD ROWGUIDCOL
GO

--
-- sTempId
--

ALTER TABLE sTempId ADD TempRepId uniqueidentifier NULL
GO

ALTER TABLE sTempId ADD CONSTRAINT DF_sTempId_TempRepId DEFAULT NewId() FOR TempRepId
GO

UPDATE sTempId
   SET TempRepId = NewId()
 WHERE TempRepId   Is NULL
GO

ALTER TABLE sTempId ALTER COLUMN TempRepId uniqueidentifier NOT NULL
GO

ALTER TABLE sTempId ALTER COLUMN TempRepId ADD ROWGUIDCOL
GO

--
-- StitchType
--

ALTER TABLE StitchType ADD StitchTypeRepId uniqueidentifier NULL
GO

ALTER TABLE StitchType ADD CONSTRAINT DF_StitchType_StitchTypeRepId DEFAULT NewId() FOR StitchTypeRepId
GO

UPDATE StitchType
   SET StitchTypeRepId  = NewId()
 WHERE StitchTypeRepId   Is NULL
GO

ALTER TABLE StitchType ALTER COLUMN StitchTypeRepId uniqueidentifier NOT NULL
GO

ALTER TABLE StitchType ALTER COLUMN StitchTypeRepId ADD ROWGUIDCOL
GO

--
-- tTaskStatus
--

IF (SELECT COUNT(*) FROM tTaskStatus) = 0
   BEGIN
        DROP TABLE tTaskStatus
   END
ELSE
   BEGIN
    print 'Did not drop tTaskStatus since rows exists in table'
   END 
GO


--
-- UOM
--

ALTER TABLE UOM ADD UOMId uniqueidentifier NULL
GO

ALTER TABLE UOM ADD CONSTRAINT DF_UOM_UOMId DEFAULT NewId() FOR UOMId
GO

UPDATE UOM
   SET UOMId  = NewId()
 WHERE UOMId   Is NULL
GO

ALTER TABLE UOM ALTER COLUMN UOMId uniqueidentifier NOT NULL
GO

ALTER TABLE UOM ALTER COLUMN UOMId ADD ROWGUIDCOL
GO

--
-- uState
--

ALTER TABLE uState ADD uStateId uniqueidentifier NULL
GO

ALTER TABLE uState ADD CONSTRAINT DF_UOM_uStateId DEFAULT NewId() FOR uStateId
GO

UPDATE uState
   SET uStateId  = NewId()
 WHERE uStateId   Is NULL
GO

ALTER TABLE uState ALTER COLUMN uStateId uniqueidentifier NOT NULL
GO

ALTER TABLE uState ALTER COLUMN uStateId ADD ROWGUIDCOL
GO

--
-- uTradePartnerClass
--

ALTER TABLE uTradePartnerClass ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE uTradePartnerClass ADD CONSTRAINT DF_uTradePartnerClass_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE uTradePartnerClass
   SET CustomId  = NewId()
 WHERE CustomId   Is NULL
GO

ALTER TABLE uTradePartnerClass ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE uTradePartnerClass ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- uTradePartnerContactTab
--

ALTER TABLE uTradePartnerContactTab ADD TradePartnerContactTabRepId uniqueidentifier NULL
GO

ALTER TABLE uTradePartnerContactTab ADD CONSTRAINT DF_uTradePartnerContactTab_TradePartnerContactTabRepId DEFAULT NewId() FOR TradePartnerContactTabRepId
GO

UPDATE uTradePartnerContactTab
   SET TradePartnerContactTabRepId  = NewId()
 WHERE TradePartnerContactTabRepId   Is NULL
GO

ALTER TABLE uTradePartnerContactTab ALTER COLUMN TradePartnerContactTabRepId uniqueidentifier NOT NULL
GO

ALTER TABLE uTradePartnerContactTab ALTER COLUMN TradePartnerContactTabRepId ADD ROWGUIDCOL
GO

--
-- uTradePartnerType
--

ALTER TABLE uTradePartnerType ADD CustomId uniqueidentifier NULL
GO

ALTER TABLE uTradePartnerType ADD CONSTRAINT DF_uTradePartnerType_CustomId DEFAULT NewId() FOR CustomId
GO

UPDATE uTradePartnerType
   SET CustomId  = NewId()
 WHERE CustomId   Is NULL
GO

ALTER TABLE uTradePartnerType ALTER COLUMN CustomId uniqueidentifier NOT NULL
GO

ALTER TABLE uTradePartnerType ALTER COLUMN CustomId ADD ROWGUIDCOL
GO

--
-- Add ROWGUIDCOl Property to tables that have primary key of uniqueidentifier
--

BEGIN
         DECLARE @vTableName        varchar(100),
                 @ColumnName        varchar(100),
                 @IsRowGuid         int,
                 @vSQL              varchar(2000)

         DECLARE Table2Process INSENSITIVE CURSOR
                 FOR SELECT TCC.TABLE_NAME,TCC.COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS TCC , (
                    select TB.TABLE_NAME, KC.COLUMN_NAME 
                      from INFORMATION_SCHEMA.Tables TB, 
                           INFORMATION_SCHEMA.KEY_COLUMN_USAGE KC
                     where TB.TABLE_TYPE <> 'VIEW'
                       and TB.TABLE_NAME not like 'ASP%'
                       and TB.TABLE_NAME not in (SELECT o.name as [Table_Name]
                                                 FROM syscolumns c
                                                 inner join sysobjects o on o.id = c.id 			
                                                 WHERE COLUMNPROPERTY(o.id, c.name, 'IsRowGuidCol') = 1
                                                 AND o.name not like 'ASP%')
                       AND TB.TABLE_NAME = KC.TABLE_NAME
                       and kc.CONSTRAINT_NAME like 'PK%'
                       --ORDER BY TB.TABLE_NAME 
                       ) KC2
                      WHERE TCC.TABLE_NAME = KC2.TABLE_NAME
                        AND TCC.COLUMN_NAME = KC2.COLUMN_NAME
                        AND TCC.DATA_TYPE   = 'uniqueidentifier'
                      ORDER BY 1
             FOR READ ONLY

           OPEN Table2Process 

           FETCH NEXT FROM Table2Process INTO @vTableName, @ColumnName

           WHILE @@FETCH_STATUS = 0
            BEGIN

                  SET @vSQL = null
                  SET @VSQL = 'ALTER TABLE ' + @vTableName + ' ALTER COLUMN ' + @ColumnName + ' ADD ROWGUIDCOL'
                  
                  EXEC (@vSQL)
                  --PRINT 'Statment: ' + @vSQL

                  IF @@error <> 0
                     BEGIN
                           PRINT 'Statment Failed: ' + @vSQL
                           goto error
                     END

              FETCH NEXT FROM Table2Process INTO @vTableName,  @ColumnName
            END

error:
        CLOSE Table2Process
	DEALLOCATE Table2Process
bottom:
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01417', GETDATE())
GO


