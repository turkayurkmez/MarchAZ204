using Microsoft.Extensions.Configuration.AzureAppConfiguration;
using Microsoft.FeatureManagement;

var builder = WebApplication.CreateBuilder(args);
builder.Configuration.AddUserSecrets<Program>();
var connectionString = builder.Configuration.GetConnectionString("AppConfig");
builder.Host.ConfigureAppConfiguration((hostingContext, builder) =>
{
    builder.AddAzureAppConfiguration(option =>
    {
        option.Connect(connectionString)
        .UseFeatureFlags(option => option.Select("demofeature", hostingContext.HostingEnvironment.EnvironmentName)
        )
        .ConfigureRefresh(refreshOpt => refreshOpt.Register("demofeature"))
        .Select(KeyFilter.Any, hostingContext.HostingEnvironment.EnvironmentName);

    });
});

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddAzureAppConfiguration()
                .AddFeatureManagement();

var app = builder.Build();


// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseAzureAppConfiguration();
app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();
