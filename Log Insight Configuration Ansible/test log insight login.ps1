<#
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
#>

#curl -k -X POST https://192.168.34.15:9543/api/v1/sessions -d '{"username":"admin","password":"Computer@1","provider":"Local"}' --noproxy '*'

$uri = 'https://192.168.34.15:9543/api/v1/sessions'
$body = @{"username"="admin";"password"="Computer@1";"provider"="Local"}

$info = Invoke-WebRequest -Uri $uri -Method POST -Body ($body | ConvertTo-Json) -ContentType "application/json" 

<#
$loginPage = Invoke-WebRequest "http:\\website.com\" # invoke login form page
$loginForm = $loginPage.Forms[0] # Get the form to fill
$loginForm.fields["userName"] = "usrnm" # fill the username
$loginForm.fields["password"] = "psswd" # fill the password
$loginPage = Invoke-WebRequest -Uri ("http:\\website.com\") -Method POST -Body $loginForm.fields # Post the form to log-in
#>