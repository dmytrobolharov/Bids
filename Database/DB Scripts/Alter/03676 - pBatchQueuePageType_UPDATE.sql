UPDATE [dbo].[pBatchQueuePageType]
SET BatchQueuepageXMLGridAlternating='BatchQ_Material_SingleSeasonalImage_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_Material_SingleSeasonalImage_Thumbnail.xml'
WHERE BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00008'
GO

UPDATE [dbo].[pBatchQueuePageType]
SET BatchQueuepageXMLGridAlternating='BatchQ_Material_SingleSeasonalImage_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_Material_SingleSeasonalImage_Thumbnail.xml'
WHERE BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00009'
GO

UPDATE [dbo].[pBatchQueuePageType]
SET BatchQueuepageXMLGridAlternating='BatchQ_Material_SingleSeasonalImage_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_Material_SingleSeasonalImage_Thumbnail.xml'
WHERE BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00010'
GO

UPDATE [dbo].[pBatchQueuePageType]
SET BatchQueuepageXMLGridAlternating='BatchQ_Material_SingleSeasonalImage_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_Material_SingleSeasonalImage_Thumbnail.xml'
WHERE BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00011'
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03676', GetDate())
GO