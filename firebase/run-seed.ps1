# Script to run seed against Firestore emulator
# Usage: .\run-seed.ps1

Write-Host "🚀 Starting Firestore Emulator and Seed Script..." -ForegroundColor Green
Write-Host ""

# Start Firestore emulator in background
Write-Host "📦 Starting Firestore emulator..." -ForegroundColor Cyan
$emulator = Start-Process -FilePath "firebase" -ArgumentList "emulators:start", "--only", "firestore" -PassThru -NoNewWindow

# Wait for emulator to be ready
Write-Host "⏳ Waiting for emulator to start (10 seconds)..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

try {
    # Run seed script
    Write-Host ""
    Write-Host "🌱 Running seed script..." -ForegroundColor Cyan
    Set-Location ".\functions"
    npm run seed
    
    Write-Host ""
    Write-Host "✅ Seed completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 View data in Emulator UI: http://127.0.0.1:4000/firestore" -ForegroundColor Cyan
    Write-Host ""
    
} finally {
    # Stop emulator
    Write-Host "🛑 Stopping emulator..." -ForegroundColor Yellow
    Stop-Process -Id $emulator.Id -Force
    Write-Host "✅ Emulator stopped" -ForegroundColor Green
}
