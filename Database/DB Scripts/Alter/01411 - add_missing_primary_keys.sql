DROP TABLE pImage_Copy
GO

DROP TABLE ColorLibrary_backup20100902
GO

DROP TABLE pStyleColorStandard$_old
GO

DROP TABLE pTemplateDetailGridRobbie
GO

DROP TABLE xCustom1Dan
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendar' )
BEGIN
    ALTER TABLE cCalendar ADD cCalendarId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE cCalendar SET cCalendarId = newid() WHERE cCalendarId Is NULL
GO

ALTER TABLE cCalendar ALTER COLUMN cCalendarId uniqueidentifier not null
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendar' )
BEGIN
     ALTER TABLE cCalendar  ADD CONSTRAINT PK_cCalendar PRIMARY KEY CLUSTERED (cCalendarId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendarEvent' )
BEGIN
    ALTER TABLE cCalendarEvent  ADD CONSTRAINT PK_cCalendarEvent PRIMARY KEY CLUSTERED (CalendarEventId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendarMeeting' )
BEGIN
    ALTER TABLE cCalendarMeeting ADD cCalendarMeetingId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE cCalendarMeeting SET cCalendarMeetingId = newid() WHERE cCalendarMeetingId Is NULL
GO

ALTER TABLE cCalendarMeeting ALTER COLUMN cCalendarMeetingId uniqueidentifier not null
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendarMeeting' )
BEGIN
    ALTER TABLE cCalendarMeeting  ADD CONSTRAINT PK_cCalendarMeeting PRIMARY KEY CLUSTERED (cCalendarMeetingId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendarTemplate' )
BEGIN
    ALTER TABLE cCalendarTemplate ADD cCalendarTemplateId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE cCalendarTemplate SET cCalendarTemplateId = newid() WHERE cCalendarTemplateId Is NULL
GO

ALTER TABLE cCalendarTemplate ALTER COLUMN cCalendarTemplateId uniqueidentifier not null
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'cCalendarTemplate' )
BEGIN
    ALTER TABLE cCalendarTemplate  ADD CONSTRAINT PK_cCalendarTemplate PRIMARY KEY CLUSTERED (cCalendarTemplateId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'eMailContactType' )
BEGIN
    ALTER TABLE eMailContactType ADD eMailContactTypeId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE eMailContactType SET eMailContactTypeId = newid() WHERE eMailContactTypeId Is NULL
GO

ALTER TABLE eMailContactType ALTER COLUMN eMailContactTypeId uniqueidentifier not null
GO
IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'eMailContactType' )
BEGIN
    ALTER TABLE eMailContactType  ADD CONSTRAINT PK_eMailContactType PRIMARY KEY CLUSTERED (eMailContactTypeId)
END
GO


UPDATE eMailMessage SET MessageID = newid() WHERE MessageID Is NULL
GO

ALTER TABLE eMailMessage ALTER COLUMN MessageID DROP ROWGUIDCOL
GO

ALTER TABLE eMailMessage ADD CONSTRAINT DF_eMailMessage_MessageID DEFAULT newid() FOR MessageID
GO


ALTER TABLE eMailMessage ALTER COLUMN MessageID uniqueidentifier  not null
GO

ALTER TABLE eMailMessage ALTER COLUMN MessageID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'eMailMessage' )
BEGIN
    ALTER TABLE eMailMessage  ADD CONSTRAINT PK_eMailMessage PRIMARY KEY CLUSTERED (MessageId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'eMessageFolder' )
BEGIN
    ALTER TABLE eMessageFolder ADD eMessageFolderId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE eMessageFolder SET eMessageFolderID = newid() WHERE eMessageFolderID Is NULL
GO

ALTER TABLE eMessageFolder ALTER COLUMN eMessageFolderID uniqueidentifier  not null
GO

ALTER TABLE eMessageFolder ALTER COLUMN eMessageFolderID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'eMessageFolder' )
BEGIN
    ALTER TABLE eMessageFolder  ADD CONSTRAINT PK_eMessageFolder PRIMARY KEY CLUSTERED (eMessageFolderId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'iCustom20' )
BEGIN
    ALTER TABLE iCustom20  ADD CONSTRAINT PK_iCustom20 PRIMARY KEY CLUSTERED (CustomId)
END
GO


ALTER TABLE pBody ADD CONSTRAINT DF_pBody_BodyID DEFAULT newid() FOR BodyID
GO

UPDATE pBody SET BodyID = newid() WHERE BodyID Is NULL
GO

ALTER TABLE pBody ALTER COLUMN BodyID uniqueidentifier  not null
GO

ALTER TABLE pBody ALTER COLUMN BodyID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBody' )
BEGIN
    ALTER TABLE pBody  ADD CONSTRAINT PK_pBody PRIMARY KEY CLUSTERED (BodyId)
END
GO


ALTER TABLE pBodyDevelopment ADD CONSTRAINT DF_pBodyDevelopment_BodyDevelopmentID DEFAULT newid() FOR BodyDevelopmentID
GO

UPDATE pBodyDevelopment SET BodyDevelopmentID= newid() WHERE BodyDevelopmentID Is NULL
GO

ALTER TABLE pBodyDevelopment ALTER COLUMN BodyDevelopmentID uniqueidentifier  not null
GO

ALTER TABLE pBodyDevelopment ALTER COLUMN BodyDevelopmentID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyDevelopment' )
BEGIN
    ALTER TABLE pBodyDevelopment  ADD CONSTRAINT PK_BodyDevelopment PRIMARY KEY CLUSTERED (BodyDevelopmentID)
END
GO


ALTER TABLE pBodyDevelopmentItem ADD CONSTRAINT DF_pBodyDevelopment_BodyDevelopmentItemID DEFAULT newid() FOR BodyDevelopmentItemID
GO

UPDATE pBodyDevelopmentItem SET BodyDevelopmentItemID= newid() WHERE BodyDevelopmentItemID Is NULL
GO

ALTER TABLE pBodyDevelopmentItem ALTER COLUMN BodyDevelopmentItemID uniqueidentifier  not null
GO

