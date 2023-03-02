using Microsoft.Identity.Client;
// See https://aka.ms/new-console-template for more information
const string _clientId ="62ef295f-fe61-4690-9afb-9eceb5f0740d";
const string _tenantId ="714700c6-10e2-4ca4-b315-06d7fe91ee94";

var app = PublicClientApplicationBuilder
    .Create(_clientId)
    .WithAuthority(AzureCloudInstance.AzurePublic, _tenantId)
    .WithRedirectUri("http://localhost")
    .Build();

string[] scopes = { "User.Read","Calendars.Read" };

AuthenticationResult result = await app.AcquireTokenInteractive(scopes).ExecuteAsync();

Console.WriteLine($"ID:\n{result.IdToken}");
Console.WriteLine($"Access:\n{result.AccessToken}");

