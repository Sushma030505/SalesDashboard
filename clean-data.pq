let
    // 1. READ CSV FILE
    Source = Csv.Document(File.Contents("sales-data.csv")),
    
    // 2. MAKE FIRST ROW HEADERS
    PromotedHeaders = Table.PromoteHeaders(Source),
    
    // 3. CHANGE DATA TYPES
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders,{
        {"Date", type date}, 
        {"Amount", Currency.Type},
        {"Profit", Currency.Type},
        {"Quantity", Int64.Type}
    }),
    
    // 4. REMOVE BAD ROWS
    CleanData = Table.SelectRows(ChangedTypes, each [Amount] > 0)
in
    CleanData
