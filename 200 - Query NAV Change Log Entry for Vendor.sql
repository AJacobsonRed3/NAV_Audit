-- Almost all my customers have multiple reports. So my queries rely on multi-company views in my reporting database.  I've walked through how to create these both in blog posts and on Github.  I'm just specifying the 'Company' I'm using.
DECLARE @Company VARCHAR(20) = 'RED'
SELECT 
       cle.[Date and Time],
       cle.[User ID], 
       cle.[Table No_],
	   obj.Name AS TableName, -- see 2 below
	   ven.Name AS CurrentVendorName , -- see 6 below
       cle.[Field No_],
	   nfn.FieldName, -- see 3 below
       cle.[Type of Change],
	   nfo.OptionName, -- see 4 below
       cle.[Old Value],
	   cle.[New Value],
       cle.[Primary Key Field 1 No_],
	   pk1.FieldName -- see 5 below

FROM dbo.[vNAV_Change Log Entry] cle
-- 2) Get the Table Name
JOIN dbo.vObject obj
ON cle.[Table No_] = obj.ID
AND 1 = obj.Type
-- 3) The field Name inserted or modified by this entry
JOIN dbo.NAVFieldNames nfn
ON cle.[Table No_] = nfn.TableNo
AND cle.[Field No_] = nfn.FieldNo
-- 4) Translate "Type of Change' integer to a name (Either insert or modify)
JOIN dbo.NAVFieldOptions nfo
ON 'Change Log Entry' = nfo.TableName
AND 'Type of Change' = nfo.FieldName
AND cle.[Type of Change] = nfo.OptionNo
-- 5) The primary keykey field used in the file being tracked.  Note in the vendor example, we only have one field used as a primary key.  Other Tables (like Sales Price) have multiple keys so you'd have to join multiple times) 
JOIN dbo.NAVFieldNames pk1
ON cle.[Table No_] = pk1.TableNo
AND cle.[Primary Key Field 1 No_] = pk1.FieldNo
-- 6) Sometimes we don't change the name field. But it's always useful to see which Vendor we are changing
JOIN dbo.vNAV_Vendor ven
ON cle.Company = ven.Company
AND cle.[Primary Key Field 1 Value] = ven.No_
WHERE @Company = cle.Company
AND cle.[Table No_] = 23
AND cle.[Primary Key Field 1 Value] = '28570'
AND CAST(cle.[Date and Time] AS DATE) = '20161103'