ALTER TABLE pBodyDevelopmentItem ALTER COLUMN BodyDevelopmentItemID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyDevelopmentItem' )
BEGIN
    ALTER TABLE pBodyDevelopmentItem  ADD CONSTRAINT PK_pBodyDevelopmentItem PRIMARY KEY CLUSTERED (BodyDevelopmentItemID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyImage' )
BEGIN
    ALTER TABLE pBodyImage ADD BodyImageId uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE pBodyImage SET BodyImageID =newid() WHERE BodyImageID Is NULL
GO

ALTER TABLE pBodyImage ALTER COLUMN BodyImageID uniqueidentifier  not null
GO

ALTER TABLE pBodyImage ALTER COLUMN BodyImageID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyImage' )
BEGIN
    ALTER TABLE pBodyImage  ADD CONSTRAINT PK_pBodyImage PRIMARY KEY CLUSTERED (BodyImageID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodySpecSize' )
BEGIN
    ALTER TABLE pBodySpecSize ADD BodySpecSizeID uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE pBodySpecSize SET BodySpecSizeID =newid() WHERE BodySpecSizeID Is NULL
GO

ALTER TABLE pBodySpecSize ALTER COLUMN BodySpecSizeID uniqueidentifier  not null
GO

ALTER TABLE pBodySpecSize ALTER COLUMN BodySpecSizeID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodySpecSize' )
BEGIN
    ALTER TABLE pBodySpecSize  ADD CONSTRAINT PK_pBodySpecSize PRIMARY KEY CLUSTERED (BodySpecSizeID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyType' )
BEGIN
    ALTER TABLE pBodyType ADD pBodyTypeID uniqueidentifier DEFAULT NEWSEQUENTIALID ()
END
GO

UPDATE pBodyType SET pBodyTypeID =newid() WHERE pBodyTypeID Is NULL
GO

ALTER TABLE pBodyType ALTER COLUMN pBodyTypeID uniqueidentifier  not null
GO

ALTER TABLE pBodyType ALTER COLUMN pBodyTypeID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyType' )
BEGIN
    ALTER TABLE pBodyType  ADD CONSTRAINT PK_pBodyType PRIMARY KEY CLUSTERED (pBodyTypeID)
END
GO


UPDATE pBodyWorkflow SET BodyWorkflowID =newid() WHERE BodyWorkflowID Is NULL
GO

ALTER TABLE pBodyWorkflow ALTER COLUMN BodyWorkflowID uniqueidentifier  not null
GO

ALTER TABLE pBodyWorkflow ALTER COLUMN BodyWorkflowID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pBodyWorkflow' )
BEGIN
    ALTER TABLE pBodyWorkflow  ADD CONSTRAINT PK_pBodyWorkflow PRIMARY KEY CLUSTERED (BodyWorkflowID)
END
GO


UPDATE pColorPaletteComment SET ColorPaletteCommentID =newid() WHERE ColorPaletteCommentID Is NULL
GO

ALTER TABLE pColorPaletteComment ALTER COLUMN ColorPaletteCommentID uniqueidentifier  not null
GO

ALTER TABLE pColorPaletteComment ALTER COLUMN ColorPaletteCommentID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pColorPaletteComment' )
BEGIN
    ALTER TABLE pColorPaletteComment ADD CONSTRAINT PK_pColorPaletteComment PRIMARY KEY CLUSTERED (ColorPaletteCommentID)
END
GO


ALTER TABLE pColorPaletteDocument ADD CONSTRAINT DF_pColorPaletteDocument_ColorPaletteDocumentID DEFAULT newid() FOR ColorPaletteDocumentID
GO

UPDATE pColorPaletteDocument SET ColorPaletteDocumentID =newid() WHERE ColorPaletteDocumentID Is NULL
GO

ALTER TABLE pColorPaletteDocument ALTER COLUMN ColorPaletteDocumentID uniqueidentifier  not null
GO

ALTER TABLE pColorPaletteDocument ALTER COLUMN ColorPaletteDocumentId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pColorPaletteDocument' )
BEGIN
    ALTER TABLE pColorPaletteDocument ADD CONSTRAINT PK_pColorPaletteDocument PRIMARY KEY CLUSTERED (ColorPaletteDocumentID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pColorType' )
BEGIN
    ALTER TABLE pColorType ADD pColorTypeId uniqueidentifier
END
GO

ALTER TABLE pColorType ADD CONSTRAINT DF_pColorType_pColorTypeID DEFAULT newid() FOR pColorTypeID
GO

UPDATE pColorType SET pColorTypeID =newid() WHERE pColorTypeID Is NULL
GO

ALTER TABLE pColorType ALTER COLUMN pColorTypeID uniqueidentifier  not null
GO

ALTER TABLE pColorType ALTER COLUMN pColorTypeId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pColorType' )
BEGIN
    ALTER TABLE pColorType ADD CONSTRAINT PK_pColorType PRIMARY KEY CLUSTERED (pColorTypeID)
END
GO



IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pImageMultiPage' )
BEGIN
    ALTER TABLE pImageMultiPage ADD CONSTRAINT PK_pImageMultiPage PRIMARY KEY CLUSTERED (ImageMultiPageID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanAttributeType' )
BEGIN
    ALTER TABLE pLinePlanAttributeType ADD pLinePlanAttributeTypeId uniqueidentifier
END
GO

ALTER TABLE pLinePlanAttributeType ADD CONSTRAINT DF_pLinePlanAttributeType_pLinePlanAttributeTypeId DEFAULT newid() FOR pLinePlanAttributeTypeID
GO

UPDATE pLinePlanAttributeType SET pLinePlanAttributeTypeID =newid() WHERE pLinePlanAttributeTypeID Is NULL
GO

ALTER TABLE pLinePlanAttributeType ALTER COLUMN pLinePlanAttributeTypeID uniqueidentifier  not null
GO

ALTER TABLE pLinePlanAttributeType ALTER COLUMN pLinePlanAttributeTypeId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanAttributeType' )
BEGIN
    ALTER TABLE pLinePlanAttributeType ADD CONSTRAINT PK_pLinePlanAttributeType PRIMARY KEY CLUSTERED (pLinePlanAttributeTypeID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanBusiness' )
BEGIN
    ALTER TABLE pLinePlanBusiness ADD CONSTRAINT PK_pLinePlanBusiness PRIMARY KEY CLUSTERED (LinePlanBusinessID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanBusinessItem' )
BEGIN
    ALTER TABLE pLinePlanBusinessItem ADD CONSTRAINT PK_pLinePlanBusinessItem PRIMARY KEY CLUSTERED (LinePlanBusinessItemID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanItemAttributeType' )
BEGIN
    ALTER TABLE pLinePlanItemAttributeType ADD CONSTRAINT PK_pLinePlanItemAttributeType PRIMARY KEY CLUSTERED (LinePlanItemAttribueTypeID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanItemTemp' )
BEGIN
    ALTER TABLE pLinePlanItemTemp ADD LinePlanItemTempId uniqueidentifier
END
GO

ALTER TABLE pLinePlanItemTemp ADD CONSTRAINT DF_pLinePlanItemTemp_LinePlanItemTempId DEFAULT newid() FOR LinePlanItemTempId
GO

UPDATE pLinePlanItemTemp SET LinePlanItemTempId =newid() WHERE LinePlanItemTempId Is NULL
GO

ALTER TABLE pLinePlanItemTemp ALTER COLUMN LinePlanItemTempId uniqueidentifier  not null
GO

ALTER TABLE pLinePlanItemTemp ALTER COLUMN LinePlanItemTempId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanItemTemp' )
BEGIN
    ALTER TABLE pLinePlanItemTemp ADD CONSTRAINT PK_pLinePlanItemTemp PRIMARY KEY CLUSTERED (LinePlanItemTempId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanMultiClothStyleTemp' )
BEGIN
    ALTER TABLE pLinePlanMultiClothStyleTemp ADD LinePlanMultiClothStyleTempId uniqueidentifier
END
GO

ALTER TABLE pLinePlanMultiClothStyleTemp ADD CONSTRAINT DF_pLinePlanMultiClothStyleTemp_LinePlanMultiClothStyleTempId DEFAULT newid() FOR LinePlanMultiClothStyleTempId
GO

UPDATE pLinePlanMultiClothStyleTemp SET LinePlanMultiClothStyleTempId =newid() WHERE LinePlanMultiClothStyleTempId Is NULL
GO

ALTER TABLE pLinePlanMultiClothStyleTemp ALTER COLUMN LinePlanMultiClothStyleTempId uniqueidentifier  not null
GO

ALTER TABLE pLinePlanMultiClothStyleTemp ALTER COLUMN LinePlanStyleTempID DROP ROWGUIDCOL
GO

ALTER TABLE pLinePlanMultiClothStyleTemp ALTER COLUMN LinePlanMultiClothStyleTempId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanMultiClothStyleTemp' )
BEGIN
    ALTER TABLE pLinePlanMultiClothStyleTemp ADD CONSTRAINT PK_pLinePlanMultiClothStyleTemp PRIMARY KEY CLUSTERED (LinePlanMultiClothStyleTempId)
END
GO

ALTER TABLE pLinePlanRangeAttribute  ALTER COLUMN LinePlanRangeAttributeId ADD ROWGUIDCOL
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanRangeAttribute' )
BEGIN
    ALTER TABLE pLinePlanRangeAttribute ADD CONSTRAINT PK_pLinePlanRangeAttribute PRIMARY KEY CLUSTERED (LinePlanRangeAttributeId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanRangeAttributeTemp' )
BEGIN
    ALTER TABLE pLinePlanRangeAttributeTemp ADD LinePlanRangeAttributeTempId uniqueidentifier
END
GO

ALTER TABLE pLinePlanRangeAttributeTemp ADD CONSTRAINT DF_pLinePlanRangeAttributeTemp_LinePlanRangeAttributeTempId DEFAULT newid() FOR LinePlanRangeAttributeTempId
GO

UPDATE pLinePlanRangeAttributeTemp SET LinePlanRangeAttributeTempId =newid() WHERE LinePlanRangeAttributeTempId Is NULL
GO

ALTER TABLE pLinePlanRangeAttributeTemp ALTER COLUMN LinePlanRangeAttributeTempId uniqueidentifier  not null
GO

ALTER TABLE pLinePlanRangeAttributeTemp  ALTER COLUMN LinePlanRangeAttributeTempId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanRangeAttributeTemp' )
BEGIN
    ALTER TABLE pLinePlanRangeAttributeTemp ADD CONSTRAINT PK_pLinePlanRangeAttributeTemp PRIMARY KEY CLUSTERED (LinePlanRangeAttributeTempId)
END
GO


ALTER TABLE pLinePlanShowroomStyle ADD CONSTRAINT DF_pLinePlanShowroomStyle_LinePlanShowroomStyleId DEFAULT newid() FOR LinePlanShowroomStyleId
GO

UPDATE pLinePlanShowroomStyle SET LinePlanShowroomStyleId =newid() WHERE LinePlanShowroomStyleId Is NULL
GO

ALTER TABLE pLinePlanShowroomStyle ALTER COLUMN LinePlanShowroomStyleId uniqueidentifier  not null
GO

ALTER TABLE pLinePlanShowroomStyle  ALTER COLUMN LinePlanShowroomStyleId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanShowroomStyle' )
BEGIN
    ALTER TABLE pLinePlanShowroomStyle ADD CONSTRAINT PK_pLinePlanShowroomStyle PRIMARY KEY CLUSTERED (LinePlanShowroomStyleId)
END
GO



ALTER TABLE pLinePlanShowroomStyleColor  ALTER COLUMN LinePlanShowroomStyleColorId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanShowroomStyleColor' )
BEGIN
    ALTER TABLE pLinePlanShowroomStyleColor ADD CONSTRAINT PK_pLinePlanShowroomStyleColor PRIMARY KEY CLUSTERED (LinePlanShowroomStyleColorId)
END
GO

UPDATE pLinePlanStyleAttribute SET LinePlanStyleAttributeId =newid() WHERE LinePlanStyleAttributeId Is NULL
GO

ALTER TABLE pLinePlanStyleAttribute ALTER COLUMN LinePlanStyleAttributeId uniqueidentifier  not null
GO

ALTER TABLE pLinePlanStyleAttribute  ALTER COLUMN LinePlanStyleAttributeId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttribute' )
BEGIN
    ALTER TABLE pLinePlanStyleAttribute ADD CONSTRAINT PK_pLinePlanStyleAttribute PRIMARY KEY CLUSTERED (LinePlanStyleAttributeId)
END
GO

ALTER TABLE pLinePlanStyleAttributeItem ADD CONSTRAINT DF_pLinePlanStyleAttributeItem_LinePlanStyleAttributeItemID DEFAULT newid() FOR LinePlanStyleAttributeItemID
GO

UPDATE pLinePlanStyleAttributeItem SET LinePlanStyleAttributeItemID =newid() WHERE LinePlanStyleAttributeItemID Is NULL
GO

ALTER TABLE pLinePlanStyleAttributeItem ALTER COLUMN LinePlanStyleAttributeItemID uniqueidentifier  not null
GO

ALTER TABLE pLinePlanStyleAttributeItem  ALTER COLUMN LinePlanStyleAttributeItemID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttributeItem' )
BEGIN
    ALTER TABLE pLinePlanStyleAttributeItem ADD CONSTRAINT PK_pLinePlanStyleAttributeItem PRIMARY KEY CLUSTERED (LinePlanStyleAttributeItemID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttributeType1' )
BEGIN
    ALTER TABLE pLinePlanStyleAttributeType1 ADD LinePlanStyleAttributeType1ID uniqueidentifier
END
GO

ALTER TABLE pLinePlanStyleAttributeType1 ADD CONSTRAINT DF_pLinePlanStyleAttributeType1_LinePlanStyleAttributeType1ID DEFAULT newid() FOR LinePlanStyleAttributeType1ID
GO

UPDATE pLinePlanStyleAttributeType1 SET LinePlanStyleAttributeType1ID =newid() WHERE LinePlanStyleAttributeType1ID Is NULL
GO

ALTER TABLE pLinePlanStyleAttributeType1 ALTER COLUMN LinePlanStyleAttributeType1ID uniqueidentifier  not null
GO

ALTER TABLE pLinePlanStyleAttributeType1  ALTER COLUMN LinePlanStyleAttributeType1ID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttributeType1' )
BEGIN
    ALTER TABLE pLinePlanStyleAttributeType1 ADD CONSTRAINT PK_pLinePlanStyleAttributeType1 PRIMARY KEY CLUSTERED (LinePlanStyleAttributeType1ID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttributeType2' )
BEGIN
    ALTER TABLE pLinePlanStyleAttributeType2 ADD LinePlanStyleAttributeType2ID uniqueidentifier
END
GO

ALTER TABLE pLinePlanStyleAttributeType2 ADD CONSTRAINT DF_pLinePlanStyleAttributeType2_LinePlanStyleAttributeType2ID DEFAULT newid() FOR LinePlanStyleAttributeType2ID
GO

UPDATE pLinePlanStyleAttributeType2 SET LinePlanStyleAttributeType2ID =newid() WHERE LinePlanStyleAttributeType2ID Is NULL
GO

ALTER TABLE pLinePlanStyleAttributeType2 ALTER COLUMN LinePlanStyleAttributeType2ID uniqueidentifier  not null
GO

ALTER TABLE pLinePlanStyleAttributeType2  ALTER COLUMN LinePlanStyleAttributeType2ID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanStyleAttributeType2' )
BEGIN
    ALTER TABLE pLinePlanStyleAttributeType2 ADD CONSTRAINT PK_pLinePlanStyleAttributeType2 PRIMARY KEY CLUSTERED (LinePlanStyleAttributeType2ID)
END
GO


ALTER TABLE pLinePlanTempItemShowroom ADD CONSTRAINT DF_pLinePlanTempItemShowroom_LinePlanTempItemShowroomID DEFAULT newid() FOR LinePlanTempItemShowroomID
GO

UPDATE pLinePlanTempItemShowroom SET LinePlanTempItemShowroomID =newid() WHERE LinePlanTempItemShowroomID Is NULL
GO

ALTER TABLE pLinePlanTempItemShowroom ALTER COLUMN LinePlanTempItemShowroomID uniqueidentifier  not null
GO

ALTER TABLE pLinePlanTempItemShowroom  ALTER COLUMN LinePlanTempItemShowroomID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLinePlanTempItemShowroom' )
BEGIN
    ALTER TABLE pLinePlanTempItemShowroom ADD CONSTRAINT PK_pLinePlanTempItemShowroom PRIMARY KEY CLUSTERED (LinePlanTempItemShowroomID)
END
GO



IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLineTemp' )
BEGIN
    ALTER TABLE pLineTemp ADD LineTempID uniqueidentifier
END
GO


ALTER TABLE pLineTemp ADD CONSTRAINT DF_pLineTemp_LineTempId DEFAULT newid() FOR LineTempID
GO

UPDATE pLineTemp SET LineTempID =newid() WHERE LineTempID Is NULL
GO

ALTER TABLE pLineTemp ALTER COLUMN LineTempID uniqueidentifier  not null
GO

ALTER TABLE pLineTemp  ALTER COLUMN LineTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pLineTemp' )
BEGIN
    ALTER TABLE pLineTemp ADD CONSTRAINT PK_pLineTemp PRIMARY KEY CLUSTERED (LineTempID)
END
GO



ALTER TABLE pMaterialLinkColorway ADD CONSTRAINT DF_pMaterialLinkColorway_MaterialLinkColorwayID DEFAULT newid() FOR MaterialLinkColorwayID
GO

UPDATE pMaterialLinkColorway SET MaterialLinkColorwayID =newid() WHERE MaterialLinkColorwayID Is NULL
GO

ALTER TABLE pMaterialLinkColorway ALTER COLUMN MaterialLinkColorwayID uniqueidentifier  not null
GO

ALTER TABLE pMaterialLinkColorway  ALTER COLUMN MaterialLinkColorwayID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialLinkColorway' )
BEGIN
    ALTER TABLE pMaterialLinkColorway ADD CONSTRAINT PK_pMaterialLinkColorway PRIMARY KEY CLUSTERED (MaterialLinkColorwayID)
END
GO



ALTER TABLE pMaterialLinkComponent  ALTER COLUMN MaterialLinkComponentID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialLinkComponent' )
BEGIN
    ALTER TABLE pMaterialLinkComponent ADD CONSTRAINT PK_pMaterialLinkComponent PRIMARY KEY CLUSTERED (MaterialLinkComponentID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestAgentVendorTemp' )
BEGIN
    ALTER TABLE pMaterialRequestAgentVendorTemp ADD MaterialRequestAgentVendorTempID uniqueidentifier
END
GO


ALTER TABLE pMaterialRequestAgentVendorTemp ADD CONSTRAINT DF_pMaterialRequestAgentVendorTemp_MaterialRequestAgentVendorTempID DEFAULT newid() FOR MaterialRequestAgentVendorTempID
GO

UPDATE pMaterialRequestAgentVendorTemp SET MaterialRequestAgentVendorTempID =newid() WHERE MaterialRequestAgentVendorTempID Is NULL
GO

ALTER TABLE pMaterialRequestAgentVendorTemp ALTER COLUMN MaterialRequestAgentVendorTempID uniqueidentifier  not null
GO

ALTER TABLE pMaterialRequestAgentVendorTemp  ALTER COLUMN MaterialRequestAgentVendorTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestAgentVendorTemp' )
BEGIN
    ALTER TABLE pMaterialRequestAgentVendorTemp ADD CONSTRAINT PK_pMaterialRequestAgentVendorTemp PRIMARY KEY CLUSTERED (MaterialRequestAgentVendorTempID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestSeasonColorTemp' )
BEGIN
    ALTER TABLE pMaterialRequestSeasonColorTemp ADD MaterialRequestSeasonColorTempID uniqueidentifier
END
GO


ALTER TABLE pMaterialRequestSeasonColorTemp ADD CONSTRAINT DF_pMaterialRequestSeasonColorTemp_MaterialRequestSeasonColorTempID DEFAULT newid() FOR MaterialRequestSeasonColorTempID
GO

UPDATE pMaterialRequestSeasonColorTemp SET MaterialRequestSeasonColorTempID =newid() WHERE MaterialRequestSeasonColorTempID Is NULL
GO

ALTER TABLE pMaterialRequestSeasonColorTemp ALTER COLUMN MaterialRequestSeasonColorTempID uniqueidentifier  not null
GO

ALTER TABLE pMaterialRequestSeasonColorTemp  ALTER COLUMN MaterialRequestSeasonColorTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestSeasonColorTemp' )
BEGIN
    ALTER TABLE pMaterialRequestSeasonColorTemp ADD CONSTRAINT PK_pMaterialRequestSeasonColorTemp PRIMARY KEY CLUSTERED (MaterialRequestSeasonColorTempID)
END
GO


ALTER TABLE pMaterialRequestSubmitDocument ADD CONSTRAINT DF_pMaterialRequestSubmitDocument_MaterialRequestSubmitDocumentID DEFAULT newid() FOR MaterialRequestSubmitDocumentID
GO

UPDATE pMaterialRequestSubmitDocument SET MaterialRequestSubmitDocumentID =newid() WHERE MaterialRequestSubmitDocumentID Is NULL
GO

ALTER TABLE pMaterialRequestSubmitDocument ALTER COLUMN MaterialRequestSubmitDocumentID uniqueidentifier  not null
GO

ALTER TABLE pMaterialRequestSubmitDocument  ALTER COLUMN MaterialRequestSubmitDocumentID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestSubmitDocument' )
BEGIN
    ALTER TABLE pMaterialRequestSubmitDocument ADD CONSTRAINT PK_pMaterialRequestSubmitDocument PRIMARY KEY CLUSTERED (MaterialRequestSubmitDocumentID)
END
GO



IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestSubmitItemStatus' )
BEGIN
    ALTER TABLE pMaterialRequestSubmitItemStatus ADD MaterialRequestSubmitItemStatusID uniqueidentifier
END
GO


ALTER TABLE pMaterialRequestSubmitItemStatus ADD CONSTRAINT DF_pMaterialRequestSubmitItemStatus_MaterialRequestSubmitItemStatusID DEFAULT newid() FOR MaterialRequestSubmitItemStatusID
GO

UPDATE pMaterialRequestSubmitItemStatus SET MaterialRequestSubmitItemStatusID =newid() WHERE MaterialRequestSubmitItemStatusID Is NULL
GO

ALTER TABLE pMaterialRequestSubmitItemStatus ALTER COLUMN MaterialRequestSubmitItemStatusID uniqueidentifier  not null
GO

ALTER TABLE pMaterialRequestSubmitItemStatus  ALTER COLUMN MaterialRequestSubmitItemStatusID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestSubmitItemStatus' )
BEGIN
    ALTER TABLE pMaterialRequestSubmitItemStatus ADD CONSTRAINT PK_pMaterialRequestSubmitItemStatus PRIMARY KEY CLUSTERED (MaterialRequestSubmitItemStatusID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestTemp' )
BEGIN
    ALTER TABLE pMaterialRequestTemp ADD MaterialRequestTempID uniqueidentifier
END
GO


ALTER TABLE pMaterialRequestTemp ADD CONSTRAINT DF_pMaterialRequestTemp_MaterialRequestTempID DEFAULT newid() FOR MaterialRequestTempID
GO

UPDATE pMaterialRequestTemp SET MaterialRequestTempID =newid() WHERE MaterialRequestTempID Is NULL
GO

ALTER TABLE pMaterialRequestTemp ALTER COLUMN MaterialRequestTempID uniqueidentifier  not null
GO

ALTER TABLE pMaterialRequestTemp  ALTER COLUMN MaterialRequestTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialRequestTemp' )
BEGIN
    ALTER TABLE pMaterialRequestTemp ADD CONSTRAINT PK_pMaterialRequestTemp PRIMARY KEY CLUSTERED (MaterialRequestTempID)
END
GO

ALTER TABLE pMaterialSeasonYear  ALTER COLUMN MaterialSeasonYearID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialSeasonYear' )
BEGIN
    ALTER TABLE pMaterialSeasonYear ADD CONSTRAINT PK_pMaterialSeasonYear PRIMARY KEY CLUSTERED (MaterialSeasonYearID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialSize' )
BEGIN
    ALTER TABLE pMaterialSize ADD CONSTRAINT PK_pMaterialSize PRIMARY KEY CLUSTERED (MaterialSizeID)
END
GO


ALTER TABLE pMaterialTradePartnerColor ADD CONSTRAINT DF_pMaterialTradePartnerColor_MaterialTradePartnerColorID DEFAULT newid() FOR MaterialTradePartnerColorID
GO

UPDATE pMaterialTradePartnerColor SET MaterialTradePartnerColorID =newid() WHERE MaterialTradePartnerColorID Is NULL
GO

ALTER TABLE pMaterialTradePartnerColor ALTER COLUMN MaterialTradePartnerColorID DROP ROWGUIDCOL
GO

ALTER TABLE pMaterialTradePartnerColor ALTER COLUMN MaterialTradePartnerColorID uniqueidentifier  not null
GO

ALTER TABLE pMaterialTradePartnerColor  ALTER COLUMN MaterialTradePartnerColorID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialTradePartnerColor' )
BEGIN
    ALTER TABLE pMaterialTradePartnerColor ADD CONSTRAINT PK_pMaterialTradePartnerColor PRIMARY KEY CLUSTERED (MaterialTradePartnerColorID)
END
GO


ALTER TABLE pMaterialTradePartnerTemp ADD CONSTRAINT DF_pMaterialTradePartnerTemp_MaterialTradePartnerTempID DEFAULT newid() FOR MaterialTradePartnerTempID
GO

ALTER TABLE pMaterialTradePartnerTemp ALTER COLUMN MaterialTradePartnerId DROP ROWGUIDCOL
GO

UPDATE pMaterialTradePartnerTemp SET MaterialTradePartnerTempID =newid() WHERE MaterialTradePartnerTempID Is NULL
GO

ALTER TABLE pMaterialTradePartnerTemp ALTER COLUMN MaterialTradePartnerTempID uniqueidentifier  not null
GO

ALTER TABLE pMaterialTradePartnerTemp  ALTER COLUMN MaterialTradePartnerTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialTradePartnerTemp' )
BEGIN
    ALTER TABLE pMaterialTradePartnerTemp ADD CONSTRAINT PK_pMaterialTradePartnerTemp PRIMARY KEY CLUSTERED (MaterialTradePartnerTempID)
END
GO

ALTER TABLE pMaterialVendorTesting ALTER COLUMN MaterialVendorTestId DROP ROWGUIDCOL
GO

ALTER TABLE pMaterialVendorTesting ADD CONSTRAINT DF_pMaterialVendorTesting_MaterialVendorTestId DEFAULT newid() FOR MaterialVendorTestId
GO

UPDATE pMaterialVendorTesting SET MaterialVendorTestId =newid() WHERE MaterialVendorTestId Is NULL
GO

ALTER TABLE pMaterialVendorTesting ALTER COLUMN MaterialVendorTestId uniqueidentifier  not null
GO

ALTER TABLE pMaterialVendorTesting  ALTER COLUMN MaterialVendorTestId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pMaterialVendorTesting' )
BEGIN
    ALTER TABLE pMaterialVendorTesting ADD CONSTRAINT PK_pMaterialVendorTesting PRIMARY KEY CLUSTERED (MaterialVendorTestId)
END
GO

-- ALTER TABLE pSampleRequestCommentTemplate  ALTER COLUMN CustomId ADD ROWGUIDCOL
-- GO

-- IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
--                                 WHERE constraint_type ='Primary Key'
--                                   AND table_name = 'pSampleRequestCommentTemplate' )
-- BEGIN
--    ALTER TABLE pSampleRequestCommentTemplate ADD CONSTRAINT PK_pSampleRequestCommentTemplate PRIMARY KEY CLUSTERED (CustomId)
-- END
-- GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestStyleColorwayTemp' )
BEGIN
    ALTER TABLE pSampleRequestStyleColorwayTemp ADD SampleRequestStyleColorwayTempID uniqueidentifier
END
GO

ALTER TABLE pSampleRequestStyleColorwayTemp ADD CONSTRAINT DF_pSampleRequestStyleColorwayTemp_SampleRequestStyleColorwayTempId DEFAULT newid() FOR SampleRequestStyleColorwayTempId
GO

UPDATE pSampleRequestStyleColorwayTemp SET SampleRequestStyleColorwayTempId =newid() WHERE SampleRequestStyleColorwayTempId Is NULL
GO

ALTER TABLE pSampleRequestStyleColorwayTemp ALTER COLUMN SampleRequestStyleColorwayTempId uniqueidentifier  not null
GO

-- ALTER TABLE pSampleRequestStyleColorwayTemp  ALTER COLUMN SampleRequestStyleColorwayTempId ADD ROWGUIDCOL
-- GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestStyleColorwayTemp' )
BEGIN
    ALTER TABLE pSampleRequestStyleColorwayTemp ADD CONSTRAINT PK_pSampleRequestStyleColorwayTemp PRIMARY KEY CLUSTERED (SampleRequestStyleColorwayTempId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestStyleSourcingTemp' )
BEGIN
    ALTER TABLE pSampleRequestStyleSourcingTemp ADD SampleRequestStyleSourcingTempId uniqueidentifier
END
GO

ALTER TABLE pSampleRequestStyleSourcingTemp ADD CONSTRAINT DF_pSampleRequestStyleSourcingTemp_SampleRequestStyleSourcingTempId DEFAULT newid() FOR SampleRequestStyleSourcingTempId
GO

UPDATE pSampleRequestStyleSourcingTemp SET SampleRequestStyleSourcingTempId =newid() WHERE SampleRequestStyleSourcingTempId Is NULL
GO

ALTER TABLE pSampleRequestStyleSourcingTemp ALTER COLUMN SampleRequestStyleSourcingTempId uniqueidentifier  not null
GO

ALTER TABLE pSampleRequestStyleSourcingTemp  ALTER COLUMN SampleRequestStyleSourcingTempId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestStyleSourcingTemp' )
BEGIN
    ALTER TABLE pSampleRequestStyleSourcingTemp ADD CONSTRAINT PK_pSampleRequestStyleSourcingTemp PRIMARY KEY CLUSTERED (SampleRequestStyleSourcingTempId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestSubmitStatus' )
BEGIN
    ALTER TABLE pSampleRequestSubmitStatus ADD SampleRequestSubmitStatusId uniqueidentifier
END
GO

ALTER TABLE pSampleRequestSubmitStatus ADD CONSTRAINT DF_pSampleRequestSubmitStatus_SampleRequestSubmitStatusId DEFAULT newid() FOR SampleRequestSubmitStatusId
GO

UPDATE pSampleRequestSubmitStatus SET SampleRequestSubmitStatusId =newid() WHERE SampleRequestSubmitStatusId Is NULL
GO

ALTER TABLE pSampleRequestSubmitStatus ALTER COLUMN SampleRequestSubmitStatusId uniqueidentifier  not null
GO

ALTER TABLE pSampleRequestSubmitStatus  ALTER COLUMN SampleRequestSubmitStatusId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSampleRequestSubmitStatus' )
BEGIN
    ALTER TABLE pSampleRequestSubmitStatus ADD CONSTRAINT PK_pSampleRequestSubmitStatus PRIMARY KEY CLUSTERED (SampleRequestSubmitStatusId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSeasonYear' )
BEGIN
    ALTER TABLE pSeasonYear ADD CONSTRAINT PK_pSeasonYear PRIMARY KEY CLUSTERED (SeasonYearId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSizeHome' )
BEGIN
    ALTER TABLE pSizeHome ADD SizeHomeId uniqueidentifier
END
GO

ALTER TABLE pSizeHome ADD CONSTRAINT DF_pSizeHome_SizeHomeId DEFAULT newid() FOR SizeHomeId
GO

UPDATE pSizeHome SET SizeHomeId =newid() WHERE SizeHomeId Is NULL
GO

ALTER TABLE pSizeHome ALTER COLUMN SizeHomeId uniqueidentifier  not null
GO

ALTER TABLE pSizeHome  ALTER COLUMN SizeHomeId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pSizeHome' )
BEGIN
    ALTER TABLE pSizeHome ADD CONSTRAINT PK_pSizeHome PRIMARY KEY CLUSTERED (SizeHomeId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareBleach' )
BEGIN
    ALTER TABLE pStyleCareBleach ADD CONSTRAINT PK_pStyleCareBleach PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareCycle' )
BEGIN
    ALTER TABLE pStyleCareCycle ADD CONSTRAINT PK_pStyleCareCycle PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareDry' )
BEGIN
    ALTER TABLE pStyleCareDry ADD CONSTRAINT PK_pStyleCareDry PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareDryClean' )
BEGIN
    ALTER TABLE pStyleCareDryClean ADD CONSTRAINT PK_pStyleCareDryClean PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareIron' )
BEGIN
    ALTER TABLE pStyleCareIron ADD CONSTRAINT PK_pStyleCareIron PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCareSpecial' )
BEGIN
    ALTER TABLE pStyleCareSpecial ADD CONSTRAINT PK_pStyleCareSpecial PRIMARY KEY CLUSTERED (CustomId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorStandard' )
BEGIN
    ALTER TABLE pStyleColorStandard ADD CONSTRAINT PK_pStyleColorStandard PRIMARY KEY CLUSTERED (StyleColorStandardId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwayAvailTemp' )
BEGIN
    ALTER TABLE pStyleColorwayAvailTemp ADD StyleColorwayAvailTempId uniqueidentifier
END
GO

ALTER TABLE pStyleColorwayAvailTemp ADD CONSTRAINT DF_pStyleColorwayAvailTemp_StyleColorwayAvailTempId DEFAULT newid() FOR StyleColorwayAvailTempId
GO

UPDATE pStyleColorwayAvailTemp SET StyleColorwayAvailTempId =newid() WHERE StyleColorwayAvailTempId Is NULL
GO

ALTER TABLE pStyleColorwayAvailTemp ALTER COLUMN StyleColorwayAvailTempId uniqueidentifier  not null
GO

ALTER TABLE pStyleColorwayAvailTemp  ALTER COLUMN StyleColorwayAvailTempId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwayAvailTemp' )
BEGIN
    ALTER TABLE pStyleColorwayAvailTemp ADD CONSTRAINT PK_pStyleColorwayAvailTemp PRIMARY KEY CLUSTERED (StyleColorwayAvailTempId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwaySeasonYear' )
BEGIN
    ALTER TABLE pStyleColorwaySeasonYear ADD CONSTRAINT PK_pStyleColorwaySeasonYear PRIMARY KEY CLUSTERED (StyleColorwaySeasonYearID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwaySeasonYearTemp' )
BEGIN
    ALTER TABLE pStyleColorwaySeasonYearTemp ADD StyleColorwaySeasonYearTempID uniqueidentifier
END
GO

ALTER TABLE pStyleColorwaySeasonYearTemp ADD CONSTRAINT DF_pStyleColorwaySeasonYearTemp_StyleColorwaySeasonYearTempID DEFAULT newid() FOR StyleColorwaySeasonYearTempID
GO

UPDATE pStyleColorwaySeasonYearTemp SET StyleColorwaySeasonYearTempID =newid() WHERE StyleColorwaySeasonYearTempID Is NULL
GO

ALTER TABLE pStyleColorwaySeasonYearTemp ALTER COLUMN StyleColorwaySeasonYearTempID uniqueidentifier  not null
GO

ALTER TABLE pStyleColorwaySeasonYearTemp  ALTER COLUMN StyleColorwaySeasonYearTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwaySeasonYearTemp' )
BEGIN
    ALTER TABLE pStyleColorwaySeasonYearTemp ADD CONSTRAINT PK_pStyleColorwaySeasonYearTemp PRIMARY KEY CLUSTERED (StyleColorwaySeasonYearTempID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwayTemp' )
BEGIN
    ALTER TABLE pStyleColorwayTemp ADD StyleColorwayTempID uniqueidentifier
END
GO

ALTER TABLE pStyleColorwayTemp ADD CONSTRAINT DF_pStyleColorwayTemp_StyleColorwayTempID DEFAULT newid() FOR StyleColorwayTempID
GO

UPDATE pStyleColorwayTemp SET StyleColorwayTempID =newid() WHERE StyleColorwayTempID Is NULL
GO

ALTER TABLE pStyleColorwayTemp ALTER COLUMN StyleColorwayTempID uniqueidentifier  not null
GO

ALTER TABLE pStyleColorwayTemp  ALTER COLUMN StyleColorwayTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleColorwayTemp' )
BEGIN
    ALTER TABLE pStyleColorwayTemp ADD CONSTRAINT PK_pStyleColorwayTemp PRIMARY KEY CLUSTERED (StyleColorwayTempID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCostingDomesticRate' )
BEGIN
    ALTER TABLE pStyleCostingDomesticRate ADD StyleCostingDomesticRateID uniqueidentifier
END
GO

ALTER TABLE pStyleCostingDomesticRate ADD CONSTRAINT DF_pStyleCostingDomesticRate_StyleCostingDomesticRateID DEFAULT newid() FOR StyleCostingDomesticRateID
GO

UPDATE pStyleCostingDomesticRate SET StyleCostingDomesticRateID =newid() WHERE StyleCostingDomesticRateID Is NULL
GO

ALTER TABLE pStyleCostingDomesticRate ALTER COLUMN StyleCostingDomesticRateID uniqueidentifier  not null
GO

ALTER TABLE pStyleCostingDomesticRate  ALTER COLUMN StyleCostingDomesticRateID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleCostingDomesticRate' )
BEGIN
    ALTER TABLE pStyleCostingDomesticRate ADD CONSTRAINT PK_pStyleCostingDomesticRate PRIMARY KEY CLUSTERED (StyleCostingDomesticRateID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleDetailGridControl' )
BEGIN
    ALTER TABLE pStyleDetailGridControl ADD StyleDetailGridControlID uniqueidentifier
END
GO

ALTER TABLE pStyleDetailGridControl ADD CONSTRAINT DF_pStyleDetailGridControl_StyleDetailGridControlID DEFAULT newid() FOR StyleDetailGridControlID
GO

UPDATE pStyleDetailGridControl SET StyleDetailGridControlID =newid() WHERE StyleDetailGridControlID Is NULL
GO

ALTER TABLE pStyleDetailGridControl ALTER COLUMN StyleDetailGridControlID uniqueidentifier  not null
GO

ALTER TABLE pStyleDetailGridControl  ALTER COLUMN StyleDetailGridControlID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleDetailGridControl' )
BEGIN
    ALTER TABLE pStyleDetailGridControl ADD CONSTRAINT PK_pStyleDetailGridControl PRIMARY KEY CLUSTERED (StyleDetailGridControlID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleDevelopmentItemTemp' )
BEGIN
    ALTER TABLE pStyleDevelopmentItemTemp ADD StyleDevelopmentItemTempID uniqueidentifier
END
GO

ALTER TABLE pStyleDevelopmentItemTemp ADD CONSTRAINT DF_pStyleDevelopmentItemTemp_StyleDevelopmentItemTempID DEFAULT newid() FOR StyleDevelopmentItemTempID
GO

UPDATE pStyleDevelopmentItemTemp SET StyleDevelopmentItemTempID =newid() WHERE StyleDevelopmentItemTempID Is NULL
GO

ALTER TABLE pStyleDevelopmentItemTemp ALTER COLUMN StyleDevelopmentItemTempID uniqueidentifier  not null
GO

ALTER TABLE pStyleDevelopmentItemTemp ALTER COLUMN StyleDevelopmentItemTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleDevelopmentItemTemp' )
BEGIN
    ALTER TABLE pStyleDevelopmentItemTemp ADD CONSTRAINT PK_pStyleDevelopmentItemTemp PRIMARY KEY CLUSTERED (StyleDevelopmentItemTempID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleFeature' )
BEGIN
    ALTER TABLE pStyleFeature ADD StyleFeatureID uniqueidentifier
END
GO

ALTER TABLE pStyleFeature ADD CONSTRAINT DF_pStyleFeature_StyleFeatureID DEFAULT newid() FOR StyleFeatureID
GO

UPDATE pStyleFeature SET StyleFeatureID =newid() WHERE StyleFeatureID Is NULL
GO

ALTER TABLE pStyleFeature ALTER COLUMN StyleFeatureID uniqueidentifier  not null
GO

ALTER TABLE pStyleFeature ALTER COLUMN StyleId DROP ROWGUIDCOL
GO

ALTER TABLE pStyleFeature ALTER COLUMN StyleFeatureID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleFeature' )
BEGIN
    ALTER TABLE pStyleFeature ADD CONSTRAINT PK_pStyleFeature PRIMARY KEY CLUSTERED (StyleFeatureID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleQuoteItem' )
BEGIN
    ALTER TABLE pStyleQuoteItem ADD CONSTRAINT PK_pStyleQuoteItem PRIMARY KEY CLUSTERED (StyleQuoteItemID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pStyleQuoteVariation' )
BEGIN
    ALTER TABLE pStyleQuoteVariation ADD CONSTRAINT PK_pStyleQuoteVariation PRIMARY KEY CLUSTERED (StyleQuoteVariationID)
END
GO


ALTER TABLE pTemplateCare ADD CONSTRAINT DF_pTemplateCare_TemplateCareID DEFAULT newid() FOR TemplateCareID
GO

UPDATE pTemplateCare SET TemplateCareID =newid() WHERE TemplateCareID Is NULL
GO

ALTER TABLE pTemplateCare ALTER COLUMN TemplateCareID uniqueidentifier  not null
GO

ALTER TABLE pTemplateCare ALTER COLUMN TemplateCareID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pTemplateCare' )
BEGIN
    ALTER TABLE pTemplateCare ADD CONSTRAINT PK_pTemplateCare PRIMARY KEY CLUSTERED (TemplateCareID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pUserTitle' )
BEGIN
    ALTER TABLE pUserTitle ADD pUserTitleID uniqueidentifier
END
GO

ALTER TABLE pUserTitle ADD CONSTRAINT DF_pUserTitle_pUserTitleID DEFAULT newid() FOR pUserTitleID
GO

UPDATE pUserTitle SET pUserTitleID =newid() WHERE pUserTitleID Is NULL
GO

ALTER TABLE pUserTitle ALTER COLUMN pUserTitleID uniqueidentifier  not null
GO

ALTER TABLE pUserTitle ALTER COLUMN pUserTitleID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'pUserTitle' )
BEGIN
    ALTER TABLE pUserTitle ADD CONSTRAINT PK_pUserTitle PRIMARY KEY CLUSTERED (pUserTitleID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'Query' )
BEGIN
    ALTER TABLE Query ADD QueryID uniqueidentifier
END
GO

ALTER TABLE Query ADD CONSTRAINT DF_Query_QueryID DEFAULT newid() FOR QueryID
GO

UPDATE Query SET QueryID =newid() WHERE QueryID Is NULL
GO

ALTER TABLE Query ALTER COLUMN QueryID uniqueidentifier  not null
GO

ALTER TABLE Query ALTER COLUMN QueryID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'Query' )
BEGIN
    ALTER TABLE Query ADD CONSTRAINT PK_Query PRIMARY KEY CLUSTERED (QueryID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportAgentNotificationLog' )
BEGIN
    ALTER TABLE rReportAgentNotificationLog ADD ReportAgentNotificationLogID uniqueidentifier
END
GO

ALTER TABLE rReportAgentNotificationLog ADD CONSTRAINT DF_rReportAgentNotificationLog_ReportAgentNotificationLogID DEFAULT newid() FOR ReportAgentNotificationLogID
GO

UPDATE rReportAgentNotificationLog SET ReportAgentNotificationLogID =newid() WHERE ReportAgentNotificationLogID Is NULL
GO

ALTER TABLE rReportAgentNotificationLog ALTER COLUMN ReportAgentNotificationLogID uniqueidentifier  not null
GO

ALTER TABLE rReportAgentNotificationLog ALTER COLUMN ReportAgentNotificationLogID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportAgentNotificationLog' )
BEGIN
    ALTER TABLE rReportAgentNotificationLog ADD CONSTRAINT PK_rReportAgentNotificationLog PRIMARY KEY CLUSTERED (ReportAgentNotificationLogID)
END
GO

ALTER TABLE rReportAgentNotificationTask ADD CONSTRAINT DF_rReportAgentNotificationTask_ReportAgentNotificationTaskID DEFAULT newid() FOR ReportAgentNotificationTaskID
GO

UPDATE rReportAgentNotificationTask SET ReportAgentNotificationTaskID =newid() WHERE ReportAgentNotificationTaskID Is NULL
GO

ALTER TABLE rReportAgentNotificationTask ALTER COLUMN ReportAgentNotificationTaskID uniqueidentifier  not null
GO

ALTER TABLE rReportAgentNotificationTask ALTER COLUMN ReportAgentNotificationTaskID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportAgentNotificationTask' )
BEGIN
    ALTER TABLE rReportAgentNotificationTask ADD CONSTRAINT PK_rReportAgentNotificationTask PRIMARY KEY CLUSTERED (ReportAgentNotificationTaskID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportImage' )
BEGIN
    ALTER TABLE rReportImage ADD rReportImageID uniqueidentifier
END
GO

ALTER TABLE rReportImage ADD CONSTRAINT DF_rReportImage_rReportImageID DEFAULT newid() FOR rReportImageID
GO

UPDATE rReportImage SET rReportImageID =newid() WHERE rReportImageID Is NULL
GO

ALTER TABLE rReportImage ALTER COLUMN rReportImageID uniqueidentifier  not null
GO

ALTER TABLE rReportImage ALTER COLUMN rReportImageID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportImage' )
BEGIN
    ALTER TABLE rReportImage ADD CONSTRAINT PK_rReportImage PRIMARY KEY CLUSTERED (rReportImageID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportStylePageItemTemp' )
BEGIN
    ALTER TABLE rReportStylePageItemTemp ADD ReportStylePageItemTempID uniqueidentifier
END
GO

ALTER TABLE rReportStylePageItemTemp ADD CONSTRAINT DF_rReportStylePageItemTemp_ReportStylePageItemTempID DEFAULT newid() FOR ReportStylePageItemTempID
GO

UPDATE rReportStylePageItemTemp SET ReportStylePageItemTempID =newid() WHERE ReportStylePageItemTempID Is NULL
GO

ALTER TABLE rReportStylePageItemTemp ALTER COLUMN ReportStylePageItemTempID uniqueidentifier  not null
GO

ALTER TABLE rReportStylePageItemTemp ALTER COLUMN ReportStylePageItemTempID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportStylePageItemTemp' )
BEGIN
    ALTER TABLE rReportStylePageItemTemp ADD CONSTRAINT PK_rReportStylePageItemTemp PRIMARY KEY CLUSTERED (ReportStylePageItemTempID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportStyleTabs' )
BEGIN
    ALTER TABLE rReportStyleTabs ADD ReportStyleTabsID uniqueidentifier
END
GO

ALTER TABLE rReportStyleTabs ADD CONSTRAINT DF_rReportStyleTabs_ReportStyleTabsID DEFAULT newid() FOR ReportStyleTabsID
GO

UPDATE rReportStyleTabs SET ReportStyleTabsID =newid() WHERE ReportStyleTabsID Is NULL
GO

ALTER TABLE rReportStyleTabs ALTER COLUMN ReportStyleTabsID uniqueidentifier  not null
GO

ALTER TABLE rReportStyleTabs ALTER COLUMN ReportStyleTabsID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportStyleTabs' )
BEGIN
    ALTER TABLE rReportStyleTabs ADD CONSTRAINT PK_rReportStyleTabs PRIMARY KEY CLUSTERED (ReportStyleTabsID)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportSubTable2' )
BEGIN
    ALTER TABLE rReportSubTable2 ADD ReportSubTable2ID uniqueidentifier
END
GO

ALTER TABLE rReportSubTable2 ADD CONSTRAINT DF_rReportSubTable2_ReportSubTable2ID DEFAULT newid() FOR ReportSubTable2ID
GO

UPDATE rReportSubTable2 SET ReportSubTable2ID =newid() WHERE ReportSubTable2ID Is NULL
GO

ALTER TABLE rReportSubTable2 ALTER COLUMN ReportSubTable2ID uniqueidentifier  not null
GO

ALTER TABLE rReportSubTable2 ALTER COLUMN ReportSubTable2ID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportSubTable2' )
BEGIN
    ALTER TABLE rReportSubTable2 ADD CONSTRAINT PK_rReportSubTable2 PRIMARY KEY CLUSTERED (ReportSubTable2ID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportSubTable3' )
BEGIN
    ALTER TABLE rReportSubTable3 ADD ReportSubTable3ID uniqueidentifier
END
GO

ALTER TABLE rReportSubTable3 ADD CONSTRAINT DF_rReportSubTable3_ReportSubTable3ID DEFAULT newid() FOR ReportSubTable3ID
GO

UPDATE rReportSubTable3 SET ReportSubTable3ID =newid() WHERE ReportSubTable3ID Is NULL
GO

ALTER TABLE rReportSubTable3 ALTER COLUMN ReportSubTable3ID uniqueidentifier  not null
GO

ALTER TABLE rReportSubTable3 ALTER COLUMN ReportSubTable3ID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'rReportSubTable3' )
BEGIN
    ALTER TABLE rReportSubTable3 ADD CONSTRAINT PK_rReportSubTable3 PRIMARY KEY CLUSTERED (ReportSubTable3ID)
END
GO

ALTER TABLE sAccessGroupSampleFolder ALTER COLUMN AccessSampleId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sAccessGroupSampleFolder' )
BEGIN
    ALTER TABLE sAccessGroupSampleFolder ADD CONSTRAINT PK_sAccessGroupSampleFolder PRIMARY KEY CLUSTERED (AccessSampleId)
END
GO

ALTER TABLE sAccessLineFolder ALTER COLUMN AccessLineId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sAccessLineFolder' )
BEGIN
    ALTER TABLE sAccessLineFolder ADD CONSTRAINT PK_sAccessLineFolder PRIMARY KEY CLUSTERED (AccessLineId)
END
GO

ALTER TABLE sAccessQuotationFolder ALTER COLUMN AccessQuotationID ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sAccessQuotationFolder' )
BEGIN
    ALTER TABLE sAccessQuotationFolder ADD CONSTRAINT PK_sAccessQuotationFolder PRIMARY KEY CLUSTERED (AccessQuotationId)
END
GO

ALTER TABLE sAccessSampleFolder ALTER COLUMN AccessSampleId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sAccessSampleFolder' )
BEGIN
    ALTER TABLE sAccessSampleFolder ADD CONSTRAINT PK_sAccessSampleFolder PRIMARY KEY CLUSTERED (AccessSampleId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sChannel' )
BEGIN
    ALTER TABLE sChannel ADD sChannelID uniqueidentifier
END
GO

ALTER TABLE sChannel ADD CONSTRAINT DF_sChannel_sChannelID DEFAULT newid() FOR sChannelID
GO

UPDATE sChannel SET sChannelID =newid() WHERE sChannelID Is NULL
GO

ALTER TABLE sChannel ALTER COLUMN sChannelID uniqueidentifier  not null
GO

ALTER TABLE sChannel ALTER COLUMN sChannelId ADD ROWGUIDCOL
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sChannel' )
BEGIN
    ALTER TABLE sChannel ADD CONSTRAINT PK_sChannel PRIMARY KEY CLUSTERED (sChannelId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sMaterialCodeID' )
BEGIN
    ALTER TABLE sMaterialCodeID ADD sMaterialCodeID uniqueidentifier
END
GO

ALTER TABLE sMaterialCodeID ADD CONSTRAINT DF_sMaterialCodeID_sMaterialCodeID DEFAULT newid() FOR sMaterialCodeID
GO

UPDATE sMaterialCodeID SET sMaterialCodeID =newid() WHERE sMaterialCodeID Is NULL
GO

ALTER TABLE sMaterialCodeID ALTER COLUMN sMaterialCodeID uniqueidentifier  not null
GO

ALTER TABLE sMaterialCodeID ALTER COLUMN sMaterialCodeID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sMaterialCodeID' )
BEGIN
    ALTER TABLE sMaterialCodeID ADD CONSTRAINT PK_sMaterialCodeID PRIMARY KEY CLUSTERED (sMaterialCodeID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sMaterialCodeTempID' )
BEGIN
    ALTER TABLE sMaterialCodeTempID ADD sMaterialCodeTempID uniqueidentifier
END
GO

ALTER TABLE sMaterialCodeTempID ADD CONSTRAINT DF_sMaterialCodeTempID_sMaterialCodeTempID DEFAULT newid() FOR sMaterialCodeTempID
GO

UPDATE sMaterialCodeTempID SET sMaterialCodeTempID =newid() WHERE sMaterialCodeTempID Is NULL
GO

ALTER TABLE sMaterialCodeTempID ALTER COLUMN sMaterialCodeTempID uniqueidentifier  not null
GO

ALTER TABLE sMaterialCodeTempID ALTER COLUMN sMaterialCodeTempID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sMaterialCodeTempID' )
BEGIN
    ALTER TABLE sMaterialCodeTempID ADD CONSTRAINT PK_sMaterialCodeTempID PRIMARY KEY CLUSTERED (sMaterialCodeTempID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sOverrideSPX' )
BEGIN
    ALTER TABLE sOverrideSPX ADD OverrideSPXID uniqueidentifier
END
GO

ALTER TABLE sOverrideSPX ADD CONSTRAINT DF_sOverrideSPX_OverrideSPXID DEFAULT newid() FOR OverrideSPXID
GO

UPDATE sOverrideSPX SET OverrideSPXID =newid() WHERE OverrideSPXID Is NULL
GO

ALTER TABLE sOverrideSPX ALTER COLUMN OverrideSPXID uniqueidentifier  not null
GO

ALTER TABLE sOverrideSPX ALTER COLUMN OverrideSPXID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sOverrideSPX' )
BEGIN
    ALTER TABLE sOverrideSPX ADD CONSTRAINT PK_sOverrideSPX PRIMARY KEY CLUSTERED (OverrideSPXID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sOverrideVWX' )
BEGIN
    ALTER TABLE sOverrideVWX ADD OverrideVWXID uniqueidentifier
END
GO

ALTER TABLE sOverrideVWX ADD CONSTRAINT DF_sOverrideVWX_OverrideVWXID DEFAULT newid() FOR OverrideVWXID
GO

UPDATE sOverrideVWX SET OverrideVWXID =newid() WHERE OverrideVWXID Is NULL
GO

ALTER TABLE sOverrideVWX ALTER COLUMN OverrideVWXID uniqueidentifier  not null
GO

ALTER TABLE sOverrideVWX ALTER COLUMN OverrideVWXID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sOverrideVWX' )
BEGIN
    ALTER TABLE sOverrideVWX ADD CONSTRAINT PK_sOverrideVWX PRIMARY KEY CLUSTERED (OverrideVWXID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'SrvFlagEMail' )
BEGIN
    ALTER TABLE SrvFlagEMail ADD SrvFlagEMailId uniqueidentifier
END
GO

ALTER TABLE SrvFlagEMail ADD CONSTRAINT DF_sOverrideVWX_SrvFlagEMailId DEFAULT newid() FOR SrvFlagEMailId
GO

UPDATE SrvFlagEMail SET SrvFlagEMailId =newid() WHERE SrvFlagEMailId Is NULL
GO

ALTER TABLE SrvFlagEMail ALTER COLUMN SrvFlagEMailId uniqueidentifier  not null
GO

ALTER TABLE SrvFlagEMail ALTER COLUMN SrvFlagEMailId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'SrvFlagEMail' )
BEGIN
    ALTER TABLE SrvFlagEMail ADD CONSTRAINT PK_SrvFlagEMail PRIMARY KEY CLUSTERED (SrvFlagEMailId)
END
GO



IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'SrvSynchronize' )
BEGIN
    ALTER TABLE SrvSynchronize ADD SrvSynchronizeId uniqueidentifier
END
GO

ALTER TABLE SrvSynchronize ADD CONSTRAINT DF_SrvSynchronize_SrvSynchronizeId DEFAULT newid() FOR SrvSynchronizeId
GO

UPDATE SrvSynchronize SET SrvSynchronizeId =newid() WHERE SrvSynchronizeId Is NULL
GO

ALTER TABLE SrvSynchronize ALTER COLUMN SrvSynchronizeId uniqueidentifier  not null
GO

ALTER TABLE SrvSynchronize ALTER COLUMN SrvSynchronizeId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'SrvSynchronize' )
BEGIN
    ALTER TABLE SrvSynchronize ADD CONSTRAINT PK_SrvSynchronize PRIMARY KEY CLUSTERED (SrvSynchronizeId)
END
GO



IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sSystemClientSetting' )
BEGIN
    ALTER TABLE sSystemClientSetting ADD SystemClientSettingId uniqueidentifier
END
GO

ALTER TABLE sSystemClientSetting ADD CONSTRAINT DF_sSystemClientSetting_SystemClientSettingId DEFAULT newid() FOR SystemClientSettingId
GO

UPDATE sSystemClientSetting SET SystemClientSettingId =newid() WHERE SystemClientSettingId Is NULL
GO

ALTER TABLE sSystemClientSetting ALTER COLUMN SystemClientSettingId uniqueidentifier  not null
GO

ALTER TABLE sSystemClientSetting ALTER COLUMN SystemClientSettingId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sSystemClientSetting' )
BEGIN
    ALTER TABLE sSystemClientSetting ADD CONSTRAINT PK_sSystemClientSetting PRIMARY KEY CLUSTERED (SystemClientSettingId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sSystemFileServer' )
BEGIN
    ALTER TABLE sSystemFileServer ADD CONSTRAINT PK_sSystemFileServer PRIMARY KEY CLUSTERED (FileServerId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sVersion' )
BEGIN
    ALTER TABLE sVersion ADD sVersionId uniqueidentifier
END
GO

ALTER TABLE sVersion ADD CONSTRAINT DF_sVersion_sVersionId DEFAULT newid() FOR sVersionId
GO

UPDATE sVersion SET sVersionId =newid() WHERE sVersionId Is NULL
GO

ALTER TABLE sVersion ALTER COLUMN sVersionId uniqueidentifier  not null
GO

ALTER TABLE sVersion ALTER COLUMN sVersionId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'sVersion' )
BEGIN
    ALTER TABLE sVersion ADD CONSTRAINT PK_sVersion PRIMARY KEY CLUSTERED (sVersionId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'TimeZone' )
BEGIN
    ALTER TABLE TimeZone ADD TimeZoneId uniqueidentifier
END
GO

ALTER TABLE TimeZone ADD CONSTRAINT DF_TimeZone_TimeZoneId DEFAULT newid() FOR TimeZoneId
GO

UPDATE TimeZone SET TimeZoneId =newid() WHERE TimeZoneId Is NULL
GO

ALTER TABLE TimeZone ALTER COLUMN TimeZoneId uniqueidentifier  not null
GO

ALTER TABLE TimeZone ALTER COLUMN TimeZoneId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'TimeZone' )
BEGIN
    ALTER TABLE TimeZone ADD CONSTRAINT PK_TimeZone PRIMARY KEY CLUSTERED (TimeZoneId)
END
GO


ALTER TABLE tIssue ADD CONSTRAINT DF_tIssue_IssueId DEFAULT newid() FOR IssueId
GO

UPDATE tIssue SET IssueId =newid() WHERE IssueId Is NULL
GO

ALTER TABLE tIssue ALTER COLUMN IssueId uniqueidentifier  not null
GO

ALTER TABLE tIssue ALTER COLUMN IssueId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type ='Primary Key'
                                   AND table_name = 'tIssue' )
BEGIN
    ALTER TABLE tIssue ADD CONSTRAINT PK_tIssue PRIMARY KEY CLUSTERED (IssueId)
END
GO


ALTER TABLE tIssueItem ADD CONSTRAINT DF_tIssueItem_IssueItemId DEFAULT newid() FOR IssueItemId
GO

UPDATE tIssueItem SET IssueItemId =newid() WHERE IssueItemId Is NULL
GO

ALTER TABLE tIssueItem ALTER COLUMN IssueItemId uniqueidentifier  not null
GO

ALTER TABLE tIssueItem ALTER COLUMN IssueItemId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tIssueItem' )
BEGIN
    ALTER TABLE tIssueItem ADD CONSTRAINT PK_tIssueItem PRIMARY KEY CLUSTERED (IssueItemId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorway' )
BEGIN
    ALTER TABLE tmpStyleColorway ADD tmpStyleColorwayId uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorway ADD CONSTRAINT DF_tmpStyleColorway_tmpStyleColorwayId DEFAULT newid() FOR tmpStyleColorwayId
GO

UPDATE tmpStyleColorway SET tmpStyleColorwayId =newid() WHERE tmpStyleColorwayId Is NULL
GO

ALTER TABLE tmpStyleColorway ALTER COLUMN tmpStyleColorwayId uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorway ALTER COLUMN tmpStyleColorwayId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorway' )
BEGIN
    ALTER TABLE tmpStyleColorway ADD CONSTRAINT PK_tmpStyleColorway PRIMARY KEY CLUSTERED (tmpStyleColorwayId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayAvail' )
BEGIN
    ALTER TABLE tmpStyleColorwayAvail ADD tmpStyleColorwayAvailId uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorwayAvail ADD CONSTRAINT DF_tmpStyleColorwayAvail_tmpStyleColorwayAvailId DEFAULT newid() FOR tmpStyleColorwayAvailId
GO

UPDATE tmpStyleColorwayAvail SET tmpStyleColorwayAvailId =newid() WHERE tmpStyleColorwayAvailId Is NULL
GO

ALTER TABLE tmpStyleColorwayAvail ALTER COLUMN tmpStyleColorwayAvailId uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorwayAvail ALTER COLUMN tmpStyleColorwayAvailId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayAvail' )
BEGIN
    ALTER TABLE tmpStyleColorwayAvail ADD CONSTRAINT PK_tmpStyleColorwayAvail PRIMARY KEY CLUSTERED (tmpStyleColorwayAvailId)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayItem' )
BEGIN
    ALTER TABLE tmpStyleColorwayItem ADD tmpStyleColorwayItemId uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorwayItem ADD CONSTRAINT DF_tmpStyleColorwayItem_tmpStyleColorwayItemId DEFAULT newid() FOR tmpStyleColorwayItemId
GO

UPDATE tmpStyleColorwayItem SET tmpStyleColorwayItemId =newid() WHERE tmpStyleColorwayItemId Is NULL
GO

ALTER TABLE tmpStyleColorwayItem ALTER COLUMN tmpStyleColorwayItemId uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorwayItem ALTER COLUMN tmpStyleColorwayItemId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayItemId' )
BEGIN
    ALTER TABLE tmpStyleColorwayItem ADD CONSTRAINT PK_tmpStyleColorwayItem PRIMARY KEY CLUSTERED (tmpStyleColorwayItemId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayItemAvail' )
BEGIN
    ALTER TABLE tmpStyleColorwayItemAvail ADD tmpStyleColorwayItemAvailId uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorwayItemAvail ADD CONSTRAINT DF_tmpStyleColorwayItemAvail_tmpStyleColorwayItemAvailId DEFAULT newid() FOR tmpStyleColorwayItemAvailId
GO

UPDATE tmpStyleColorwayItemAvail SET tmpStyleColorwayItemAvailId =newid() WHERE tmpStyleColorwayItemAvailId Is NULL
GO

ALTER TABLE tmpStyleColorwayItemAvail ALTER COLUMN tmpStyleColorwayItemAvailId uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorwayItemAvail ALTER COLUMN tmpStyleColorwayItemAvailId ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayItemAvail' )
BEGIN
    ALTER TABLE tmpStyleColorwayItemAvail ADD CONSTRAINT PK_tmpStyleColorwayItemAvail PRIMARY KEY CLUSTERED (tmpStyleColorwayItemAvailId)
END
GO


IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayReplaceID' )
BEGIN
    ALTER TABLE tmpStyleColorwayReplaceID ADD tmpStyleColorwayReplaceID uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorwayReplaceID ADD CONSTRAINT DF_tmpStyleColorwayReplaceID_tmpStyleColorwayReplaceID DEFAULT newid() FOR tmpStyleColorwayReplaceID
GO

UPDATE tmpStyleColorwayReplaceID SET tmpStyleColorwayReplaceID =newid() WHERE tmpStyleColorwayReplaceID Is NULL
GO

ALTER TABLE tmpStyleColorwayReplaceID ALTER COLUMN tmpStyleColorwayReplaceID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorwayReplaceID ALTER COLUMN tmpStyleColorwayReplaceID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorwayReplaceID' )
BEGIN
    ALTER TABLE tmpStyleColorwayReplaceID ADD CONSTRAINT PK_tmpStyleColorwayReplaceID PRIMARY KEY CLUSTERED (tmpStyleColorwayReplaceID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleColorwaySeasonYear' )
BEGIN
    ALTER TABLE tmpStyleColorwaySeasonYear ADD tmpStyleColorwaySeasonYearID uniqueidentifier
END
GO


ALTER TABLE tmpStyleColorwaySeasonYear ADD CONSTRAINT DF_tmpStyleColorwaySeasonYear_tmpStyleColorwaySeasonYearID DEFAULT newid() FOR tmpStyleColorwaySeasonYearID
GO

UPDATE tmpStyleColorwaySeasonYear SET tmpStyleColorwaySeasonYearID =newid() WHERE tmpStyleColorwaySeasonYearID Is NULL
GO

ALTER TABLE tmpStyleColorwaySeasonYear ALTER COLUMN tmpStyleColorwaySeasonYearID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleColorwaySeasonYear ALTER COLUMN tmpStyleColorwaySeasonYearID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleColorwaySeasonYear' )
BEGIN
    ALTER TABLE tmpStyleColorwaySeasonYear ADD CONSTRAINT PK_tmpStyleColorwaySeasonYear PRIMARY KEY CLUSTERED (tmpStyleColorwaySeasonYearID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleHeader' )
BEGIN
    ALTER TABLE tmpStyleHeader ADD tmpStyleHeaderID uniqueidentifier
END
GO


ALTER TABLE tmpStyleHeader ADD CONSTRAINT DF_tmpStyleHeader_tmpStyleHeaderID DEFAULT newid() FOR tmpStyleHeaderID
GO

UPDATE tmpStyleHeader SET tmpStyleHeaderID =newid() WHERE tmpStyleHeaderID Is NULL
GO

ALTER TABLE tmpStyleHeader ALTER COLUMN tmpStyleHeaderID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleHeader ALTER COLUMN tmpStyleHeaderID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleHeader' )
BEGIN
    ALTER TABLE tmpStyleHeader ADD CONSTRAINT PK_tmpStyleHeader PRIMARY KEY CLUSTERED (tmpStyleHeaderID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleHeaderReplaceID' )
BEGIN
    ALTER TABLE tmpStyleHeaderReplaceID ADD tmpStyleHeaderReplaceID uniqueidentifier
END
GO


ALTER TABLE tmpStyleHeaderReplaceID ADD CONSTRAINT DF_tmpStyleHeaderReplaceID_tmpStyleHeaderReplaceID DEFAULT newid() FOR tmpStyleHeaderReplaceID
GO

UPDATE tmpStyleHeaderReplaceID SET tmpStyleHeaderReplaceID =newid() WHERE tmpStyleHeaderReplaceID Is NULL
GO

ALTER TABLE tmpStyleHeaderReplaceID ALTER COLUMN tmpStyleHeaderReplaceID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleHeaderReplaceID ALTER COLUMN tmpStyleHeaderReplaceID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleHeaderReplaceID' )
BEGIN
    ALTER TABLE tmpStyleHeaderReplaceID ADD CONSTRAINT PK_tmpStyleHeaderReplaceID PRIMARY KEY CLUSTERED (tmpStyleHeaderReplaceID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleSourcing' )
BEGIN
    ALTER TABLE tmpStyleSourcing ADD tmpStyleSourcingID uniqueidentifier
END
GO


ALTER TABLE tmpStyleSourcing ADD CONSTRAINT DF_tmpStyleSourcing_tmpStyleSourcingID DEFAULT newid() FOR tmpStyleSourcingID
GO

UPDATE tmpStyleSourcing SET tmpStyleSourcingID =newid() WHERE tmpStyleSourcingID Is NULL
GO

ALTER TABLE tmpStyleSourcing ALTER COLUMN tmpStyleSourcingID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleSourcing ALTER COLUMN tmpStyleSourcingID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleSourcing' )
BEGIN
    ALTER TABLE tmpStyleSourcing ADD CONSTRAINT PK_tmpStyleSourcing PRIMARY KEY CLUSTERED (tmpStyleSourcingID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingAvail' )
BEGIN
    ALTER TABLE tmpStyleSourcingAvail ADD tmpStyleSourcingAvailID uniqueidentifier
END
GO


ALTER TABLE tmpStyleSourcingAvail ADD CONSTRAINT DF_tmpStyleSourcingAvail_tmpStyleSourcingAvailID DEFAULT newid() FOR tmpStyleSourcingAvailID
GO

UPDATE tmpStyleSourcingAvail SET tmpStyleSourcingAvailID =newid() WHERE tmpStyleSourcingAvailID Is NULL
GO

ALTER TABLE tmpStyleSourcingAvail ALTER COLUMN tmpStyleSourcingAvailID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleSourcingAvail ALTER COLUMN tmpStyleSourcingAvailID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingAvail' )
BEGIN
    ALTER TABLE tmpStyleSourcingAvail ADD CONSTRAINT PK_tmpStyleSourcingAvail PRIMARY KEY CLUSTERED (tmpStyleSourcingAvailID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingItem' )
BEGIN
    ALTER TABLE tmpStyleSourcingItem ADD tmpStyleSourcingItemID uniqueidentifier
END
GO

ALTER TABLE tmpStyleSourcingItem ADD CONSTRAINT DF_tmpStyleSourcingItem_tmpStyleSourcingItemID DEFAULT newid() FOR tmpStyleSourcingItemID
GO

UPDATE tmpStyleSourcingItem SET tmpStyleSourcingItemID =newid() WHERE tmpStyleSourcingItemID Is NULL
GO

ALTER TABLE tmpStyleSourcingItem ALTER COLUMN tmpStyleSourcingItemID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleSourcingItem ALTER COLUMN tmpStyleSourcingItemID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingItem' )
BEGIN
    ALTER TABLE tmpStyleSourcingItem ADD CONSTRAINT PK_tmpStyleSourcingItem PRIMARY KEY CLUSTERED (tmpStyleSourcingItemID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingItemAvail' )
BEGIN
    ALTER TABLE tmpStyleSourcingItemAvail ADD tmpStyleSourcingItemAvailID uniqueidentifier
END
GO

ALTER TABLE tmpStyleSourcingItemAvail ADD CONSTRAINT DF_tmpStyleSourcingItemAvail_tmpStyleSourcingItemAvailID DEFAULT newid() FOR tmpStyleSourcingItemAvailID
GO

UPDATE tmpStyleSourcingItemAvail SET tmpStyleSourcingItemAvailID =newid() WHERE tmpStyleSourcingItemAvailID Is NULL
GO

ALTER TABLE tmpStyleSourcingItemAvail ALTER COLUMN tmpStyleSourcingItemAvailID uniqueidentifier  not null
GO

ALTER TABLE tmpStyleSourcingItemAvail ALTER COLUMN tmpStyleSourcingItemAvailID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tmpStyleSourcingItemAvail' )
BEGIN
    ALTER TABLE tmpStyleSourcingItemAvail ADD CONSTRAINT PK_tmpStyleSourcingItemAvail PRIMARY KEY CLUSTERED (tmpStyleSourcingItemAvailID)
END
GO

ALTER TABLE tTask ADD CONSTRAINT DF_tTask_TaskID DEFAULT newid() FOR TaskID
GO

UPDATE tTask SET TaskID =newid() WHERE TaskID Is NULL
GO

ALTER TABLE tTask ALTER COLUMN TaskID uniqueidentifier  not null
GO

ALTER TABLE tTask ALTER COLUMN TaskID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tTask' )
BEGIN
    ALTER TABLE tTask ADD CONSTRAINT PK_tTask PRIMARY KEY CLUSTERED (TaskID)
END
GO

ALTER TABLE tTaskDocument ADD CONSTRAINT DF_tTaskDocument_tTaskDocumentID DEFAULT newid() FOR TaskDocumentID
GO

UPDATE tTaskDocument SET TaskDocumentID =newid() WHERE TaskDocumentID Is NULL
GO

ALTER TABLE tTaskDocument ALTER COLUMN TaskDocumentID uniqueidentifier  not null
GO

ALTER TABLE tTaskDocument ALTER COLUMN TaskDocumentID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tTaskDocument' )
BEGIN
    ALTER TABLE tTaskDocument ADD CONSTRAINT PK_tTaskDocument PRIMARY KEY CLUSTERED (TaskDocumentID)
END
GO

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type = N'Primary Key'
                                   AND table_name = N'tTaskEvent' )
BEGIN
    ALTER TABLE tTaskEvent ADD TaskEventID uniqueidentifier
END
GO

ALTER TABLE tTaskEvent ADD CONSTRAINT DF_tTaskEvent_TaskEventID DEFAULT newid() FOR TaskEventID
GO

UPDATE tTaskEvent SET TaskEventID =newid() WHERE TaskEventID Is NULL
GO

ALTER TABLE tTaskEvent ALTER COLUMN TaskEventID uniqueidentifier  not null
GO

ALTER TABLE tTaskEvent ALTER COLUMN TaskEventID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tTaskEvent' )
BEGIN
    ALTER TABLE tTaskEvent ADD CONSTRAINT PK_tTaskEvent PRIMARY KEY CLUSTERED (TaskEventID)
END
GO

ALTER TABLE tTaskWorkFlowEvent ADD CONSTRAINT DF_TaskWorkFlowEvent_TaskWorkFlowEventID DEFAULT newid() FOR TaskWorkFlowEventID
GO

UPDATE tTaskWorkFlowEvent SET TaskWorkFlowEventID =newid() WHERE TaskWorkFlowEventID Is NULL
GO

ALTER TABLE tTaskWorkFlowEvent ALTER COLUMN TaskWorkFlowEventID uniqueidentifier  not null
GO

ALTER TABLE tTaskWorkFlowEvent ALTER COLUMN TaskWorkFlowEventID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'tTaskWorkFlowEvent' )
BEGIN
    ALTER TABLE tTaskWorkFlowEvent ADD CONSTRAINT PK_tTaskWorkFlowEvent PRIMARY KEY CLUSTERED (TaskWorkFlowEventID)
END
GO

ALTER TABLE uPageUsageLogID ADD CONSTRAINT DF_uPageUsageLogID_PageUsageLogID DEFAULT newid() FOR PageUsageLogID
GO

UPDATE uPageUsageLogID SET PageUsageLogID =newid() WHERE PageUsageLogID Is NULL
GO

ALTER TABLE uPageUsageLogID ALTER COLUMN PageUsageLogID uniqueidentifier  not null
GO

ALTER TABLE uPageUsageLogID ALTER COLUMN PageUsageLogID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'uPageUsageLogID' )
BEGIN
    ALTER TABLE uPageUsageLogID ADD CONSTRAINT PK_uPageUsageLogID PRIMARY KEY CLUSTERED (PageUsageLogID)
END
GO

ALTER TABLE uUserGroup ALTER COLUMN UserGroupID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'uUserGroup' )
BEGIN
    ALTER TABLE uUserGroup ADD CONSTRAINT PK_uUserGroup PRIMARY KEY CLUSTERED (UserGroupID)
END
GO

ALTER TABLE xCustom13 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom13' )
BEGIN
    ALTER TABLE xCustom13 ADD CONSTRAINT PK_xCustom13 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom14 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom14' )
BEGIN
    ALTER TABLE xCustom14 ADD CONSTRAINT PK_xCustom14 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom15 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom15' )
BEGIN
    ALTER TABLE xCustom15 ADD CONSTRAINT PK_xCustom15 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom16 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom16' )
BEGIN
    ALTER TABLE xCustom16 ADD CONSTRAINT PK_xCustom16 PRIMARY KEY CLUSTERED (CustomID)
END
GO


ALTER TABLE xCustom12 DROP CONSTRAINT PK_XCustom17
GO 

ALTER TABLE xCustom12 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO
IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom12' )
BEGIN
    ALTER TABLE xCustom12 ADD CONSTRAINT PK_xCustom12 PRIMARY KEY CLUSTERED (CustomID)
END
GO


ALTER TABLE xCustom17 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom17' )
BEGIN
    ALTER TABLE xCustom17 ADD CONSTRAINT PK_xCustom17 PRIMARY KEY CLUSTERED (CustomID)
END
GO


ALTER TABLE xCustom18 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom18')
BEGIN
    ALTER TABLE xCustom18 ADD CONSTRAINT PK_xCustom18 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom19 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom19')
BEGIN
    ALTER TABLE xCustom19 ADD CONSTRAINT PK_xCustom19 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom22 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom22')
BEGIN
    ALTER TABLE xCustom22 ADD CONSTRAINT PK_xCustom22 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom23 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom23')
BEGIN
    ALTER TABLE xCustom23 ADD CONSTRAINT PK_xCustom23 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom24 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom24')
BEGIN
    ALTER TABLE xCustom24 ADD CONSTRAINT PK_xCustom24 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom3 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom3')
BEGIN
    ALTER TABLE xCustom3 ADD CONSTRAINT PK_xCustom3 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE xCustom5 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom5')
BEGIN
    ALTER TABLE xCustom5 ADD CONSTRAINT PK_xCustom5 PRIMARY KEY CLUSTERED (CustomID)
END
GO


ALTER TABLE xCustom4 ADD CONSTRAINT DF_xCustom4_CustomID DEFAULT newid() FOR CustomID
GO

UPDATE xCustom4 SET CustomID =newid() WHERE CustomID Is NULL
GO

ALTER TABLE xCustom4 ALTER COLUMN CustomID uniqueidentifier  not null
GO

ALTER TABLE xCustom4 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom4')
BEGIN
    ALTER TABLE xCustom4 ADD CONSTRAINT PK_xCustom4 PRIMARY KEY CLUSTERED (CustomID)
END
GO

UPDATE xCustom99 SET CustomID =newid() WHERE CustomID Is NULL
GO

-- ALTER TABLE xCustom99 ALTER COLUMN CustomID DROP ROWGUIDCOL
-- GO

ALTER TABLE xCustom99 ALTER COLUMN CustomID uniqueidentifier  not null
GO

ALTER TABLE xCustom99 ALTER COLUMN CustomID ADD ROWGUIDCOL
GO 

IF NOT EXISTS ( SELECT TABLE_NAME FROM information_schema.table_constraints
                                 WHERE constraint_type =N'Primary Key'
                                   AND table_name = N'xCustom99')
BEGIN
    ALTER TABLE xCustom99 ADD CONSTRAINT PK_xCustom99 PRIMARY KEY CLUSTERED (CustomID)
END
GO

ALTER TABLE pLinePlanStyleLinkedTemp ADD LinePlanStyleLinkedTempId uniqueidentifier NULL
GO

ALTER TABLE pLinePlanStyleLinkedTemp 
      ADD CONSTRAINT DF_pLinePlanStyleLinkedTemp_LinePlanStyleLinkedTempId DEFAULT NewId() FOR LinePlanStyleLinkedTempId
GO

UPDATE pLinePlanStyleLinkedTemp
   SET LinePlanStyleLinkedTempId = NewId()
WHERE LinePlanStyleLinkedTempId Is NULL
GO

ALTER TABLE pLinePlanStyleLinkedTemp ALTER COLUMN LinePlanStyleLinkedTempId uniqueidentifier NOT NULL
GO

ALTER TABLE pLinePlanStyleLinkedTemp ADD CONSTRAINT PK_pLinePlanStyleLinkedTemp PRIMARY KEY CLUSTERED (LinePlanStyleLinkedTempId)
GO


ALTER TABLE pSampleRequestWorkflowStatusSchema ADD SampleRequestWorkFlowStatusSchemaId uniqueidentifier NULL
GO


ALTER TABLE pSampleRequestWorkflowStatusSchema ADD CONSTRAINT
	DF_pSampleRequestWorkflowStatusSchema_SampleRequestWorkFlowStatusSchemaId DEFAULT NewId() FOR SampleRequestWorkFlowStatusSchemaId
GO

UPDATE pSampleRequestWorkflowStatusSchema
   SET SampleRequestWorkFlowStatusSchemaId = NewId()
WHERE SampleRequestWorkFlowStatusSchemaId Is NULL
GO

ALTER TABLE  pSampleRequestWorkflowStatusSchema ALTER COLUMN SampleRequestWorkFlowStatusSchemaId uniqueidentifier NOT NULL
GO

ALTER TABLE  pSampleRequestWorkflowStatusSchema ADD CONSTRAINT PK_SampleRequestWorkFlowStatusSchemaId PRIMARY KEY CLUSTERED (SampleRequestWorkFlowStatusSchemaId)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01411', GETDATE())
GO