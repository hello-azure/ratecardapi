clear

# 说明：参考官方RATE CARE API定义：https://msdn.microsoft.com/en-us/library/azure/mt219004.aspx

# 订阅ID
$subscriptionId ="e0fbea86-6cf2-4b2d-81e2-9c59f4f96bcb"

# API版本：支持 2015-06-01-preview、2016-08-31-preview两个值，参考：https://msdn.microsoft.com/en-us/library/azure/mt219005.aspx         
$apiVersion = "2016-08-31-preview";

# 我们请求的方RATE CARE API中有一个参数包含了一个$特殊字符，而这个特殊字符是powershell内置字符定义变量使用，因此我们要做转义，使用`进行转义
$filterPara ="`$filter"

# 这个参数值参考官方的示例设定，如需要请求其它类型数据，参考：https://msdn.microsoft.com/en-us/library/azure/mt219004.aspx中的其它示例，如'MS-AZR-0003p'
$filter = "MS-MC-AZR-0033P";

# 这个参数同上参考其它示例
$currency = "CNY";

# 这个参数同上参考其它示例
$locale = "en-US";

# 这个参数同上参考其它示例
$regionInfo = "CN";

# 格式化请求的URL：第一点从官网拷贝的URL请求终结点是https://management.azure.com，我们需要修改为China的地址为：https://management.chinacloudapi.cn。
# 格式化请求的URL：第二点从官网拷贝的URL中$filter与Powershell存在字符冲突，参考$filterPara ="`$filter"进行转义。
# 格式化请求的URL：第三点从官网拷贝的URL中包含空格符，我们需要使用%20替换URL中所有的空格符
# 格式化请求的URL：第四点从官网拷贝的URL中包含非法字符’，将其替换为'
$httpUri =  [string]::Format("https://management.chinacloudapi.cn/subscriptions/{0}/providers/Microsoft.Commerce/RateCard?api-version={1}&{2}=OfferDurableId eq ’{3}’ and Currency eq ’{4}’ and Locale eq ’{5}’ and RegionInfo eq ’{6}’",$subscriptionId,$apiVersion,$filterPara,$filter,$currency,$locale,$regionInfo)
$httpUri = $httpUri.Replace(" ","%20").Replace("’","'")

# 关于基于AD认证头信息可以在登录https://portal.azure.cn网站后，通过Chorme等浏览器查看HTTP请求-Network-Select 的Authorization来获取，具体参考之前的说明
$basicAuthValue = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ijd3WDgxVFhFMG1hV1U3bWtKeU1jZENHVDFrUSIsImtpZCI6Ijd3WDgxVFhFMG1hV1U3bWtKeU1jZENHVDFrUSJ9.eyJhdWQiOiJodHRwczovL21hbmFnZW1lbnQuY29yZS5jaGluYWNsb3VkYXBpLmNuLyIsImlzcyI6Imh0dHBzOi8vc3RzLmNoaW5hY2xvdWRhcGkuY24vYjM4OGI4MDgtMGVjOS00YTA5LWE0MTQtYTdjYmJkOGI3ZTliLyIsImlhdCI6MTQ4NzkyMzU4NywibmJmIjoxNDg3OTIzNTg3LCJleHAiOjE0ODc5Mjc0ODcsImFjciI6IjEiLCJhaW8iOiJBUUFCQUFFQUFBQ3JIS3ZyeDdHMlNhWmJaaC10RG5wNzhWcTlINWZ5NXNVV0N6T0UyLXlXbl8xQnpibUxUc190M0FUbGdzQmNuUjVTdm5sNUhaY3k5NUN1QXZrQXpqTWRjZUlIQzgya3paX3VtYmlGTURCZmRQZTBmcDY5dXg5SUMyVzU2RmR1TnpXZjMyRHYyODNCT2Y4aFg0OTc3VGMySUFBIiwiYW1yIjpbInB3ZCJdLCJhcHBpZCI6ImM0NGI0MDgzLTNiYjAtNDljMS1iNDdkLTk3NGU1M2NiZGYzYyIsImFwcGlkYWNyIjoiMiIsImVfZXhwIjoxMDgwMCwiZmFtaWx5X25hbWUiOiJUZXN0MDMiLCJnaXZlbl9uYW1lIjoiQ0lFIiwiaXBhZGRyIjoiMTA2LjEyMC43OC4xOTAiLCJuYW1lIjoiQ0lFIFRlc3QwMyIsIm9pZCI6Ijc2ODY5NmJiLWFiNWUtNDRjNi04ZTFiLTcxMjJiNjFiNWU4MSIsInBsYXRmIjoiMyIsInB1aWQiOiIyMDAzM0ZGRjgwMDFCOUQwIiwic2NwIjoidXNlcl9pbXBlcnNvbmF0aW9uIiwic3ViIjoiZllWRGNEdEpPOWpxNjRVSWVTS2h2dzctWHdTUmo4bDlyMm9nelJFWTBSWSIsInRpZCI6ImIzODhiODA4LTBlYzktNGEwOS1hNDE0LWE3Y2JiZDhiN2U5YiIsInVuaXF1ZV9uYW1lIjoiQ0lFVGVzdDAzQE1pY3Jvc29mdEludGVybmFsLnBhcnRuZXIub25tc2NoaW5hLmNuIiwidXBuIjoiQ0lFVGVzdDAzQE1pY3Jvc29mdEludGVybmFsLnBhcnRuZXIub25tc2NoaW5hLmNuIiwidmVyIjoiMS4wIn0.Vm1dTkpxFyIeEKZrhkjkGKJMZSMaz6uzc0rMHFEloUJThoTzjPPaRSuQHx5nzQVZOmrHo5vrTxmr0hRvLONnKferEtIlQuSJCpJgenLvFhNA5GjYJBhrebMGhePXi3thE4q3dVe50CuCuCg4sh5kg1I-vjESBrupIW7X1t712oZxc_l81u-tSbw08aG72uSw2s6Bp4zQ473_47dqCCgfKNol_qMW66cI8QrJW2pUL9OQPqbwPTKvFz-v3KeSIn_Y4L0044PZbaZLrvi3P4oOIB_3unO_FLw3XXP62KrxJTBKPgFe4BtOFwl8g9mPIfrmRT5Hok6Q13M8EomcV0OzAg"
$headers = @{ Authorization = $basicAuthValue }

# 执行请求，获取账单信息，存储到本地文件。这个数据是JSON格式的，如果希望更好的展现还需要应用化处理
$res = Invoke-WebRequest -Uri $httpUri -Headers $headers -Method Get -ContentType "application/json" -OutFile E:\response.txt



