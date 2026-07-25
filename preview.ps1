$root = [IO.Path]::GetFullPath((Split-Path -Parent $MyInvocation.MyCommand.Path))
$listener = [Net.HttpListener]::new()
$listener.Prefixes.Add('http://localhost:8787/')
$listener.Start()
Start-Process 'http://localhost:8787/index.html'
Write-Host "Local preview started: http://localhost:8787/index.html"
Write-Host "Close this window to stop the preview."

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    $relative = [Uri]::UnescapeDataString($context.Request.Url.AbsolutePath.TrimStart('/')).Replace('/', '\')
    if ([string]::IsNullOrWhiteSpace($relative)) { $relative = 'index.html' }
    $file = [IO.Path]::GetFullPath((Join-Path $root $relative))
    if (-not $file.StartsWith($root + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $file -PathType Leaf)) {
      $context.Response.StatusCode = 404
      $context.Response.Close()
      continue
    }
    $types = @{ '.html'='text/html; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.js'='text/javascript; charset=utf-8'; '.json'='application/json; charset=utf-8'; '.jpg'='image/jpeg'; '.jpeg'='image/jpeg'; '.png'='image/png'; '.webp'='image/webp'; '.svg'='image/svg+xml' }
    $extension = [IO.Path]::GetExtension($file).ToLower()
    if ($types.ContainsKey($extension)) {
      $context.Response.ContentType = $types[$extension]
    } else {
      $context.Response.ContentType = 'application/octet-stream'
    }
    $bytes = [IO.File]::ReadAllBytes($file)
    $context.Response.ContentLength64 = $bytes.Length
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
  }
} finally {
  $listener.Stop()
  $listener.Close()
}
